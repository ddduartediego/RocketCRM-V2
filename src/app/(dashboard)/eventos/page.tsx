import { Suspense } from "react";
import { getEventos } from "@/actions/eventos";
import { getResumosFinanceirosEventos } from "@/actions/financeiro";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";
import { Calendar } from "lucide-react";
import { EventosFilters, EventosClient } from "@/components/modules/eventos";
import { EventoFormTrigger } from "./evento-form-trigger";

export const dynamic = "force-dynamic";

interface PageProps {
  searchParams: Promise<{
    search?: string;
    tipo?: string;
    status?: string;
    page?: string;
  }>;
}

const PER_PAGE = 10;

async function EventosList({
  searchParams,
}: {
  searchParams: { search?: string; tipo?: string; status?: string; page?: string };
}) {
  const { data: eventos, count } = await getEventos({
    search: searchParams.search,
    tipo: searchParams.tipo,
    status: searchParams.status,
    page: Number(searchParams.page) || 1,
    perPage: PER_PAGE,
  });

  // Buscar resumos financeiros para todos os eventos da página
  const eventoIds = eventos.map((e) => e.id);
  const { data: resumosFinanceiros } = await getResumosFinanceirosEventos(eventoIds);

  return (
    <EventosClient 
      eventos={eventos} 
      resumosFinanceiros={resumosFinanceiros}
      total={count}
      perPage={PER_PAGE}
    />
  );
}

function EventosListSkeleton() {
  return (
    <div className="space-y-3">
      {Array.from({ length: 5 }).map((_, i) => (
        <div key={i} className="flex items-center gap-4 p-4 border rounded-lg">
          <Skeleton className="w-12 h-12 rounded-lg" />
          <div className="space-y-2 flex-1">
            <Skeleton className="h-4 w-1/3" />
            <Skeleton className="h-3 w-1/4" />
          </div>
          <Skeleton className="h-6 w-20" />
          <Skeleton className="h-8 w-24" />
        </div>
      ))}
    </div>
  );
}

export default async function EventosPage({ searchParams }: PageProps) {
  const params = await searchParams;

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-foreground flex items-center gap-2">
            <Calendar className="w-7 h-7 text-primary" />
            Eventos
          </h1>
          <p className="text-muted-foreground">
            Gerencie viagens, festas e eventos da sua empresa
          </p>
        </div>
        <EventoFormTrigger />
      </div>

      {/* Filtros */}
      <Card>
        <CardHeader className="pb-3">
          <CardTitle className="text-base">Filtros</CardTitle>
          <CardDescription>Encontre eventos rapidamente</CardDescription>
        </CardHeader>
        <CardContent>
          <Suspense fallback={<Skeleton className="h-10 w-full" />}>
            <EventosFilters />
          </Suspense>
        </CardContent>
      </Card>

      {/* Lista de Eventos */}
      <Card>
        <CardContent className="pt-6">
          <Suspense fallback={<EventosListSkeleton />}>
            <EventosList searchParams={params} />
          </Suspense>
        </CardContent>
      </Card>
    </div>
  );
}
