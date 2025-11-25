import { getEtapasFunil } from "@/actions/configuracoes";
import { FunilConfig } from "@/components/modules/configuracoes/funil-config";

export default async function FunilPage() {
  const { data: etapas } = await getEtapasFunil();

  return (
    <div className="flex flex-col gap-6 p-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight">Etapas do Funil</h1>
        <p className="text-muted-foreground">
          Configure as etapas do seu funil de vendas
        </p>
      </div>

      <FunilConfig initialEtapas={etapas} />
    </div>
  );
}

