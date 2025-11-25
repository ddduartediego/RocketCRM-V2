import { Suspense } from "react";
import { getMembrosEquipe } from "@/actions/equipe";
import { EquipeClient } from "@/components/modules/equipe";
import { MembroFormTrigger } from "./membro-form-trigger";
import { UserCog } from "lucide-react";

export const dynamic = "force-dynamic";

export default async function EquipePage() {
  const { data: membros, count } = await getMembrosEquipe({
    page: 1,
    perPage: 10,
  });

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight flex items-center gap-3">
            <UserCog className="h-8 w-8 text-primary" />
            Equipe
          </h1>
          <p className="text-muted-foreground mt-1">
            Gerencie monitores, recreadores e colaboradores
          </p>
        </div>
        <MembroFormTrigger />
      </div>

      <Suspense
        fallback={
          <div className="flex items-center justify-center py-12">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" />
          </div>
        }
      >
        <EquipeClient initialMembros={membros} initialCount={count} />
      </Suspense>
    </div>
  );
}

