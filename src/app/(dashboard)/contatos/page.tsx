import { Suspense } from "react";
import { getContatos } from "@/actions/contatos";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";
import { Users } from "lucide-react";
import { ContatosFilters, ContatosPagination, ContatosClient } from "@/components/modules/contatos";
import { ContatoFormTrigger } from "./contato-form-trigger";

export const dynamic = "force-dynamic";

interface PageProps {
  searchParams: Promise<{
    search?: string;
    tipo?: string;
    page?: string;
  }>;
}

const PER_PAGE = 10;

async function ContatosList({ searchParams }: { searchParams: { search?: string; tipo?: string; page?: string } }) {
  const { data: contatos, count } = await getContatos({
    search: searchParams.search,
    tipo: searchParams.tipo,
    page: Number(searchParams.page) || 1,
    perPage: PER_PAGE,
  });

  return (
    <>
      <ContatosClient contatos={contatos} />
      <ContatosPagination total={count} perPage={PER_PAGE} />
    </>
  );
}

function ContatosListSkeleton() {
  return (
    <div className="space-y-3">
      {Array.from({ length: 5 }).map((_, i) => (
        <div key={i} className="flex items-center gap-4 p-4 border rounded-lg">
          <Skeleton className="w-10 h-10 rounded-full" />
          <div className="space-y-2 flex-1">
            <Skeleton className="h-4 w-1/3" />
            <Skeleton className="h-3 w-1/4" />
          </div>
          <Skeleton className="h-8 w-24" />
        </div>
      ))}
    </div>
  );
}

export default async function ContatosPage({ searchParams }: PageProps) {
  const params = await searchParams;

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-foreground flex items-center gap-2">
            <Users className="w-7 h-7 text-primary" />
            Contatos
          </h1>
          <p className="text-muted-foreground">
            Gerencie seus contatos, clientes e fornecedores
          </p>
        </div>
        <ContatoFormTrigger />
      </div>

      {/* Filtros */}
      <Card>
        <CardHeader className="pb-3">
          <CardTitle className="text-base">Filtros</CardTitle>
          <CardDescription>Encontre contatos rapidamente</CardDescription>
        </CardHeader>
        <CardContent>
          <Suspense fallback={<Skeleton className="h-10 w-full" />}>
            <ContatosFilters />
          </Suspense>
        </CardContent>
      </Card>

      {/* Lista de Contatos */}
      <Card>
        <CardContent className="pt-6">
          <Suspense fallback={<ContatosListSkeleton />}>
            <ContatosList searchParams={params} />
          </Suspense>
        </CardContent>
      </Card>
    </div>
  );
}

