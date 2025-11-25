import { getCategoriasFinanceiras } from "@/actions/configuracoes";
import { CategoriasConfig } from "@/components/modules/configuracoes/categorias-config";

export default async function CategoriasPage() {
  const { data: categorias } = await getCategoriasFinanceiras();

  return (
    <div className="flex flex-col gap-6 p-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight">Categorias Financeiras</h1>
        <p className="text-muted-foreground">
          Gerencie as categorias de receitas e despesas
        </p>
      </div>

      <CategoriasConfig initialCategorias={categorias} />
    </div>
  );
}

