"use client";

import { Button } from "@/components/ui/button";
import { List, CalendarDays } from "lucide-react";

export type EventosViewMode = "table" | "week";

interface EventosViewToggleProps {
  viewMode: EventosViewMode;
  onViewModeChange: (mode: EventosViewMode) => void;
}

export function EventosViewToggle({
  viewMode,
  onViewModeChange,
}: EventosViewToggleProps) {
  return (
    <div className="flex items-center gap-1 p-1 bg-muted rounded-lg">
      <Button
        variant={viewMode === "table" ? "default" : "ghost"}
        size="sm"
        className="gap-2"
        onClick={() => onViewModeChange("table")}
      >
        <List className="h-4 w-4" />
        <span className="hidden sm:inline">Lista</span>
      </Button>
      <Button
        variant={viewMode === "week" ? "default" : "ghost"}
        size="sm"
        className="gap-2"
        onClick={() => onViewModeChange("week")}
      >
        <CalendarDays className="h-4 w-4" />
        <span className="hidden sm:inline">Semana</span>
      </Button>
    </div>
  );
}

