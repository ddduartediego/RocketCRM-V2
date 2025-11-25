"use client";

import { useState } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
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
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Plus, Pencil, Trash2, ArrowUpCircle, ArrowDownCircle } from "lucide-react";
import { toast } from "sonner";
import {
  createCategoriaFinanceira,
  updateCategoriaFinanceira,
  deleteCategoriaFinanceira,
} from "@/actions/configuracoes";
import type { CategoriaFinanceira } from "@/types/database";

interface CategoriasConfigProps {
  initialCategorias: CategoriaFinanceira[];
}

const coresPadrao = [
  "#22c55e", // verde
  "#dc2626", // vermelho
  "#0ea5e9", // azul
  "#eab308", // amarelo
  "#f97316", // laranja
  "#e4027d", // rosa
  "#8b5cf6", // violeta
  "#341c44", // roxo escuro
];

export function CategoriasConfig({ initialCategorias }: CategoriasConfigProps) {
  const [categorias, setCategorias] = useState(initialCategorias);
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  const [editingCategoria, setEditingCategoria] = useState<CategoriaFinanceira | null>(null);
  const [deleteId, setDeleteId] = useState<string | null>(null);

  // Form state
  const [nome, setNome] = useState("");
  const [tipo, setTipo] = useState<"receita" | "despesa">("receita");
  const [cor, setCor] = useState(coresPadrao[0]);
  const [isLoading, setIsLoading] = useState(false);

  const receitas = categorias.filter((c) => c.tipo === "receita");
  const despesas = categorias.filter((c) => c.tipo === "despesa");

  function openDialog(categoria?: CategoriaFinanceira) {
    if (categoria) {
      setEditingCategoria(categoria);
      setNome(categoria.nome);
      setTipo(categoria.tipo);
      setCor(categoria.cor || coresPadrao[0]);
    } else {
      setEditingCategoria(null);
      setNome("");
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
      if (editingCategoria) {
        const result = await updateCategoriaFinanceira(editingCategoria.id, {
          nome,
          cor,
        });

        if (result.error) {
          toast.error(result.error);
          return;
        }

        setCategorias((prev) =>
          prev.map((c) =>
            c.id === editingCategoria.id ? { ...c, nome, cor } : c
          )
        );
        toast.success("Categoria atualizada!");
      } else {
        const result = await createCategoriaFinanceira({
          nome,
          tipo,
          cor,
        });

        if (result.error) {
          toast.error(result.error);
          return;
        }

        if (result.data) {
          setCategorias((prev) => [...prev, result.data as CategoriaFinanceira]);
        }
        toast.success("Categoria criada!");
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
      const result = await deleteCategoriaFinanceira(deleteId);

      if (result.error) {
        toast.error(result.error);
        return;
      }

      setCategorias((prev) => prev.filter((c) => c.id !== deleteId));
      toast.success("Categoria excluída!");
    } finally {
      setIsLoading(false);
      setDeleteId(null);
    }
  }

  async function handleToggleAtivo(categoria: CategoriaFinanceira) {
    const result = await updateCategoriaFinanceira(categoria.id, {
      ativo: !categoria.ativo,
    });

    if (result.error) {
      toast.error(result.error);
      return;
    }

    setCategorias((prev) =>
      prev.map((c) => (c.id === categoria.id ? { ...c, ativo: !c.ativo } : c))
    );
    toast.success(categoria.ativo ? "Categoria desativada" : "Categoria ativada");
  }

  function renderCategoriasLista(lista: CategoriaFinanceira[]) {
    if (lista.length === 0) {
      return (
        <p className="text-center text-muted-foreground py-8">
          Nenhuma categoria cadastrada
        </p>
      );
    }

    return (
      <div className="space-y-2">
        {lista.map((categoria) => (
          <div
            key={categoria.id}
            className={`flex items-center gap-3 p-3 rounded-lg border ${
              categoria.ativo ? "bg-card" : "bg-muted opacity-60"
            }`}
          >
            <div
              className="w-4 h-4 rounded-full"
              style={{ backgroundColor: categoria.cor || "#6b7280" }}
            />
            <div className="flex-1">
              <span className="font-medium">{categoria.nome}</span>
              {!categoria.ativo && (
                <Badge variant="secondary" className="ml-2">
                  Inativo
                </Badge>
              )}
            </div>
            <div className="flex items-center gap-2">
              <Switch
                checked={categoria.ativo}
                onCheckedChange={() => handleToggleAtivo(categoria)}
              />
              <Button
                variant="ghost"
                size="icon"
                onClick={() => openDialog(categoria)}
              >
                <Pencil className="h-4 w-4" />
              </Button>
              <Button
                variant="ghost"
                size="icon"
                onClick={() => setDeleteId(categoria.id)}
              >
                <Trash2 className="h-4 w-4 text-destructive" />
              </Button>
            </div>
          </div>
        ))}
      </div>
    );
  }

  return (
    <div className="space-y-6 max-w-3xl">
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle>Categorias</CardTitle>
              <CardDescription>
                Organize suas receitas e despesas por categorias
              </CardDescription>
            </div>
            <Dialog open={isDialogOpen} onOpenChange={setIsDialogOpen}>
              <DialogTrigger asChild>
                <Button onClick={() => openDialog()}>
                  <Plus className="mr-2 h-4 w-4" />
                  Nova Categoria
                </Button>
              </DialogTrigger>
              <DialogContent>
                <DialogHeader>
                  <DialogTitle>
                    {editingCategoria ? "Editar Categoria" : "Nova Categoria"}
                  </DialogTitle>
                </DialogHeader>
                <div className="space-y-4 py-4">
                  <div className="space-y-2">
                    <Label>Nome da Categoria</Label>
                    <Input
                      value={nome}
                      onChange={(e) => setNome(e.target.value)}
                      placeholder="Ex: Transporte"
                    />
                  </div>

                  {!editingCategoria && (
                    <div className="space-y-2">
                      <Label>Tipo</Label>
                      <Select
                        value={tipo}
                        onValueChange={(value) =>
                          setTipo(value as "receita" | "despesa")
                        }
                      >
                        <SelectTrigger>
                          <SelectValue />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="receita">
                            <div className="flex items-center gap-2">
                              <ArrowUpCircle className="h-4 w-4 text-green-600" />
                              Receita
                            </div>
                          </SelectItem>
                          <SelectItem value="despesa">
                            <div className="flex items-center gap-2">
                              <ArrowDownCircle className="h-4 w-4 text-red-600" />
                              Despesa
                            </div>
                          </SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                  )}

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
          <Tabs defaultValue="receitas">
            <TabsList className="grid w-full grid-cols-2">
              <TabsTrigger value="receitas" className="gap-2">
                <ArrowUpCircle className="h-4 w-4 text-green-600" />
                Receitas ({receitas.length})
              </TabsTrigger>
              <TabsTrigger value="despesas" className="gap-2">
                <ArrowDownCircle className="h-4 w-4 text-red-600" />
                Despesas ({despesas.length})
              </TabsTrigger>
            </TabsList>
            <TabsContent value="receitas" className="pt-4">
              {renderCategoriasLista(receitas)}
            </TabsContent>
            <TabsContent value="despesas" className="pt-4">
              {renderCategoriasLista(despesas)}
            </TabsContent>
          </Tabs>
        </CardContent>
      </Card>

      <AlertDialog open={!!deleteId} onOpenChange={() => setDeleteId(null)}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Confirmar exclusão</AlertDialogTitle>
            <AlertDialogDescription>
              Tem certeza que deseja excluir esta categoria? Esta ação não pode
              ser desfeita. Transações associadas precisarão ter a categoria
              removida primeiro.
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

