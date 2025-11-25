import { createClient } from "@/lib/supabase/server";
import { redirect } from "next/navigation";
import { PerfilForm } from "@/components/modules/configuracoes/perfil-form";

export default async function PerfilPage() {
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

  return (
    <div className="flex flex-col gap-6 p-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight">Meu Perfil</h1>
        <p className="text-muted-foreground">
          Gerencie suas informações pessoais
        </p>
      </div>

      <PerfilForm
        user={{
          id: user.id,
          nome: userData?.nome || user.user_metadata?.full_name || "",
          email: user.email || "",
          avatar_url: userData?.avatar_url || user.user_metadata?.avatar_url || null,
        }}
      />
    </div>
  );
}

