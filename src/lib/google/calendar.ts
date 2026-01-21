import { createClient } from "@/lib/supabase/server";

/**
 * Representa um participante do evento no Google Calendar
 */
export interface GoogleCalendarAttendee {
  email: string;
  displayName?: string;
  responseStatus?: "needsAction" | "declined" | "tentative" | "accepted";
  optional?: boolean;
}

interface GoogleCalendarEvent {
  summary: string;
  description?: string;
  location?: string;
  start: {
    dateTime?: string;
    date?: string;
    timeZone: string;
  };
  end: {
    dateTime?: string;
    date?: string;
    timeZone: string;
  };
  colorId?: string;
  attendees?: GoogleCalendarAttendee[];
}

interface GoogleTokens {
  access_token: string;
  refresh_token?: string;
  expires_at?: number;
}

// Cor fixa para todos os eventos: Rosa Pink (Flamingo)
// Cores disponíveis no Google Calendar:
// "1": Lavanda, "2": Verde Sálvia, "3": Uva/Roxo, "4": Rosa/Pink (Flamingo)
// "5": Amarelo, "6": Laranja, "7": Azul Pavão, "8": Grafite
// "9": Azul, "10": Verde Manjericão, "11": Vermelho
const GOOGLE_CALENDAR_EVENT_COLOR = "4"; // Rosa Pink (Flamingo)

/**
 * Renova o access token do Google usando o refresh token
 */
async function refreshGoogleToken(refreshToken: string): Promise<{ access_token: string; expires_in: number } | null> {
  try {
    const clientId = process.env.NEXT_PUBLIC_GOOGLE_CLIENT_ID;
    const clientSecret = process.env.GOOGLE_CLIENT_SECRET;

    if (!clientId || !clientSecret) {
      console.error("NEXT_PUBLIC_GOOGLE_CLIENT_ID ou GOOGLE_CLIENT_SECRET não configurados");
      return null;
    }

    const response = await fetch("https://oauth2.googleapis.com/token", {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: new URLSearchParams({
        client_id: clientId,
        client_secret: clientSecret,
        refresh_token: refreshToken,
        grant_type: "refresh_token",
      }),
    });

    if (!response.ok) {
      const error = await response.json();
      console.error("Erro ao renovar token do Google:", error);
      return null;
    }

    const data = await response.json();
    return {
      access_token: data.access_token,
      expires_in: data.expires_in || 3600,
    };
  } catch (error) {
    console.error("Erro ao renovar token do Google:", error);
    return null;
  }
}

/**
 * Obtém os tokens do Google do usuário autenticado
 * Busca do banco de dados e renova se expirado
 */
async function getGoogleTokens(): Promise<GoogleTokens | null> {
  const supabase = await createClient();
  
  // Obter usuário atual
  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) {
    console.error("Usuário não autenticado");
    return null;
  }

  // Buscar tokens do banco de dados
  const { data: userData, error } = await supabase
    .from("users")
    .select("google_access_token, google_refresh_token, google_token_expires_at")
    .eq("id", user.id)
    .single();

  if (error || !userData?.google_access_token) {
    console.error("Usuário não possui token do Google armazenado");
    return null;
  }

  const { google_access_token, google_refresh_token, google_token_expires_at } = userData;

  // Verificar se o token expirou (com margem de 5 minutos)
  const expiresAt = google_token_expires_at ? new Date(google_token_expires_at) : null;
  const isExpired = expiresAt && expiresAt.getTime() < Date.now() + 5 * 60 * 1000;

  if (isExpired && google_refresh_token) {
    // Tentar renovar o token
    const newTokens = await refreshGoogleToken(google_refresh_token);
    
    if (newTokens) {
      // Atualizar tokens no banco
      const newExpiresAt = new Date(Date.now() + newTokens.expires_in * 1000);
      
      await supabase
        .from("users")
        .update({
          google_access_token: newTokens.access_token,
          google_token_expires_at: newExpiresAt.toISOString(),
        })
        .eq("id", user.id);

      return {
        access_token: newTokens.access_token,
        refresh_token: google_refresh_token,
      };
    } else {
      console.error("Não foi possível renovar o token do Google");
      return null;
    }
  }

  return {
    access_token: google_access_token,
    refresh_token: google_refresh_token || undefined,
  };
}

