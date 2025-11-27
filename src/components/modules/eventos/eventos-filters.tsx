"use client";

import { useCallback, useEffect, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Search } from "lucide-react";
import { statusEventoOptions } from "@/lib/validations/evento";
import { getTiposEvento } from "@/actions/configuracoes";
import type { TipoEventoRow } from "@/types/database";

export function EventosFilters() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const [tiposEvento, setTiposEvento] = useState<TipoEventoRow[]>([]);

  const search = searchParams.get("search") || "";
  const tipo = searchParams.get("tipo") || "todos";
  const status = searchParams.get("status") || "todos";

  useEffect(() => {
    const loadTipos = async () => {
      const { data } = await getTiposEvento();
      setTiposEvento(data.filter((t: TipoEventoRow) => t.ativo));
    };
    loadTipos();
  }, []);

  const updateParams = useCallback(
    (key: string, value: string) => {
      const params = new URLSearchParams(searchParams.toString());
      if (value && value !== "todos") {
        params.set(key, value);
      } else {
        params.delete(key);
      }
      params.delete("page");
      router.push(`/eventos?${params.toString()}`);
    },
    [router, searchParams]
  );

  return (
    <div className="flex flex-col sm:flex-row gap-3">
      <div className="relative flex-1 max-w-md">
        <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
        <Input
          placeholder="Buscar por nome ou local..."
          value={search}
          onChange={(e) => updateParams("search", e.target.value)}
          className="pl-9"
        />
      </div>

      <Select value={tipo} onValueChange={(value) => updateParams("tipo", value)}>
        <SelectTrigger className="w-full sm:w-[180px]">
          <SelectValue placeholder="Filtrar por tipo" />
        </SelectTrigger>
        <SelectContent>
          <SelectItem value="todos">Todos os tipos</SelectItem>
          {tiposEvento.map((tipoEvento) => (
            <SelectItem key={tipoEvento.id} value={tipoEvento.id}>
              {tipoEvento.icone} {tipoEvento.nome}
            </SelectItem>
          ))}
        </SelectContent>
      </Select>

      <Select value={status} onValueChange={(value) => updateParams("status", value)}>
        <SelectTrigger className="w-full sm:w-[180px]">
          <SelectValue placeholder="Filtrar por status" />
        </SelectTrigger>
        <SelectContent>
          <SelectItem value="todos">Todos os status</SelectItem>
          {statusEventoOptions.map((option) => (
            <SelectItem key={option.value} value={option.value}>
              <span className="flex items-center gap-2">
                <span
                  className="w-2 h-2 rounded-full"
                  style={{ backgroundColor: option.color }}
                />
                {option.label}
              </span>
            </SelectItem>
          ))}
        </SelectContent>
      </Select>
    </div>
  );
}
