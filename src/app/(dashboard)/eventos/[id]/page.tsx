import { Suspense } from "react";
import { notFound } from "next/navigation";
import { getEventoById } from "@/actions/eventos";
import { getTransacoesEvento } from "@/actions/financeiro";
import { getAlocacoesEvento as getAlocacoesEquipe } from "@/actions/equipe";
import { getAlocacoesEvento as getAlocacoesRecursos } from "@/actions/recursos";
import { EventoDetail } from "@/components/modules/eventos/evento-detail";
import { Skeleton } from "@/components/ui/skeleton";

export const dynamic = "force-dynamic";

interface PageProps {
  params: Promise<{ id: string }>;
}

async function EventoContent({ id }: { id: string }) {
  const [eventoResult, transacoesResult, equipeResult, recursosResult] = await Promise.all([
    getEventoById(id),
    getTransacoesEvento(id),
    getAlocacoesEquipe(id),
    getAlocacoesRecursos(id),
  ]);

  if (eventoResult.error || !eventoResult.data) {
    notFound();
  }

  return (
    <EventoDetail
      evento={eventoResult.data}
      transacoes={transacoesResult.data}
      resumoFinanceiro={{
        totalReceitas: transacoesResult.totalReceitas ?? 0,
        totalDespesas: transacoesResult.totalDespesas ?? 0,
        lucro: transacoesResult.lucro ?? 0,
      }}
      alocacoesEquipe={equipeResult.data}
      alocacoesRecursos={recursosResult.data}
    />
  );
}

function EventoSkeleton() {
  return (
    <div className="space-y-6">
      <div className="flex items-center gap-4">
        <Skeleton className="h-10 w-10" />
        <div className="space-y-2">
          <Skeleton className="h-6 w-64" />
          <Skeleton className="h-4 w-40" />
        </div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        {Array.from({ length: 4 }).map((_, i) => (
          <Skeleton key={i} className="h-28" />
        ))}
      </div>
      <Skeleton className="h-96" />
    </div>
  );
}

export default async function EventoDetailPage({ params }: PageProps) {
  const { id } = await params;

  return (
    <Suspense fallback={<EventoSkeleton />}>
      <EventoContent id={id} />
    </Suspense>
  );
}

