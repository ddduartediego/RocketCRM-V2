"use client";

import { PaginationGeneric } from "@/components/ui/pagination-generic";

interface EventosPaginationProps {
  total: number;
  perPage: number;
}

export function EventosPagination({ total, perPage }: EventosPaginationProps) {
  return (
    <PaginationGeneric
      total={total}
      perPage={perPage}
      basePath="/eventos"
      entityName="eventos"
    />
  );
}

