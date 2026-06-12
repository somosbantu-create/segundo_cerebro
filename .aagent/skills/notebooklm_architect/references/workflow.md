# Protocolo Deep Research — Guia Completo

O fluxo de Deep Research é o mais frágil da integração. Toda falha de importação ocorre
por pular ou não aguardar uma das etapas abaixo.

---

## Fluxo Obrigatório (Nunca Pular Etapas)

```
ETAPA 1: Iniciar pesquisa
research_start(
  query="tema a pesquisar",
  notebook_id="uuid-do-notebook",  ← opcional, cria novo se omitido
  mode="fast" | "deep",            ← fast ~30s/10 fontes | deep ~5min/40 fontes
  source="web" | "drive"
)
→ retorna: task_id

ETAPA 2: Aguardar conclusão (CRÍTICA — nunca pular)
research_status(
  notebook_id="uuid",
  task_id="task-id-da-etapa-1",   ← usar task_id específico
  max_wait=300,                    ← 300s para fast | 600s para deep
  poll_interval=30
)
→ aguardar status="completed"
→ retorna: lista de fontes encontradas, task_id confirmado

ETAPA 3: Importar fontes (ROOT CAUSE da falha anterior)
research_import(
  notebook_id="uuid",
  task_id="task-id",
  source_indices=null              ← null = importar todas | [0,1,2] = selecionar
)
→ retorna: confirmação de importação

ETAPA 4: Verificar importação
notebook_get(notebook_id="uuid")
→ confirmar que as novas fontes aparecem na lista de sources
```

---

## Guia de Escolha de Mode

| Situação | Mode Recomendado |
|---|---|
| Consulta rápida, tema bem definido | `fast` (~30s, ~10 fontes) |
| Pesquisa acadêmica/profunda | `deep` (~5min, ~40 fontes, apenas web) |
| Buscar documentos no Google Drive | `fast` com `source="drive"` |
| Tema técnico com muitas nuances | `deep` |

---

## Seleção de Fontes para Importação

Após `research_status`, as fontes são listadas com índices `[0, 1, 2, ...]`.
Por padrão (`source_indices=null`), todas são importadas.

Para importar seletivamente (ex: apenas as 3 melhores):
```
research_import(notebook_id, task_id, source_indices=[0, 1, 2])
```

**Quando selecionar**: Pesquisas `deep` retornam ~40 fontes. Se muitas forem irrelevantes,
filtrar evita poluição do contexto do notebook.

---

## Erros Comuns e Soluções

| Erro | Causa | Solução |
|---|---|---|
| Importação não aparece no notebook | `research_import` pulado ou chamado antes de `status=completed` | Sempre aguardar `research_status` antes do `research_import` |
| `research_status` timeout | Pesquisa deep levou mais de 5min | Aumentar `max_wait=600` para mode deep |
| Fontes duplicadas no notebook | `research_import` chamado duas vezes | Verificar com `notebook_get` antes de reimportar |
| `RPC Error 16` em qualquer etapa | Auth expirado | Re-auth com `notebooklm-mcp-auth --file` e recomeçar do início |
| Task não encontrado | `task_id` inválido ou de outra sessão | Iniciar nova pesquisa com `research_start` |

---

## Fluxo Completo — Exemplo Real

```
# Pesquisar e importar fontes sobre Montagem Soviética
1. research_start(
     query="montagem soviética Eisenstein cinema teoria",
     notebook_id="meu-notebook-teoria-audiovisual",
     mode="fast"
   )
   → task_id: "abc123"

2. research_status(notebook_id="meu-notebook", task_id="abc123", max_wait=300)
   → Aguardar... status: "completed"
   → 10 fontes encontradas: [Eisenstein Wikipedia, dossiê BFI, ...]

3. research_import(notebook_id="meu-notebook", task_id="abc123")
   → Importadas: 10 fontes

4. notebook_get(notebook_id="meu-notebook")
   → sources: [...10 novas fontes listadas...]  ✅

5. [opcional] notebook_query(notebook_id, "Como Eisenstein define o conflito de montagem?")
   → Resposta fundamentada nas fontes importadas
```

---

## Após a Importação — Possíveis Ações

```
notebook_describe()    → resumo das fontes + tópicos sugeridos
notebook_query()       → perguntas sobre o conteúdo
[artefato]_create()   → gerar Audio, Slides, etc. (ver artifacts.md)
```
