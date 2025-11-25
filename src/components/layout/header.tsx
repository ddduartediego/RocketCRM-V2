"use client";

import { SidebarTrigger } from "@/components/ui/sidebar";
import { Separator } from "@/components/ui/separator";
import { Button } from "@/components/ui/button";
import { Bell, Search } from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

interface HeaderProps {
  title?: string;
}

export function Header({ title }: HeaderProps) {
  return (
    <header className="sticky top-0 z-40 flex h-16 shrink-0 items-center gap-4 border-b border-border bg-card px-4">
      <SidebarTrigger className="-ml-1" />
      <Separator orientation="vertical" className="h-6" />
      
      {title && (
        <h1 className="text-lg font-semibold text-foreground">{title}</h1>
      )}

      <div className="flex-1" />

      {/* Busca global (futuro) */}
      <Button variant="ghost" size="icon" className="h-9 w-9">
        <Search className="h-5 w-5 text-muted-foreground" />
      </Button>

      {/* Notificações */}
      <DropdownMenu>
        <DropdownMenuTrigger asChild>
          <Button variant="ghost" size="icon" className="h-9 w-9 relative">
            <Bell className="h-5 w-5 text-muted-foreground" />
            {/* Badge de notificação */}
            <span className="absolute top-1 right-1 w-2 h-2 bg-primary rounded-full" />
          </Button>
        </DropdownMenuTrigger>
        <DropdownMenuContent align="end" className="w-80">
          <DropdownMenuLabel>Notificações</DropdownMenuLabel>
          <DropdownMenuSeparator />
          <div className="p-4 text-center text-sm text-muted-foreground">
            Nenhuma notificação no momento
          </div>
        </DropdownMenuContent>
      </DropdownMenu>
    </header>
  );
}

