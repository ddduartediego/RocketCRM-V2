"use client";

import { useState } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { Badge } from "@/components/ui/badge";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import { Plus, Pencil, Trash2, GripVertical, Trophy, XCircle } from "lucide-react";
import { toast } from "sonner";
import {
  createEtapaFunil,
  updateEtapaFunil,
  deleteEtapaFunil,
} from "@/actions/configuracoes";
import type { EtapaFunil } from "@/types/database";

interface FunilConfigProps {
  initialEtapas: EtapaFunil[];
}

const coresPadrao = [
  "#e4027d", // rosa
  "#341c44", // roxo escuro
  "#0ea5e9", // azul
  "#22c55e", // verde
  "#eab308", // amarelo
  "#f97316", // laranja
  "#dc2626", // vermelho
  "#8b5cf6", // violeta
];

export function FunilConfig({ initialEtapas }: FunilConfigProps) {
  const [etapas, setEtapas] = useState(initialEtapas);
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  const [editingEtapa, setEditingEtapa] = useState<EtapaFunil | null>(null);
  const [deleteId, setDeleteId] = useState<string | null>(null);

  // Form state
  const [nome, setNome] = useState("");
  const [cor, setCor] = useState(coresPadrao[0]);
  const [isFinal, setIsFinal] = useState(false);
  const [isPerdido, setIsPerdido] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  function openDialog(etapa?: EtapaFunil) {
    if (etapa) {
      setEditingEtapa(etapa);
      setNome(etapa.nome);
      setCor(etapa.cor);
      setIsFinal(etapa.is_final);
      setIsPerdido(etapa.is_perdido);
    } else {
      setEditingEtapa(null);
      setNome("");
      setCor(coresPadrao[0]);
      setIsFinal(false);
      setIsPerdido(false);
    }
    setIsDialogOpen(true);
  }

  async function handleSave() {
    if (!nome.trim()) {
      toast.error("Nome é obrigatório");
      return;
    }

    setIsLoading(true);
    try {
      if (editingEtapa) {
        const result = await updateEtapaFunil(editingEtapa.id, {
          nome,
          cor,
          is_final: isFinal,
          is_perdido: isPerdido,
        });

        if (result.error) {
          toast.error(result.error);
          return;
        }

        setEtapas((prev) =>
          prev.map((e) =>
            e.id === editingEtapa.id
              ? { ...e, nome, cor, is_final: isFinal, is_perdido: isPerdido }
              : e
          )
        );
        toast.success("Etapa atualizada!");
      } else {
        const result = await createEtapaFunil({
          nome,
          cor,
          is_final: isFinal,
          is_perdido: isPerdido,
        });

        if (result.error) {
          toast.error(result.error);
          return;
        }

        if (result.data) {
          setEtapas((prev) => [...prev, result.data as EtapaFunil]);
        }
        toast.success("Etapa criada!");
      }

      setIsDialogOpen(false);
    } finally {
      setIsLoading(false);
    }
  }

  async function handleDelete() {
    if (!deleteId) return;

    setIsLoading(true);
    try {
      const result = await deleteEtapaFunil(deleteId);

      if (result.error) {
        toast.error(result.error);
        return;
      }

      setEtapas((prev) => prev.filter((e) => e.id !== deleteId));
      toast.success("Etapa excluída!");
    } finally {
      setIsLoading(false);
      setDeleteId(null);
    }
  }

  async function handleToggleAtivo(etapa: EtapaFunil) {
    const result = await updateEtapaFunil(etapa.id, { ativo: !etapa.ativo });

    if (result.error) {
      toast.error(result.error);
      return;
    }

    setEtapas((prev) =>
      prev.map((e) => (e.id === etapa.id ? { ...e, ativo: !e.ativo } : e))
    );
    toast.success(etapa.ativo ? "Etapa desativada" : "Etapa ativada");
  }

  return (
    <div className="space-y-6 max-w-3xl">
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle>Etapas do Funil</CardTitle>
              <CardDescription>
                Arraste para reordenar as etapas do funil de vendas
              </CardDescription>
            </div>
            <Dialog open={isDialogOpen} onOpenChange={setIsDialogOpen}>
              <DialogTrigger asChild>
                <Button onClick={() => openDialog()}>
                  <Plus className="mr-2 h-4 w-4" />
                  Nova Etapa
                </Button>
              </DialogTrigger>
              <DialogContent>
                <DialogHeader>
                  <DialogTitle>
                    {editingEtapa ? "Editar Etapa" : "Nova Etapa"}
                  </DialogTitle>
                </DialogHeader>
                <div className="space-y-4 py-4">
                  <div className="space-y-2">
                    <Label>Nome da Etapa</Label>
                    <Input
                      value={nome}
                      onChange={(e) => setNome(e.target.value)}
                      placeholder="Ex: Negociação"
                    />
                  </div>

                  <div className="space-y-2">
                    <Label>Cor</Label>
                    <div className="flex flex-wrap gap-2">
                      {coresPadrao.map((c) => (
                        <button
                          key={c}
                          type="button"
                          onClick={() => setCor(c)}
                          className={`w-8 h-8 rounded-full transition-all ${
                            cor === c ? "ring-2 ring-offset-2 ring-primary" : ""
                          }`}
                          style={{ backgroundColor: c }}
                        />
                      ))}
                    </div>
                    <Input
                      type="color"
                      value={cor}
                      onChange={(e) => setCor(e.target.value)}
                      className="w-full h-10 mt-2"
                    />
                  </div>

                  <div className="flex items-center justify-between">
                    <div className="space-y-0.5">
                      <Label>Etapa de Ganho</Label>
                      <p className="text-xs text-muted-foreground">
                        Marca o lead como ganho ao chegar nesta etapa
                      </p>
                    </div>
                    <Switch
                      checked={isFinal}
                      onCheckedChange={(checked) => {
                        setIsFinal(checked);
                        if (checked) setIsPerdido(false);
                      }}
                    />
                  </div>

                  <div className="flex items-center justify-between">
                    <div className="space-y-0.5">
                      <Label>Etapa de Perda</Label>
                      <p className="text-xs text-muted-foreground">
                        Marca o lead como perdido ao chegar nesta etapa
                      </p>
                    </div>
                    <Switch
                      checked={isPerdido}
                      onCheckedChange={(checked) => {
                        setIsPerdido(checked);
                        if (checked) setIsFinal(false);
                      }}
                    />
                  </div>

                  <div className="flex justify-end gap-3 pt-4">
                    <Button
                      variant="outline"
                      onClick={() => setIsDialogOpen(false)}
                    >
                      Cancelar
                    </Button>
                    <Button onClick={handleSave} disabled={isLoading}>
                      {isLoading ? "Salvando..." : "Salvar"}
                    </Button>
                  </div>
                </div>
              </DialogContent>
            </Dialog>
          </div>
        </CardHeader>
        <CardContent>
          <div className="space-y-2">
            {etapas.map((etapa, index) => (
              <div
                key={etapa.id}
                className={`flex items-center gap-3 p-3 rounded-lg border ${
                  etapa.ativo ? "bg-card" : "bg-muted opacity-60"
                }`}
              >
                <GripVertical className="h-5 w-5 text-muted-foreground cursor-grab" />
                <div
                  className="w-4 h-4 rounded-full"
                  style={{ backgroundColor: etapa.cor }}
                />
                <div className="flex-1">
                  <div className="flex items-center gap-2">
                    <span className="font-medium">{etapa.nome}</span>
                    {etapa.is_final && (
                      <Badge variant="outline" className="text-green-600 border-green-600">
                        <Trophy className="w-3 h-3 mr-1" />
                        Ganho
                      </Badge>
                    )}
                    {etapa.is_perdido && (
                      <Badge variant="outline" className="text-red-600 border-red-600">
                        <XCircle className="w-3 h-3 mr-1" />
                        Perdido
                      </Badge>
                    )}
                    {!etapa.ativo && (
                      <Badge variant="secondary">Inativo</Badge>
                    )}
                  </div>
                  <p className="text-xs text-muted-foreground">
                    Ordem: {index + 1}
                  </p>
                </div>
                <div className="flex items-center gap-2">
                  <Switch
                    checked={etapa.ativo}
                    onCheckedChange={() => handleToggleAtivo(etapa)}
                  />
                  <Button
                    variant="ghost"
                    size="icon"
                    onClick={() => openDialog(etapa)}
                  >
                    <Pencil className="h-4 w-4" />
                  </Button>
                  <Button
                    variant="ghost"
                    size="icon"
                    onClick={() => setDeleteId(etapa.id)}
                  >
                    <Trash2 className="h-4 w-4 text-destructive" />
                  </Button>
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      <AlertDialog open={!!deleteId} onOpenChange={() => setDeleteId(null)}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Confirmar exclusão</AlertDialogTitle>
            <AlertDialogDescription>
              Tem certeza que deseja excluir esta etapa? Esta ação não pode ser
              desfeita. Leads associados precisarão ser movidos primeiro.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancelar</AlertDialogCancel>
            <AlertDialogAction
              onClick={handleDelete}
              className="bg-destructive hover:bg-destructive/90"
            >
              Excluir
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}

