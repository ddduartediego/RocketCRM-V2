export const dynamic = "force-dynamic";

import { createClient } from "@/lib/supabase/server";
import { getResumoFinanceiro } from "@/actions/financeiro";
import { getEstatisticasEventosMes } from "@/actions/eventos";
import { getEstatisticasLeadsMes } from "@/actions/leads";
import { getEstatisticasTarefasMes } from "@/actions/atividades";
import { DashboardClient } from "@/components/modules/dashboard";

export default async function DashboardPage() {
  const supabase = await createClient();

  // Mês atual no formato YYYY-MM
  const agora = new Date();
  const mesAtual = `${agora.getFullYear()}-${String(agora.getMonth() + 1).padStart(2, "0")}`;

  // Buscar dados para o dashboard
  const [
    { count: totalLeads },
    { count: totalEventos },
    { count: totalContatos },
    resumoFinanceiro,
    estatisticasEventos,
    estatisticasLeads,
    estatisticasTarefas,
  ] = await Promise.all([
    supabase.from("leads").select("*", { count: "exact", head: true }),
    supabase.from("eventos").select("*", { count: "exact", head: true }).eq("status", "confirmado"),
    supabase.from("contatos").select("*", { count: "exact", head: true }),
    getResumoFinanceiro(mesAtual),
    getEstatisticasEventosMes(mesAtual),
    getEstatisticasLeadsMes(mesAtual),
    getEstatisticasTarefasMes(mesAtual),
  ]);

  const initialData = {
    totalLeads: totalLeads || 0,
    totalEventos: totalEventos || 0,
    totalContatos: totalContatos || 0,
    resumoFinanceiro,
    estatisticasEventos,
    estatisticasLeads,
    estatisticasTarefas,
  };

  return (
    <DashboardClient 
      initialData={initialData} 
      initialMes={mesAtual} 
    />
  );
}
