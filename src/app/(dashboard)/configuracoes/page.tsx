import { createClient } from "@/lib/supabase/server";
import { redirect } from "next/navigation";
import Link from "next/link";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { User, Settings2, Funnel, Tags } from "lucide-react";

export default async function ConfiguracoesPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  const configItems = [
    {
      title: "Perfil",
      description: "Gerencie suas informações pessoais",
      icon: User,
      href: "/configuracoes/perfil",
    },
    {
      title: "Etapas do Funil",
      description: "Configure as etapas do funil de vendas",
      icon: Funnel,
      href: "/configuracoes/funil",
    },
    {
      title: "Categorias Financeiras",
      description: "Gerencie categorias de receitas e despesas",
      icon: Tags,
      href: "/configuracoes/categorias",
    },
    {
      title: "Preferências",
      description: "Ajuste as configurações do sistema",
      icon: Settings2,
      href: "/configuracoes/preferencias",
      disabled: true,
    },
  ];

  return (
    <div className="flex flex-col gap-6 p-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight">Configurações</h1>
        <p className="text-muted-foreground">
          Gerencie as configurações do sistema
        </p>
      </div>

      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
        {configItems.map((item) => (
          <Link
            key={item.href}
            href={item.disabled ? "#" : item.href}
            className={item.disabled ? "cursor-not-allowed" : ""}
          >
            <Card className={`h-full transition-colors hover:bg-muted/50 ${item.disabled ? "opacity-50" : ""}`}>
              <CardHeader>
                <div className="flex items-center gap-3">
                  <div className="p-2 rounded-lg bg-primary/10">
                    <item.icon className="h-5 w-5 text-primary" />
                  </div>
                  <div>
                    <CardTitle className="text-lg">{item.title}</CardTitle>
                    <CardDescription>{item.description}</CardDescription>
                  </div>
                </div>
              </CardHeader>
              {item.disabled && (
                <CardContent>
                  <span className="text-xs text-muted-foreground">Em breve</span>
                </CardContent>
              )}
            </Card>
          </Link>
        ))}
      </div>
    </div>
  );
}

