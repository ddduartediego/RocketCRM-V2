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

// Mapeamento de tipos de evento para cores do Google Calendar
const eventColorMap: Record<string, string> = {
  colonia_ferias: "10",    // Verde
  festa_infantil: "6",     // Laranja
  gincana: "3",            // Roxo
  outro: "8",              // Cinza
};

/**
 * Obtém os tokens do Google do usuário autenticado
 */
async function getGoogleTokens(): Promise<GoogleTokens | null> {
  const supabase = await createClient();
  
  const { data: { session } } = await supabase.auth.getSession();
  
  if (!session?.provider_token) {
    console.error("Usuário não possui token do Google");
    return null;
  }

  return {
    access_token: session.provider_token,
    refresh_token: session.provider_refresh_token || undefined,
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
      colorId: event.tipo ? (eventColorMap[event.tipo] || "8") : "8",
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
      colorId: event.tipo ? (eventColorMap[event.tipo] || "8") : "8",
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

