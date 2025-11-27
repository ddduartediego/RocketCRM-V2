import { createClient } from "@/lib/supabase/server";
import { redirect } from "next/navigation";
import { ConfiguracoesClient } from "@/components/modules/configuracoes/configuracoes-client";
import { getEtapasFunil, getCategoriasFinanceiras, getTiposEvento } from "@/actions/configuracoes";

export default async function ConfiguracoesPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  // Buscar dados do usuário na tabela users
  const { data: userData } = await supabase
    .from("users")
    .select("*")
    .eq("id", user.id)
    .single();

  // Buscar dados para todas as seções
  const [etapasRes, categoriasRes, tiposEventoRes] = await Promise.all([
    getEtapasFunil(),
    getCategoriasFinanceiras(),
    getTiposEvento(),
  ]);

  return (
    <ConfiguracoesClient
      user={{
        id: user.id,
        nome: userData?.nome || user.user_metadata?.full_name || "",
        email: user.email || "",
        avatar_url: userData?.avatar_url || user.user_metadata?.avatar_url || null,
      }}
      initialEtapas={etapasRes.data}
      initialCategorias={categoriasRes.data}
      initialTiposEvento={tiposEventoRes.data}
    />
  );
}