/**
 * Cria um evento no Google Calendar
 */
export async function createGoogleCalendarEvent(event: {
  nome: string;
  descricao?: string | null;
  local?: string | null;
  endereco?: string | null;
  data_inicio: string;
  data_fim?: string | null;
  hora_inicio?: string | null;
  hora_fim?: string | null;
  tipo?: string | null;
}): Promise<{ id: string | null; error: string | null }> {
  try {
    const tokens = await getGoogleTokens();
    
    if (!tokens) {
      return { id: null, error: "Token do Google não disponível. Faça login novamente." };
    }

    const timeZone = "America/Sao_Paulo";
    
    // Construir datas
    let startDateTime: string | undefined;
    let endDateTime: string | undefined;
    let startDate: string | undefined;
    let endDate: string | undefined;

    if (event.hora_inicio) {
      // Evento com horário específico
      startDateTime = `${event.data_inicio}T${event.hora_inicio}:00`;
      const endDateStr = event.data_fim || event.data_inicio;
      const endTimeStr = event.hora_fim || event.hora_inicio;
      endDateTime = `${endDateStr}T${endTimeStr}:00`;
    } else {
      // Evento de dia inteiro
      startDate = event.data_inicio;
      endDate = event.data_fim || event.data_inicio;
      // Google Calendar precisa que a data de fim seja o dia seguinte para eventos de dia inteiro
      const endDateObj = new Date(endDate);
      endDateObj.setDate(endDateObj.getDate() + 1);
      endDate = endDateObj.toISOString().split("T")[0];
    }

    const calendarEvent: GoogleCalendarEvent = {
      summary: event.nome,
      description: event.descricao || undefined,
      location: event.endereco || event.local || undefined,
      start: startDateTime
        ? { dateTime: startDateTime, timeZone }
        : { date: startDate!, timeZone },
      end: endDateTime
        ? { dateTime: endDateTime, timeZone }
        : { date: endDate!, timeZone },
      colorId: GOOGLE_CALENDAR_EVENT_COLOR,
    };

    const response = await fetch(
      "https://www.googleapis.com/calendar/v3/calendars/primary/events",
      {
        method: "POST",
        headers: {
          Authorization: `Bearer ${tokens.access_token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify(calendarEvent),
      }
    );

    if (!response.ok) {
      const errorData = await response.json();
      console.error("Erro ao criar evento no Google Calendar:", errorData);
      return { 
        id: null, 
        error: errorData.error?.message || "Erro ao criar evento no Google Calendar" 
      };
    }

    const data = await response.json();
    return { id: data.id, error: null };
  } catch (error) {
    console.error("Erro ao criar evento no Google Calendar:", error);
    return { id: null, error: "Erro ao conectar com Google Calendar" };
  }
}

/**
 * Atualiza um evento no Google Calendar
 */
export async function updateGoogleCalendarEvent(
  googleCalendarId: string,
  event: {
    nome: string;
    descricao?: string | null;
    local?: string | null;
    endereco?: string | null;
    data_inicio: string;
    data_fim?: string | null;
    hora_inicio?: string | null;
    hora_fim?: string | null;
    tipo?: string | null;
  }
): Promise<{ success: boolean; error: string | null }> {
  try {
    const tokens = await getGoogleTokens();
    
    if (!tokens) {
      return { success: false, error: "Token do Google não disponível" };
    }

    const timeZone = "America/Sao_Paulo";
    
    let startDateTime: string | undefined;
    let endDateTime: string | undefined;
    let startDate: string | undefined;
    let endDate: string | undefined;

    if (event.hora_inicio) {
      startDateTime = `${event.data_inicio}T${event.hora_inicio}:00`;
      const endDateStr = event.data_fim || event.data_inicio;
      const endTimeStr = event.hora_fim || event.hora_inicio;
      endDateTime = `${endDateStr}T${endTimeStr}:00`;
    } else {
      startDate = event.data_inicio;
      endDate = event.data_fim || event.data_inicio;
      const endDateObj = new Date(endDate);
      endDateObj.setDate(endDateObj.getDate() + 1);
      endDate = endDateObj.toISOString().split("T")[0];
    }

    const calendarEvent: GoogleCalendarEvent = {
      summary: event.nome,
      description: event.descricao || undefined,
      location: event.endereco || event.local || undefined,
      start: startDateTime
        ? { dateTime: startDateTime, timeZone }
        : { date: startDate!, timeZone },
      end: endDateTime
        ? { dateTime: endDateTime, timeZone }
        : { date: endDate!, timeZone },
      colorId: GOOGLE_CALENDAR_EVENT_COLOR,
    };

    const response = await fetch(
      `https://www.googleapis.com/calendar/v3/calendars/primary/events/${googleCalendarId}`,
      {
        method: "PUT",
        headers: {
          Authorization: `Bearer ${tokens.access_token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify(calendarEvent),
      }
    );

    if (!response.ok) {
      const errorData = await response.json();
      console.error("Erro ao atualizar evento no Google Calendar:", errorData);
      return { 
        success: false, 
        error: errorData.error?.message || "Erro ao atualizar evento" 
      };
    }

    return { success: true, error: null };
  } catch (error) {
    console.error("Erro ao atualizar evento no Google Calendar:", error);
    return { success: false, error: "Erro ao conectar com Google Calendar" };
  }
}

/**
 * Deleta um evento do Google Calendar
 */
export async function deleteGoogleCalendarEvent(
  googleCalendarId: string
): Promise<{ success: boolean; error: string | null }> {
  try {
    const tokens = await getGoogleTokens();
    
    if (!tokens) {
      return { success: false, error: "Token do Google não disponível" };
    }

    const response = await fetch(
      `https://www.googleapis.com/calendar/v3/calendars/primary/events/${googleCalendarId}`,
      {
        method: "DELETE",
        headers: {
          Authorization: `Bearer ${tokens.access_token}`,
        },
      }
    );

    // 204 No Content é sucesso para DELETE
    if (!response.ok && response.status !== 204) {
      const errorData = await response.json();
      console.error("Erro ao deletar evento do Google Calendar:", errorData);
      return { 
        success: false, 
        error: errorData.error?.message || "Erro ao deletar evento" 
      };
    }

    return { success: true, error: null };
  } catch (error) {
    console.error("Erro ao deletar evento do Google Calendar:", error);
    return { success: false, error: "Erro ao conectar com Google Calendar" };
  }
}

/**
 * Busca um evento do Google Calendar para obter dados atuais (incluindo participantes)
 */
async function getGoogleCalendarEvent(
  googleCalendarId: string
): Promise<{ data: GoogleCalendarEvent & { attendees?: GoogleCalendarAttendee[] } | null; error: string | null }> {
  try {
    const tokens = await getGoogleTokens();
    
    if (!tokens) {
      return { data: null, error: "Token do Google não disponível" };
    }

    const response = await fetch(
      `https://www.googleapis.com/calendar/v3/calendars/primary/events/${googleCalendarId}`,
      {
        method: "GET",
        headers: {
          Authorization: `Bearer ${tokens.access_token}`,
        },
      }
    );

    if (!response.ok) {
      const errorData = await response.json();
      console.error("Erro ao buscar evento do Google Calendar:", errorData);
      return { 
        data: null, 
        error: errorData.error?.message || "Erro ao buscar evento" 
      };
    }

    const data = await response.json();
    return { data, error: null };
  } catch (error) {
    console.error("Erro ao buscar evento do Google Calendar:", error);
    return { data: null, error: "Erro ao conectar com Google Calendar" };
  }
}

/**
 * Adiciona um participante a um evento existente no Google Calendar
 * O Google enviará automaticamente um convite por email para o participante
 */
export async function addAttendeeToGoogleEvent(
  googleCalendarId: string,
  attendee: GoogleCalendarAttendee
): Promise<{ success: boolean; error: string | null }> {
  try {
    const tokens = await getGoogleTokens();
    
    if (!tokens) {
      return { success: false, error: "Token do Google não disponível" };
    }

    // Primeiro, buscar o evento atual para obter a lista de participantes existentes
    const { data: currentEvent, error: fetchError } = await getGoogleCalendarEvent(googleCalendarId);
    
    if (fetchError || !currentEvent) {
      return { success: false, error: fetchError || "Evento não encontrado" };
    }

    // Verificar se o participante já existe
    const existingAttendees = currentEvent.attendees || [];
    const alreadyExists = existingAttendees.some(
      (a) => a.email.toLowerCase() === attendee.email.toLowerCase()
    );

    if (alreadyExists) {
      // Participante já existe, não precisa adicionar
      return { success: true, error: null };
    }

    // Adicionar novo participante à lista existente
    const updatedAttendees = [...existingAttendees, attendee];

    // Atualizar evento com PATCH para enviar convites
    // sendUpdates: 'all' faz o Google enviar email para todos os participantes
    const response = await fetch(
      `https://www.googleapis.com/calendar/v3/calendars/primary/events/${googleCalendarId}?sendUpdates=all`,
      {
        method: "PATCH",
        headers: {
          Authorization: `Bearer ${tokens.access_token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          attendees: updatedAttendees,
        }),
      }
    );

    if (!response.ok) {
      const errorData = await response.json();
      console.error("Erro ao adicionar participante no Google Calendar:", errorData);
      return { 
        success: false, 
        error: errorData.error?.message || "Erro ao adicionar participante" 
      };
    }

    return { success: true, error: null };
  } catch (error) {
    console.error("Erro ao adicionar participante no Google Calendar:", error);
    return { success: false, error: "Erro ao conectar com Google Calendar" };
  }
}

/**
 * Remove um participante de um evento existente no Google Calendar
 */
export async function removeAttendeeFromGoogleEvent(
  googleCalendarId: string,
  email: string
): Promise<{ success: boolean; error: string | null }> {
  try {
    const tokens = await getGoogleTokens();
    
    if (!tokens) {
      return { success: false, error: "Token do Google não disponível" };
    }

    // Primeiro, buscar o evento atual
    const { data: currentEvent, error: fetchError } = await getGoogleCalendarEvent(googleCalendarId);
    
    if (fetchError || !currentEvent) {
      return { success: false, error: fetchError || "Evento não encontrado" };
    }

    const existingAttendees = currentEvent.attendees || [];
    
    // Filtrar para remover o participante
    const updatedAttendees = existingAttendees.filter(
      (a) => a.email.toLowerCase() !== email.toLowerCase()
    );

    // Se não tinha o participante, não precisa atualizar
    if (updatedAttendees.length === existingAttendees.length) {
      return { success: true, error: null };
    }

    // Atualizar evento removendo o participante
    // sendUpdates: 'all' notifica os participantes sobre a remoção
    const response = await fetch(
      `https://www.googleapis.com/calendar/v3/calendars/primary/events/${googleCalendarId}?sendUpdates=all`,
      {
        method: "PATCH",
        headers: {
          Authorization: `Bearer ${tokens.access_token}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          attendees: updatedAttendees,
        }),
      }
    );

    if (!response.ok) {
      const errorData = await response.json();
      console.error("Erro ao remover participante do Google Calendar:", errorData);
      return { 
        success: false, 
        error: errorData.error?.message || "Erro ao remover participante" 
      };
    }

    return { success: true, error: null };
  } catch (error) {
    console.error("Erro ao remover participante do Google Calendar:", error);
    return { success: false, error: "Erro ao conectar com Google Calendar" };
  }
}

