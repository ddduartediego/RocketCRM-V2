"use client";

import { useState, useEffect } from "react";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Search } from "lucide-react";
import { statusAtividade, prioridadeAtividade } from "@/lib/validations/atividade";
import { useDebounce } from "@/hooks/use-debounce";

interface TarefasFiltersProps {
  search: string;
  status: string;
  prioridade: string;
  onSearchChange: (value: string) => void;
  onStatusChange: (value: string) => void;
  onPrioridadeChange: (value: string) => void;
}

export function TarefasFilters({
  search,
  status,
  prioridade,
  onSearchChange,
  onStatusChange,
  onPrioridadeChange,
}: TarefasFiltersProps) {
  // Estado local para input imediato
  const [searchInput, setSearchInput] = useState(search);
  const debouncedSearch = useDebounce(searchInput, 400);

  // Sincroniza com prop externa
  useEffect(() => {
    if (search !== searchInput && search !== debouncedSearch) {
      setSearchInput(search);
    }
  }, [search]);

  // Chama callback quando debounce muda
  useEffect(() => {
    if (debouncedSearch !== search) {
      onSearchChange(debouncedSearch);
    }
  }, [debouncedSearch]);

  return (
    <div className="flex flex-col sm:flex-row gap-4">
      <div className="relative flex-1">
        <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
        <Input
          placeholder="Buscar tarefas..."
          value={searchInput}
          onChange={(e) => setSearchInput(e.target.value)}
          className="pl-9"
        />
      </div>

      <Select value={status} onValueChange={onStatusChange}>
        <SelectTrigger className="w-full sm:w-[150px]">
          <SelectValue placeholder="Status" />
        </SelectTrigger>
        <SelectContent>
          <SelectItem value="todos">Todos os status</SelectItem>
          {statusAtividade.map((s) => (
            <SelectItem key={s.value} value={s.value}>
              <div className="flex items-center gap-2">
                <div
                  className="w-2 h-2 rounded-full"
                  style={{ backgroundColor: s.color }}
                />
                {s.label}
              </div>
            </SelectItem>
          ))}
        </SelectContent>
      </Select>

      <Select value={prioridade} onValueChange={onPrioridadeChange}>
        <SelectTrigger className="w-full sm:w-[150px]">
          <SelectValue placeholder="Prioridade" />
        </SelectTrigger>
        <SelectContent>
          <SelectItem value="todos">Todas prioridades</SelectItem>
          {prioridadeAtividade.map((p) => (
            <SelectItem key={p.value} value={p.value.toString()}>
              <div className="flex items-center gap-2">
                <div
                  className="w-2 h-2 rounded-full"
                  style={{ backgroundColor: p.color }}
                />
                {p.label}
              </div>
            </SelectItem>
          ))}
        </SelectContent>
      </Select>
    </div>
  );
}

