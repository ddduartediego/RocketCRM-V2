import { createClient } from "@/lib/supabase/server";
import { NextResponse } from "next/server";

export async function GET(request: Request) {
  const { searchParams, origin } = new URL(request.url);
  const code = searchParams.get("code");
  const next = searchParams.get("next") ?? "/";

  if (code) {
    const supabase = await createClient();
    const { data, error } = await supabase.auth.exchangeCodeForSession(code);
    
    if (!error && data.session) {
      // Salvar tokens do Google na tabela users para uso em Server Actions
      const { session } = data;
      
      if (session.provider_token) {
        // Calcular data de expiração (tokens do Google geralmente expiram em 1 hora)
        const expiresAt = session.expires_at 
          ? new Date(session.expires_at * 1000) 
          : new Date(Date.now() + 3600 * 1000);

        await supabase
          .from("users")
          .update({
            google_access_token: session.provider_token,
            google_refresh_token: session.provider_refresh_token || null,
            google_token_expires_at: expiresAt.toISOString(),
          })
          .eq("id", session.user.id);
      }

      return NextResponse.redirect(`${origin}${next}`);
    }
  }

  // Redireciona para login em caso de erro
  return NextResponse.redirect(`${origin}/login?error=auth_callback_error`);
}

