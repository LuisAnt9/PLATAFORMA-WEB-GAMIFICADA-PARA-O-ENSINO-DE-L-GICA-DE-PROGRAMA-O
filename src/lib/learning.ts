import type { Catalog } from "./catalog";
import type { Progress } from "./gamification";

/** Parte dos exercícios de um módulo que o aluno precisa resolver para liberar o seguinte. */
export const UNLOCK_RATIO = 0.7;

export interface ModuleState {
  total: number;
  done: number;
  /** Quantos resolvidos liberam o próximo módulo. */
  needed: number;
  /** Liberado no modo aprendizado. */
  unlocked: boolean;
  /** Já resolveu o suficiente para liberar o próximo. */
  complete: boolean;
  /** Módulo anterior que precisa ser concluído (só quando bloqueado). */
  blockedBy: { id: string; title: string } | null;
}

/**
 * Estado de cada módulo no modo aprendizado, como na trilha de conceitos do Exercism:
 * o primeiro módulo já vem liberado e os outros liberam quando o módulo anterior chega a 70%.
 * Módulos sem exercícios publicados são ignorados (não travam ninguém), e lições complementares
 * (`optional`) são liberadas como as demais, mas não bloqueiam as seguintes.
 */
export function moduleStates(
  catalog: Catalog,
  progress: Progress,
): Record<string, ModuleState> {
  const out: Record<string, ModuleState> = {};
  const ordered = [...catalog.modules].sort((a, b) => a.position - b.position);
  type Prev = { id: string; title: string; complete: boolean };
  let previous = null as Prev | null;
  for (const m of ordered) {
    const list = catalog.exercises.filter(
      (e) => e.moduleId === m.id && e.published,
    );
    if (list.length === 0) continue;
    const done = list.filter((e) => progress[e.id]?.solved).length;
    const needed = Math.ceil(list.length * UNLOCK_RATIO);
    const unlocked: boolean = previous === null || previous.complete;
    const complete = done >= needed;
    out[m.id] = {
      total: list.length,
      done,
      needed,
      unlocked,
      complete,
      blockedBy:
        unlocked || !previous
          ? null
          : { id: previous.id, title: previous.title },
    };
    // Lições complementares podem ser estudadas, mas não seguram a próxima lição.
    if (!m.optional) {
      previous = { id: m.id, title: m.title, complete: unlocked && complete };
    }
  }
  return out;
}
