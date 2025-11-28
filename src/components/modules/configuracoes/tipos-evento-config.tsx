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
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { Plus, Pencil, Trash2, GripVertical, Smile } from "lucide-react";
import { toast } from "sonner";
import {
  createTipoEvento,
  updateTipoEvento,
  deleteTipoEvento,
} from "@/actions/configuracoes";
import type { TipoEventoRow } from "@/types/database";

interface TiposEventoConfigProps {
  initialTipos: TipoEventoRow[];
}

const coresPadrao = [
  "#22c55e", // verde
  "#e4027d", // rosa
  "#0ea5e9", // azul
  "#eab308", // amarelo
  "#f97316", // laranja
  "#dc2626", // vermelho
  "#8b5cf6", // violeta
  "#341c44", // roxo escuro
  "#6b7280", // cinza
];

const iconesPadrao = [
  "🏕️", "🎈", "🏃", "📅", "🎉", "🎊", "🎪", "🎭",
  "🎨", "🎯", "🎲", "🎸", "🎹", "🎤", "🎬", "🎠",
  "🏆", "⚽", "🏀", "🎾", "🏊", "🚀", "✨", "💫",
];

export function TiposEventoConfig({ initialTipos }: TiposEventoConfigProps) {
  const [tipos, setTipos] = useState(initialTipos);
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  const [editingTipo, setEditingTipo] = useState<TipoEventoRow | null>(null);
  const [deleteId, setDeleteId] = useState<string | null>(null);

  // Form state
  const [nome, setNome] = useState("");
  const [icone, setIcone] = useState("📅");
  const [cor, setCor] = useState(coresPadrao[0]);
  const [isLoading, setIsLoading] = useState(false);

  function openDialog(tipo?: TipoEventoRow) {
    if (tipo) {
      setEditingTipo(tipo);
      setNome(tipo.nome);
      setIcone(tipo.icone);
      setCor(tipo.cor);
    } else {
      setEditingTipo(null);
      setNome("");
      setIcone("📅");
      setCor(coresPadrao[0]);
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
      if (editingTipo) {
        const result = await updateTipoEvento(editingTipo.id, {
          nome,
          icone,
          cor,
        });

        if (result.error) {
          toast.error(result.error);
          return;
        }

        setTipos((prev) =>
          prev.map((t) =>
            t.id === editingTipo.id ? { ...t, nome, icone, cor } : t
          )
        );
        toast.success("Tipo de evento atualizado!");
      } else {
        const result = await createTipoEvento({
          nome,
          icone,
          cor,
        });

        if (result.error) {
          toast.error(result.error);
          return;
        }

        if (result.data) {
          setTipos((prev) => [...prev, result.data as TipoEventoRow]);
        }
        toast.success("Tipo de evento criado!");
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
      const result = await deleteTipoEvento(deleteId);

      if (result.error) {
        toast.error(result.error);
        return;
      }

      setTipos((prev) => prev.filter((t) => t.id !== deleteId));
      toast.success("Tipo de evento excluído!");
    } finally {
      setIsLoading(false);
      setDeleteId(null);
    }
  }

  async function handleToggleAtivo(tipo: TipoEventoRow) {
    const result = await updateTipoEvento(tipo.id, { ativo: !tipo.ativo });

    if (result.error) {
      toast.error(result.error);
      return;
    }

    setTipos((prev) =>
      prev.map((t) => (t.id === tipo.id ? { ...t, ativo: !t.ativo } : t))
    );
    toast.success(tipo.ativo ? "Tipo desativado" : "Tipo ativado");
  }

  return (
    <div className="space-y-6 max-w-3xl">
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle>Tipos de Evento</CardTitle>
              <CardDescription>
                Configure os tipos de eventos disponíveis no sistema
              </CardDescription>
            </div>
            <Dialog open={isDialogOpen} onOpenChange={setIsDialogOpen}>
              <DialogTrigger asChild>
                <Button onClick={() => openDialog()}>
                  <Plus className="mr-2 h-4 w-4" />
                  Novo Tipo
                </Button>
              </DialogTrigger>
              <DialogContent>
                <DialogHeader>
                  <DialogTitle>
                    {editingTipo ? "Editar Tipo de Evento" : "Novo Tipo de Evento"}
                  </DialogTitle>
                </DialogHeader>
                <div className="space-y-4 py-4">
                  <div className="space-y-2">
                    <Label>Nome do Tipo</Label>
                    <Input
                      value={nome}
                      onChange={(e) => setNome(e.target.value)}
                      placeholder="Ex: Workshop"
                    />
                  </div>

                  <div className="space-y-2">
                    <Label>Ícone</Label>
                    <Popover>
                      <PopoverTrigger asChild>
                        <Button
                          variant="outline"
                          className="w-full justify-start gap-2"
                        >
                          <span className="text-xl">{icone}</span>
                          <span className="text-muted-foreground">Selecionar ícone</span>
                          <Smile className="ml-auto h-4 w-4 opacity-50" />
                        </Button>
                      </PopoverTrigger>
                      <PopoverContent className="w-64 p-3" align="start">
                        <div className="grid grid-cols-8 gap-1">
                          {iconesPadrao.map((emoji) => (
                            <button
                              key={emoji}
                              type="button"
                              onClick={() => setIcone(emoji)}
                              className={`p-2 text-xl rounded-md hover:bg-accent transition-colors ${
                                icone === emoji ? "bg-accent ring-2 ring-primary" : ""
                              }`}
                            >
                              {emoji}
                            </button>
                          ))}
                        </div>
                        <div className="mt-3 pt-3 border-t">
                          <Label className="text-xs text-muted-foreground">Ou digite um emoji:</Label>
                          <Input
                            value={icone}
                            onChange={(e) => setIcone(e.target.value)}
                            className="mt-1 text-center text-xl"
                            maxLength={2}
                          />
                        </div>
                      </PopoverContent>
                    </Popover>
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

                  {/* Preview */}
                  <div className="space-y-2">
                    <Label>Preview</Label>
                    <div className="flex items-center gap-3 p-3 rounded-lg border bg-card">
                      <div
                        className="w-8 h-8 rounded-lg flex items-center justify-center text-lg"
                        style={{ backgroundColor: cor + "20" }}
                      >
                        {icone}
                      </div>
                      <span className="font-medium">{nome || "Nome do tipo"}</span>
                    </div>
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
          {tipos.length === 0 ? (
            <p className="text-center text-muted-foreground py-8">
              Nenhum tipo de evento cadastrado
            </p>
          ) : (
            <div className="space-y-2">
              {tipos.map((tipo, index) => (
                <div
                  key={tipo.id}
                  className={`flex items-center gap-3 p-3 rounded-lg border ${
                    tipo.ativo ? "bg-card" : "bg-muted opacity-60"
                  }`}
                >
                  <GripVertical className="h-5 w-5 text-muted-foreground cursor-grab" />
                  <div
                    className="w-8 h-8 rounded-lg flex items-center justify-center text-lg flex-shrink-0"
                    style={{ backgroundColor: tipo.cor + "20" }}
                  >
                    {tipo.icone}
                  </div>
                  <div className="flex-1">
                    <div className="flex items-center gap-2">
                      <span className="font-medium">{tipo.nome}</span>
                      {!tipo.ativo && (
                        <Badge variant="secondary">Inativo</Badge>
                      )}
                    </div>
                    <p className="text-xs text-muted-foreground">
                      Ordem: {index + 1}
                    </p>
                  </div>
                  <div
                    className="w-4 h-4 rounded-full flex-shrink-0"
                    style={{ backgroundColor: tipo.cor }}
                  />
                  <div className="flex items-center gap-2">
                    <Switch
                      checked={tipo.ativo}
                      onCheckedChange={() => handleToggleAtivo(tipo)}
                    />
                    <Button
                      variant="ghost"
                      size="icon"
                      onClick={() => openDialog(tipo)}
                    >
                      <Pencil className="h-4 w-4" />
                    </Button>
                    <Button
                      variant="ghost"
                      size="icon"
                      onClick={() => setDeleteId(tipo.id)}
                    >
                      <Trash2 className="h-4 w-4 text-destructive" />
                    </Button>
                  </div>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>

      <AlertDialog open={!!deleteId} onOpenChange={() => setDeleteId(null)}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Confirmar exclusão</AlertDialogTitle>
            <AlertDialogDescription>
              Tem certeza que deseja excluir este tipo de evento? Esta ação não pode
              ser desfeita. Eventos e leads associados precisarão ter o tipo alterado primeiro.
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


