"use client";

import {
  Sheet,
  SheetContent,
  SheetDescription,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Separator } from "@/components/ui/separator";
import {
  User,
  Mail,
  Phone,
  MapPin,
  Building2,
  Calendar,
  Pencil,
  MessageSquare,
} from "lucide-react";
import type { Contato } from "@/types/database";

interface ContatoDetailProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  contato: (Contato & { organizacoes?: { nome: string } | null }) | null;
  onEdit: (contato: Contato) => void;
}

const tipoLabels: Record<string, string> = {
  pessoa_fisica: "Pessoa Física",
  escola: "Escola",
  empresa: "Empresa",
  fornecedor: "Fornecedor",
};

export function ContatoDetail({
  open,
  onOpenChange,
  contato,
  onEdit,
}: ContatoDetailProps) {
  if (!contato) return null;

  const formatDate = (date: string) => {
    return new Date(date).toLocaleDateString("pt-BR", {
      day: "2-digit",
      month: "long",
      year: "numeric",
    });
  };

  return (
    <Sheet open={open} onOpenChange={onOpenChange}>
      <SheetContent className="w-full sm:max-w-lg overflow-y-auto">
        <SheetHeader className="pb-4">
          <div className="flex items-start justify-between">
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center">
                <User className="w-6 h-6 text-primary" />
              </div>
              <div>
                <SheetTitle className="text-left">{contato.nome}</SheetTitle>
                <SheetDescription className="text-left">
                  <Badge variant="outline" className="mt-1">
                    {tipoLabels[contato.tipo] || contato.tipo}
                  </Badge>
                </SheetDescription>
              </div>
            </div>
            <Button
              variant="outline"
              size="sm"
              onClick={() => {
                onOpenChange(false);
                setTimeout(() => onEdit(contato), 150);
              }}
            >
              <Pencil className="w-4 h-4 mr-2" />
              Editar
            </Button>
          </div>
        </SheetHeader>

        <Separator className="my-4" />

        {/* Tags */}
        {contato.tags && contato.tags.length > 0 && (
          <div className="mb-6">
            <h4 className="text-sm font-medium text-muted-foreground mb-2">
              Tags
            </h4>
            <div className="flex flex-wrap gap-2">
              {contato.tags.map((tag) => (
                <Badge
                  key={tag}
                  variant="outline"
                  className="bg-primary-soft/10 text-primary border-primary/20"
                >
                  {tag}
                </Badge>
              ))}
            </div>
          </div>
        )}

        {/* Informações de Contato */}
        <div className="space-y-6">
          <div>
            <h4 className="text-sm font-medium text-muted-foreground mb-3">
              Informações de Contato
            </h4>
            <div className="space-y-3">
              {contato.email && (
                <div className="flex items-center gap-3">
                  <div className="w-8 h-8 rounded-lg bg-muted flex items-center justify-center">
                    <Mail className="w-4 h-4 text-muted-foreground" />
                  </div>
                  <div>
                    <p className="text-xs text-muted-foreground">Email</p>
                    <a
                      href={`mailto:${contato.email}`}
                      className="text-sm hover:text-primary"
                    >
                      {contato.email}
                    </a>
                  </div>
                </div>
              )}

              {contato.telefone && (
                <div className="flex items-center gap-3">
                  <div className="w-8 h-8 rounded-lg bg-muted flex items-center justify-center">
                    <Phone className="w-4 h-4 text-muted-foreground" />
                  </div>
                  <div>
                    <p className="text-xs text-muted-foreground">Telefone</p>
                    <a
                      href={`tel:${contato.telefone}`}
                      className="text-sm hover:text-primary"
                    >
                      {contato.telefone}
                    </a>
                  </div>
                </div>
              )}

              {contato.whatsapp && (
                <div className="flex items-center gap-3">
                  <div className="w-8 h-8 rounded-lg bg-success/10 flex items-center justify-center">
                    <MessageSquare className="w-4 h-4 text-success" />
                  </div>
                  <div>
                    <p className="text-xs text-muted-foreground">WhatsApp</p>
                    <a
                      href={`https://wa.me/55${contato.whatsapp.replace(/\D/g, "")}`}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="text-sm hover:text-primary"
                    >
                      {contato.whatsapp}
                    </a>
                  </div>
                </div>
              )}
            </div>
          </div>

          {/* Organização */}
          {contato.organizacoes?.nome && (
            <div>
              <h4 className="text-sm font-medium text-muted-foreground mb-3">
                Organização
              </h4>
              <div className="flex items-center gap-3">
                <div className="w-8 h-8 rounded-lg bg-muted flex items-center justify-center">
                  <Building2 className="w-4 h-4 text-muted-foreground" />
                </div>
                <span className="text-sm">{contato.organizacoes.nome}</span>
              </div>
            </div>
          )}

          {/* Endereço */}
          {(contato.endereco || contato.cidade) && (
            <div>
              <h4 className="text-sm font-medium text-muted-foreground mb-3">
                Endereço
              </h4>
              <div className="flex items-start gap-3">
                <div className="w-8 h-8 rounded-lg bg-muted flex items-center justify-center shrink-0">
                  <MapPin className="w-4 h-4 text-muted-foreground" />
                </div>
                <div className="text-sm">
                  {contato.endereco && <p>{contato.endereco}</p>}
                  {(contato.cidade || contato.estado) && (
                    <p className="text-muted-foreground">
                      {contato.cidade}
                      {contato.cidade && contato.estado && " - "}
                      {contato.estado}
                      {contato.cep && ` • CEP: ${contato.cep}`}
                    </p>
                  )}
                </div>
              </div>
            </div>
          )}

          {/* Observações */}
          {contato.observacoes && (
            <div>
              <h4 className="text-sm font-medium text-muted-foreground mb-3">
                Observações
              </h4>
              <p className="text-sm text-muted-foreground bg-muted/50 rounded-lg p-3">
                {contato.observacoes}
              </p>
            </div>
          )}

          {/* Metadados */}
          <Separator />
          <div className="flex items-center gap-3 text-xs text-muted-foreground">
            <Calendar className="w-4 h-4" />
            <span>Criado em {formatDate(contato.created_at)}</span>
          </div>
        </div>
      </SheetContent>
    </Sheet>
  );
}

