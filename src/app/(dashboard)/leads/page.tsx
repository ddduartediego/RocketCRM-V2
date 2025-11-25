import { Suspense } from "react";
import { getLeadsByEtapa } from "@/actions/leads";
import { Skeleton } from "@/components/ui/skeleton";
import { Target } from "lucide-react";
import { KanbanBoard } from "@/components/modules/leads";
import { LeadFormTrigger } from "./lead-form-trigger";

export const dynamic = "force-dynamic";

async function LeadsKanban() {
  const { etapas, leadsByEtapa, error } = await getLeadsByEtapa();

  if (error) {
    return (
      <div className="flex flex-col items-center justify-center py-12 text-center">
        <div className="w-16 h-16 rounded-full bg-destructive/10 flex items-center justify-center mb-4">
          <Target className="w-8 h-8 text-destructive" />
        </div>
        <h3 className="text-lg font-medium text-foreground">
          Erro ao carregar leads
        </h3>
        <p className="text-sm text-muted-foreground mt-1">{error}</p>
      </div>
    );
  }

  return <KanbanBoard etapas={etapas} leadsByEtapa={leadsByEtapa} />;
}

function KanbanSkeleton() {
  return (
    <div className="flex gap-4 overflow-x-auto pb-4">
      {Array.from({ length: 5 }).map((_, i) => (
        <div
          key={i}
          className="flex flex-col w-80 min-w-[320px] bg-muted/30 rounded-lg"
        >
          <div className="p-3">
            <Skeleton className="h-4 w-24 mb-2" />
            <Skeleton className="h-3 w-32" />
          </div>
          <div className="p-2 space-y-2">
            {Array.from({ length: 3 }).map((_, j) => (
              <Skeleton key={j} className="h-24 w-full rounded-lg" />
            ))}
          </div>
        </div>
      ))}
    </div>
  );
}

export default function LeadsPage() {
  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-foreground flex items-center gap-2">
            <Target className="w-7 h-7 text-primary" />
            Leads & Vendas
          </h1>
          <p className="text-muted-foreground">
            Gerencie seu funil de vendas e acompanhe suas oportunidades
          </p>
        </div>
        <LeadFormTrigger />
      </div>

      {/* Kanban */}
      <Suspense fallback={<KanbanSkeleton />}>
        <LeadsKanban />
      </Suspense>
    </div>
  );
}

