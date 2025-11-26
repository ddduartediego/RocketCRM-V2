"use client";

import { useEffect } from "react";
import { useForm, type Resolver } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import {
  contatoSchema,
  type ContatoFormData,
  tipoContatoOptions,
  estadosBrasileiros,
} from "@/lib/validations/contato";
import { createContato, updateContato } from "@/actions/contatos";
import { toast } from "sonner";
import { User, MapPin, Tag } from "lucide-react";
import type { Contato } from "@/types/database";

interface ContatoFormProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  contato?: Contato | null;
  onSuccess?: () => void;
}

export function ContatoForm({
  open,
  onOpenChange,
  contato,
  onSuccess,
}: ContatoFormProps) {
  const isEditing = !!contato;

  const form = useForm<ContatoFormData>({
    resolver: zodResolver(contatoSchema) as Resolver<ContatoFormData>,
    defaultValues: {
      nome: "",
      tipo: "pessoa_fisica",
      telefone: "",
      whatsapp: "",
      email: "",
      endereco: "",
      cidade: "",
      estado: "",
      cep: "",
      observacoes: "",
      tags: [],
    },
  });

  useEffect(() => {
    if (contato) {
      form.reset({
        nome: contato.nome,
        tipo: contato.tipo,
        telefone: contato.telefone || "",
        whatsapp: contato.whatsapp || "",
        email: contato.email || "",
        endereco: contato.endereco || "",
        cidade: contato.cidade || "",
        estado: contato.estado || "",
        cep: contato.cep || "",
        observacoes: contato.observacoes || "",
        tags: contato.tags || [],
      });
    } else {
      form.reset({
        nome: "",
        tipo: "pessoa_fisica",
        telefone: "",
        whatsapp: "",
        email: "",
        endereco: "",
        cidade: "",
        estado: "",
        cep: "",
        observacoes: "",
        tags: [],
      });
    }
  }, [contato, form]);

  const onSubmit = async (data: ContatoFormData) => {
    try {
      const result = isEditing
        ? await updateContato(contato!.id, data)
        : await createContato(data);

      if (result.error) {
        toast.error(isEditing ? "Erro ao atualizar" : "Erro ao criar", {
          description: result.error,
        });
        return;
      }

      toast.success(isEditing ? "Contato atualizado!" : "Contato criado!", {
        description: `${data.nome} foi ${isEditing ? "atualizado" : "adicionado"} com sucesso.`,
      });

      onOpenChange(false);
      onSuccess?.();
    } catch {
      toast.error("Erro inesperado", {
        description: "Tente novamente mais tarde.",
      });
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>
            {isEditing ? "Editar Contato" : "Novo Contato"}
          </DialogTitle>
          <DialogDescription>
            {isEditing
              ? "Atualize as informações do contato"
              : "Preencha os dados para criar um novo contato"}
          </DialogDescription>
        </DialogHeader>

        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
            <Tabs defaultValue="dados" className="w-full">
              <TabsList className="grid w-full grid-cols-3">
                <TabsTrigger value="dados" className="flex items-center gap-2">
                  <User className="w-4 h-4" />
                  Dados
                </TabsTrigger>
                <TabsTrigger value="endereco" className="flex items-center gap-2">
                  <MapPin className="w-4 h-4" />
                  Endereço
                </TabsTrigger>
                <TabsTrigger value="outros" className="flex items-center gap-2">
                  <Tag className="w-4 h-4" />
                  Outros
                </TabsTrigger>
              </TabsList>

              <TabsContent value="dados" className="space-y-4 pt-4">
                <div className="grid grid-cols-2 gap-4">
                  <FormField
                    control={form.control}
                    name="nome"
                    render={({ field }) => (
                      <FormItem className="col-span-2">
                        <FormLabel>Nome *</FormLabel>
                        <FormControl>
                          <Input placeholder="Nome completo" {...field} />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="tipo"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Tipo *</FormLabel>
                        <Select
                          onValueChange={field.onChange}
                          defaultValue={field.value}
                          value={field.value}
                        >
                          <FormControl>
                            <SelectTrigger>
                              <SelectValue placeholder="Selecione o tipo" />
                            </SelectTrigger>
                          </FormControl>
                          <SelectContent>
                            {tipoContatoOptions.map((option) => (
                              <SelectItem key={option.value} value={option.value}>
                                {option.label}
                              </SelectItem>
                            ))}
                          </SelectContent>
                        </Select>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="email"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Email</FormLabel>
                        <FormControl>
                          <Input
                            type="email"
                            placeholder="email@exemplo.com"
                            {...field}
                            value={field.value || ""}
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="telefone"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Telefone</FormLabel>
                        <FormControl>
                          <Input
                            placeholder="(00) 0000-0000"
                            {...field}
                            value={field.value || ""}
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="whatsapp"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>WhatsApp</FormLabel>
                        <FormControl>
                          <Input
                            placeholder="(00) 00000-0000"
                            {...field}
                            value={field.value || ""}
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                </div>
              </TabsContent>

              <TabsContent value="endereco" className="space-y-4 pt-4">
                <div className="grid grid-cols-2 gap-4">
                  <FormField
                    control={form.control}
                    name="cep"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>CEP</FormLabel>
                        <FormControl>
                          <Input
                            placeholder="00000-000"
                            {...field}
                            value={field.value || ""}
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <div />

                  <FormField
                    control={form.control}
                    name="endereco"
                    render={({ field }) => (
                      <FormItem className="col-span-2">
                        <FormLabel>Endereço</FormLabel>
                        <FormControl>
                          <Input
                            placeholder="Rua, número, complemento"
                            {...field}
                            value={field.value || ""}
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="cidade"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Cidade</FormLabel>
                        <FormControl>
                          <Input
                            placeholder="Cidade"
                            {...field}
                            value={field.value || ""}
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="estado"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Estado</FormLabel>
                        <Select
                          onValueChange={field.onChange}
                          value={field.value || ""}
                        >
                          <FormControl>
                            <SelectTrigger>
                              <SelectValue placeholder="Selecione" />
                            </SelectTrigger>
                          </FormControl>
                          <SelectContent>
                            {estadosBrasileiros.map((estado) => (
                              <SelectItem key={estado.value} value={estado.value}>
                                {estado.label}
                              </SelectItem>
                            ))}
                          </SelectContent>
                        </Select>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                </div>
              </TabsContent>

              <TabsContent value="outros" className="space-y-4 pt-4">
                <FormField
                  control={form.control}
                  name="observacoes"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Observações</FormLabel>
                      <FormControl>
                        <Textarea
                          placeholder="Anotações sobre o contato..."
                          className="min-h-[100px]"
                          {...field}
                          value={field.value || ""}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </TabsContent>
            </Tabs>

            <div className="flex justify-end gap-3 pt-4 border-t">
              <Button
                type="button"
                variant="outline"
                onClick={() => onOpenChange(false)}
              >
                Cancelar
              </Button>
              <Button type="submit" disabled={form.formState.isSubmitting}>
                {form.formState.isSubmitting
                  ? "Salvando..."
                  : isEditing
                    ? "Salvar alterações"
                    : "Criar contato"}
              </Button>
            </div>
          </form>
        </Form>
      </DialogContent>
    </Dialog>
  );
}

