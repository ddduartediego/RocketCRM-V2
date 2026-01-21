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
import { funcoesEquipe, tiposContrato } from "@/lib/validations/equipe";
import { useDebounce } from "@/hooks/use-debounce";

interface EquipeFiltersProps {
  search: string;
  funcao: string;
  tipoContrato: string;
  onSearchChange: (value: string) => void;
  onFuncaoChange: (value: string) => void;
  onTipoContratoChange: (value: string) => void;
}

export function EquipeFilters({
  search,
  funcao,
  tipoContrato,
  onSearchChange,
  onFuncaoChange,
  onTipoContratoChange,
}: EquipeFiltersProps) {
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
          placeholder="Buscar membros..."
          value={searchInput}
          onChange={(e) => setSearchInput(e.target.value)}
          className="pl-9"
        />
      </div>

      <Select value={funcao} onValueChange={onFuncaoChange}>
        <SelectTrigger className="w-full sm:w-[180px]">
          <SelectValue placeholder="Função" />
        </SelectTrigger>
        <SelectContent>
          <SelectItem value="todos">Todas as funções</SelectItem>
          {funcoesEquipe.map((f) => (
            <SelectItem key={f.value} value={f.value}>
              {f.label}
            </SelectItem>
          ))}
        </SelectContent>
      </Select>

      <Select value={tipoContrato} onValueChange={onTipoContratoChange}>
        <SelectTrigger className="w-full sm:w-[180px]">
          <SelectValue placeholder="Contrato" />
        </SelectTrigger>
        <SelectContent>
          <SelectItem value="todos">Todos os contratos</SelectItem>
          {tiposContrato.map((t) => (
            <SelectItem key={t.value} value={t.value}>
              {t.label}
            </SelectItem>
          ))}
        </SelectContent>
      </Select>
    </div>
  );
}

