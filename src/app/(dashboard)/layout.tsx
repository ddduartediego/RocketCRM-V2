export const dynamic = "force-dynamic";

import { createClient } from "@/lib/supabase/server";
import { redirect } from "next/navigation";
import { SidebarProvider, SidebarInset } from "@/components/ui/sidebar";
import { AppSidebar } from "@/components/layout/app-sidebar";
import { Header } from "@/components/layout/header";
import { Toaster } from "@/components/ui/sonner";

export default async function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();
  
  const { data: { user: authUser } } = await supabase.auth.getUser();
  
  if (!authUser) {
    redirect("/login");
  }

  // Buscar dados do usuário na tabela users
  const { data: user } = await supabase
    .from("users")
    .select("nome, email, avatar_url, perfil")
    .eq("id", authUser.id)
    .single();

  return (
    <SidebarProvider>
      <AppSidebar user={user} />
      <SidebarInset>
        <Header />
        <main className="flex-1 p-6">
          {children}
        </main>
      </SidebarInset>
      <Toaster position="top-right" richColors />
    </SidebarProvider>
  );
}

