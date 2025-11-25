import { Suspense } from "react";
import { getAtividades, getResumoAtividades } from "@/actions/atividades";
import { TarefasClient } from "@/components/modules/tarefas";
import { TarefaFormTrigger } from "./tarefa-form-trigger";

interface PageProps {
  searchParams: Promise<{
    search?: string;
    status?: string;
    prioridade?: string;
    page?: string;
  }>;
}

export default async function TarefasPage({ searchParams }: PageProps) {
  const params = await searchParams;
  const page = Number(params.page) || 1;
  const perPage = 20;

  const [tarefasResult, resumo] = await Promise.all([
    getAtividades({
      search: params.search,
      status: params.status !== "todos" ? params.status : undefined,
      prioridade: params.prioridade !== "todos" ? Number(params.prioridade) : undefined,
      page,
      perPage,
    }),
    getResumoAtividades(),
  ]);

  return (
    <div className="flex flex-col gap-6 p-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight">Tarefas</h1>
          <p className="text-muted-foreground">
            Gerencie suas tarefas e acompanhe o progresso
          </p>
        </div>
        <TarefaFormTrigger />
      </div>

      <Suspense fallback={<TarefasLoading />}>
        <TarefasClient
          initialTarefas={tarefasResult.data as any}
          initialCount={tarefasResult.count}
          resumo={resumo}
        />
      </Suspense>
    </div>
  );
}

function TarefasLoading() {
  return (
    <div className="space-y-6">
      {/* Cards skeleton */}
      <div className="grid gap-4 grid-cols-2 lg:grid-cols-5">
        {[...Array(5)].map((_, i) => (
          <div
            key={i}
            className="h-[100px] rounded-lg bg-muted animate-pulse"
          />
        ))}
      </div>
      {/* Table skeleton */}
      <div className="h-[400px] rounded-lg bg-muted animate-pulse" />
    </div>
  );
}

