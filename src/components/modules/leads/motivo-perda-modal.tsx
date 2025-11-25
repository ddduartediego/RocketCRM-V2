"use client";

import { useState } from "react";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { AlertTriangle } from "lucide-react";

interface MotivoPerdaModalProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  onConfirm: (motivo: string) => void;
}

const motivosPredefinidos = [
  { value: "preco", label: "Preço acima do orçamento" },
  { value: "concorrencia", label: "Perdeu para concorrente" },
  { value: "desistencia", label: "Cliente desistiu" },
  { value: "data", label: "Data não disponível" },
  { value: "sem_retorno", label: "Sem retorno do cliente" },
  { value: "outro", label: "Outro motivo" },
];

export function MotivoPerdaModal({
  open,
  onOpenChange,
  onConfirm,
}: MotivoPerdaModalProps) {
  const [motivoSelecionado, setMotivoSelecionado] = useState("");
  const [descricao, setDescricao] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleConfirm = async () => {
    const motivo =
      motivoSelecionado === "outro"
        ? descricao
        : motivosPredefinidos.find((m) => m.value === motivoSelecionado)?.label ||
          descricao;

    if (!motivo.trim()) {
      return;
    }

    setIsSubmitting(true);
    await onConfirm(motivo);
    setIsSubmitting(false);
    setMotivoSelecionado("");
    setDescricao("");
  };

  const handleClose = (open: boolean) => {
    if (!open) {
      setMotivoSelecionado("");
      setDescricao("");
    }
    onOpenChange(open);
  };

  return (
    <Dialog open={open} onOpenChange={handleClose}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-full bg-destructive/10 flex items-center justify-center">
              <AlertTriangle className="w-5 h-5 text-destructive" />
            </div>
            <div>
              <DialogTitle>Marcar como Perdido</DialogTitle>
              <DialogDescription>
                Informe o motivo da perda deste lead
              </DialogDescription>
            </div>
          </div>
        </DialogHeader>

        <div className="space-y-4 py-4">
          <div className="space-y-2">
            <Label>Motivo da perda</Label>
            <Select value={motivoSelecionado} onValueChange={setMotivoSelecionado}>
              <SelectTrigger>
                <SelectValue placeholder="Selecione um motivo" />
              </SelectTrigger>
              <SelectContent>
                {motivosPredefinidos.map((motivo) => (
                  <SelectItem key={motivo.value} value={motivo.value}>
                    {motivo.label}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          {motivoSelecionado === "outro" && (
            <div className="space-y-2">
              <Label>Descreva o motivo</Label>
              <Textarea
                placeholder="Explique o motivo da perda..."
                value={descricao}
                onChange={(e) => setDescricao(e.target.value)}
                className="min-h-[80px]"
              />
            </div>
          )}
        </div>

        <DialogFooter>
          <Button
            variant="outline"
            onClick={() => handleClose(false)}
            disabled={isSubmitting}
          >
            Cancelar
          </Button>
          <Button
            variant="destructive"
            onClick={handleConfirm}
            disabled={
              isSubmitting ||
              (!motivoSelecionado && !descricao.trim()) ||
              (motivoSelecionado === "outro" && !descricao.trim())
            }
          >
            {isSubmitting ? "Salvando..." : "Confirmar perda"}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

