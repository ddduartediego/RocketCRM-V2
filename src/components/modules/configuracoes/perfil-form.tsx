"use client";

import { useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
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
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { toast } from "sonner";
import { updatePerfil } from "@/actions/configuracoes";
import { User } from "lucide-react";

const perfilSchema = z.object({
  nome: z.string().min(2, "Nome deve ter no mínimo 2 caracteres"),
});

type PerfilFormData = z.infer<typeof perfilSchema>;

interface PerfilFormProps {
  user: {
    id: string;
    nome: string;
    email: string;
    avatar_url: string | null;
  };
}

export function PerfilForm({ user }: PerfilFormProps) {
  const [isLoading, setIsLoading] = useState(false);

  const form = useForm<PerfilFormData>({
    resolver: zodResolver(perfilSchema),
    defaultValues: {
      nome: user.nome,
    },
  });

  async function onSubmit(data: PerfilFormData) {
    setIsLoading(true);
    try {
      const result = await updatePerfil(user.id, data);

      if (result.error) {
        toast.error(result.error);
        return;
      }

      toast.success("Perfil atualizado com sucesso!");
    } catch {
      toast.error("Ocorreu um erro. Tente novamente.");
    } finally {
      setIsLoading(false);
    }
  }

  const getInitials = (name: string) => {
    return name
      .split(" ")
      .map((n) => n[0])
      .join("")
      .toUpperCase()
      .slice(0, 2);
  };

  return (
    <div className="grid gap-6 max-w-2xl">
      {/* Avatar e informações básicas */}
      <Card>
        <CardHeader>
          <CardTitle>Informações Pessoais</CardTitle>
          <CardDescription>
            Atualize suas informações de perfil
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="flex items-center gap-6 mb-6">
            <Avatar className="h-20 w-20">
              <AvatarImage src={user.avatar_url || undefined} />
              <AvatarFallback className="text-xl bg-primary text-primary-foreground">
                {user.nome ? getInitials(user.nome) : <User className="h-8 w-8" />}
              </AvatarFallback>
            </Avatar>
            <div>
              <h3 className="font-semibold text-lg">{user.nome}</h3>
              <p className="text-sm text-muted-foreground">{user.email}</p>
              <p className="text-xs text-muted-foreground mt-1">
                A foto de perfil é sincronizada com sua conta Google
              </p>
            </div>
          </div>

          <Form {...form}>
            <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
              <FormField
                control={form.control}
                name="nome"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Nome completo</FormLabel>
                    <FormControl>
                      <Input placeholder="Seu nome" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <div className="space-y-2">
                <FormLabel>Email</FormLabel>
                <Input value={user.email} disabled />
                <p className="text-xs text-muted-foreground">
                  O email não pode ser alterado pois está vinculado à sua conta Google
                </p>
              </div>

              <div className="flex justify-end">
                <Button type="submit" disabled={isLoading}>
                  {isLoading ? "Salvando..." : "Salvar Alterações"}
                </Button>
              </div>
            </form>
          </Form>
        </CardContent>
      </Card>

      {/* Informações da conta */}
      <Card>
        <CardHeader>
          <CardTitle>Informações da Conta</CardTitle>
          <CardDescription>
            Detalhes sobre sua conta
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="flex items-center justify-between py-2">
            <div>
              <p className="font-medium">Autenticação</p>
              <p className="text-sm text-muted-foreground">
                Conectado via Google OAuth
              </p>
            </div>
            <div className="flex items-center gap-2 text-sm text-success">
              <div className="w-2 h-2 rounded-full bg-success" />
              Conectado
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}

