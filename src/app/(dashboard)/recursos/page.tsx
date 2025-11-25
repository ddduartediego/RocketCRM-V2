import { Suspense } from "react";
import { getRecursos } from "@/actions/recursos";
import { RecursosClient } from "@/components/modules/recursos";
import { RecursoFormTrigger } from "./recurso-form-trigger";
import { Package } from "lucide-react";

export const dynamic = "force-dynamic";

export default async function RecursosPage() {
  const { data: recursos, count } = await getRecursos({
    page: 1,
    perPage: 10,
  });

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight flex items-center gap-3">
            <Package className="h-8 w-8 text-primary" />
            Recursos
          </h1>
          <p className="text-muted-foreground mt-1">
            Gerencie brinquedos, veículos e equipamentos
          </p>
        </div>
        <RecursoFormTrigger />
      </div>

      <Suspense
        fallback={
          <div className="flex items-center justify-center py-12">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" />
          </div>
        }
      >
        <RecursosClient initialRecursos={recursos} initialCount={count} />
      </Suspense>
    </div>
  );
}

