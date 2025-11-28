"use client";

import { useState } from "react";
import { cn } from "@/lib/utils";
import { User, Funnel, Tags, Calendar, Settings2 } from "lucide-react";
import { PerfilForm } from "./perfil-form";
import { FunilConfig } from "./funil-config";
import { CategoriasConfig } from "./categorias-config";
import { TiposEventoConfig } from "./tipos-evento-config";
import type { EtapaFunil, CategoriaFinanceira, TipoEventoRow } from "@/types/database";

interface ConfiguracoesClientProps {
  user: {
    id: string;
    nome: string;
    email: string;
    avatar_url: string | null;
  };
  initialEtapas: EtapaFunil[];
  initialCategorias: CategoriaFinanceira[];
  initialTiposEvento: TipoEventoRow[];
}

type Section = "perfil" | "funil" | "categorias" | "tipos-evento" | "preferencias";

const menuItems: { id: Section; label: string; icon: React.ElementType; disabled?: boolean }[] = [
  { id: "perfil", label: "Perfil", icon: User },
  { id: "funil", label: "Etapas do Funil", icon: Funnel },
  { id: "categorias", label: "Categorias Financeiras", icon: Tags },
  { id: "tipos-evento", label: "Tipos de Evento", icon: Calendar },
  { id: "preferencias", label: "Preferências", icon: Settings2, disabled: true },
];

export function ConfiguracoesClient({
  user,
  initialEtapas,
  initialCategorias,
  initialTiposEvento,
}: ConfiguracoesClientProps) {
  const [activeSection, setActiveSection] = useState<Section>("perfil");

  const renderContent = () => {
    switch (activeSection) {
      case "perfil":
        return <PerfilForm user={user} />;
      case "funil":
        return <FunilConfig initialEtapas={initialEtapas} />;
      case "categorias":
        return <CategoriasConfig initialCategorias={initialCategorias} />;
      case "tipos-evento":
        return <TiposEventoConfig initialTipos={initialTiposEvento} />;
      case "preferencias":
        return (
          <div className="flex flex-col items-center justify-center h-64 text-muted-foreground">
            <Settings2 className="h-12 w-12 mb-4 opacity-50" />
            <p className="text-lg font-medium">Em breve</p>
            <p className="text-sm">Esta seção ainda está em desenvolvimento</p>
          </div>
        );
      default:
        return null;
    }
  };

  const getSectionTitle = () => {
    const item = menuItems.find((m) => m.id === activeSection);
    return item?.label || "Configurações";
  };

  const getSectionDescription = () => {
    switch (activeSection) {
      case "perfil":
        return "Gerencie suas informações pessoais";
      case "funil":
        return "Configure as etapas do seu funil de vendas";
      case "categorias":
        return "Organize receitas e despesas por categorias";
      case "tipos-evento":
        return "Personalize os tipos de eventos disponíveis";
      case "preferencias":
        return "Ajuste as configurações do sistema";
      default:
        return "";
    }
  };

  return (
    <div className="flex flex-col h-full">
      {/* Header */}
      <div className="border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
        <div className="px-6 py-4">
          <h1 className="text-2xl font-bold tracking-tight">Configurações</h1>
          <p className="text-sm text-muted-foreground">
            Gerencie as configurações do sistema
          </p>
        </div>
      </div>

      {/* Content with Sidebar */}
      <div className="flex flex-1 overflow-hidden">
        {/* Sidebar */}
        <aside className="w-64 border-r bg-muted/30 flex-shrink-0">
          <nav className="flex flex-col gap-1 p-4">
            {menuItems.map((item) => (
              <button
                key={item.id}
                onClick={() => !item.disabled && setActiveSection(item.id)}
                disabled={item.disabled}
                className={cn(
                  "flex items-center gap-3 px-3 py-2.5 rounded-lg text-left transition-all duration-200",
                  "hover:bg-accent/50",
                  activeSection === item.id && !item.disabled && [
                    "bg-primary/10 text-primary font-medium",
                    "shadow-sm border border-primary/20",
                  ],
                  item.disabled && "opacity-50 cursor-not-allowed hover:bg-transparent"
                )}
              >
                <item.icon className={cn(
                  "h-4 w-4 flex-shrink-0",
                  activeSection === item.id && !item.disabled && "text-primary"
                )} />
                <span className="text-sm">{item.label}</span>
                {item.disabled && (
                  <span className="ml-auto text-[10px] bg-muted px-1.5 py-0.5 rounded text-muted-foreground">
                    Em breve
                  </span>
                )}
              </button>
            ))}
          </nav>
        </aside>

        {/* Main Content */}
        <main className="flex-1 overflow-y-auto">
          <div className="p-6">
            {/* Section Header */}
            <div className="mb-6">
              <h2 className="text-xl font-semibold tracking-tight">
                {getSectionTitle()}
              </h2>
              <p className="text-sm text-muted-foreground">
                {getSectionDescription()}
              </p>
            </div>

            {/* Section Content */}
            <div className="animate-in fade-in-50 duration-300">
              {renderContent()}
            </div>
          </div>
        </main>
      </div>
    </div>
  );
}


