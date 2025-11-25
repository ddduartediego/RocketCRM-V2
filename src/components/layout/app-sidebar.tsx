"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import {
  LayoutDashboard,
  Users,
  Target,
  Calendar,
  Package,
  UserCog,
  DollarSign,
  BarChart3,
  CheckSquare,
  Settings,
  Rocket,
  LogOut,
} from "lucide-react";
import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from "@/components/ui/sidebar";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { createClient } from "@/lib/supabase/client";
import { useRouter } from "next/navigation";

interface NavItem {
  title: string;
  url: string;
  icon: React.ComponentType<{ className?: string }>;
}

const mainNavItems: NavItem[] = [
  {
    title: "Dashboard",
    url: "/",
    icon: LayoutDashboard,
  },
  {
    title: "Leads & Vendas",
    url: "/leads",
    icon: Target,
  },
  {
    title: "Contatos",
    url: "/contatos",
    icon: Users,
  },
  {
    title: "Eventos",
    url: "/eventos",
    icon: Calendar,
  },
];

const operationsNavItems: NavItem[] = [
  {
    title: "Recursos",
    url: "/recursos",
    icon: Package,
  },
  {
    title: "Equipe",
    url: "/equipe",
    icon: UserCog,
  },
  {
    title: "Tarefas",
    url: "/tarefas",
    icon: CheckSquare,
  },
];

const financeNavItems: NavItem[] = [
  {
    title: "Financeiro",
    url: "/financeiro",
    icon: DollarSign,
  },
  {
    title: "Relatórios",
    url: "/relatorios",
    icon: BarChart3,
  },
];

interface AppSidebarProps {
  user: {
    nome: string;
    email: string;
    avatar_url?: string | null;
  } | null;
}

export function AppSidebar({ user }: AppSidebarProps) {
  const pathname = usePathname();
  const router = useRouter();
  const supabase = createClient();

  const handleLogout = async () => {
    await supabase.auth.signOut();
    router.push("/login");
  };

  const isActive = (url: string) => {
    if (url === "/") return pathname === "/";
    return pathname.startsWith(url);
  };

  const getInitials = (name: string) => {
    return name
      .split(" ")
      .map((n) => n[0])
      .join("")
      .toUpperCase()
      .slice(0, 2);
  };

  return (
    <Sidebar className="border-r border-sidebar-border">
      <SidebarHeader className="border-b border-sidebar-border px-4 py-4">
        <Link href="/" className="flex items-center gap-3">
          <div className="w-10 h-10 bg-sidebar-primary rounded-xl flex items-center justify-center shadow-lg shadow-sidebar-primary/30">
            <Rocket className="w-5 h-5 text-sidebar-primary-foreground" />
          </div>
          <div className="flex flex-col">
            <span className="font-bold text-lg text-sidebar-foreground">
              RocketCRM
            </span>
            <span className="text-xs text-sidebar-muted-foreground">
              Gestão de Eventos
            </span>
          </div>
        </Link>
      </SidebarHeader>

      <SidebarContent className="px-2 py-4">
        {/* Menu Principal */}
        <SidebarGroup>
          <SidebarGroupLabel className="text-sidebar-muted-foreground text-xs font-medium px-2 mb-2">
            Menu Principal
          </SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {mainNavItems.map((item) => (
                <SidebarMenuItem key={item.url}>
                  <SidebarMenuButton
                    asChild
                    isActive={isActive(item.url)}
                    className="h-10"
                  >
                    <Link href={item.url}>
                      <item.icon className="w-5 h-5" />
                      <span>{item.title}</span>
                    </Link>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>

        {/* Operações */}
        <SidebarGroup className="mt-4">
          <SidebarGroupLabel className="text-sidebar-muted-foreground text-xs font-medium px-2 mb-2">
            Operações
          </SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {operationsNavItems.map((item) => (
                <SidebarMenuItem key={item.url}>
                  <SidebarMenuButton
                    asChild
                    isActive={isActive(item.url)}
                    className="h-10"
                  >
                    <Link href={item.url}>
                      <item.icon className="w-5 h-5" />
                      <span>{item.title}</span>
                    </Link>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>

        {/* Financeiro */}
        <SidebarGroup className="mt-4">
          <SidebarGroupLabel className="text-sidebar-muted-foreground text-xs font-medium px-2 mb-2">
            Financeiro
          </SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {financeNavItems.map((item) => (
                <SidebarMenuItem key={item.url}>
                  <SidebarMenuButton
                    asChild
                    isActive={isActive(item.url)}
                    className="h-10"
                  >
                    <Link href={item.url}>
                      <item.icon className="w-5 h-5" />
                      <span>{item.title}</span>
                    </Link>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>
      </SidebarContent>

      <SidebarFooter className="border-t border-sidebar-border p-2">
        <SidebarMenu>
          {/* Configurações */}
          <SidebarMenuItem>
            <SidebarMenuButton
              asChild
              isActive={isActive("/configuracoes")}
              className="h-10"
            >
              <Link href="/configuracoes">
                <Settings className="w-5 h-5" />
                <span>Configurações</span>
              </Link>
            </SidebarMenuButton>
          </SidebarMenuItem>

          {/* Usuário */}
          <SidebarMenuItem>
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <SidebarMenuButton className="h-12 px-2">
                  <Avatar className="w-8 h-8">
                    <AvatarImage src={user?.avatar_url || undefined} />
                    <AvatarFallback className="bg-sidebar-primary text-sidebar-primary-foreground text-xs">
                      {user?.nome ? getInitials(user.nome) : "U"}
                    </AvatarFallback>
                  </Avatar>
                  <div className="flex flex-col items-start flex-1 min-w-0">
                    <span className="text-sm font-medium truncate w-full text-left">
                      {user?.nome || "Usuário"}
                    </span>
                    <span className="text-xs text-sidebar-muted-foreground truncate w-full text-left">
                      {user?.email || ""}
                    </span>
                  </div>
                </SidebarMenuButton>
              </DropdownMenuTrigger>
              <DropdownMenuContent
                side="top"
                align="start"
                className="w-56"
              >
                <DropdownMenuItem asChild>
                  <Link href="/configuracoes/perfil">
                    <UserCog className="w-4 h-4 mr-2" />
                    Meu Perfil
                  </Link>
                </DropdownMenuItem>
                <DropdownMenuSeparator />
                <DropdownMenuItem
                  onClick={handleLogout}
                  className="text-destructive focus:text-destructive"
                >
                  <LogOut className="w-4 h-4 mr-2" />
                  Sair
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </SidebarMenuItem>
        </SidebarMenu>
      </SidebarFooter>
    </Sidebar>
  );
}

