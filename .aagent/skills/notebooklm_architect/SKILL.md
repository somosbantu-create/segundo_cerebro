---
name: notebooklm-architect
description: Protocolo de operação para integração completa com o Google NotebookLM via MCP. Use esta skill quando o usuário quiser: (1) inserir fontes (URL, texto, Google Drive) em notebooks, (2) executar pesquisa profunda (Deep Research) e importar resultados, (3) criar artefatos (Audio Overview, Slide Deck, Infographic, Mind Map, Report, Flashcards), (4) consultar conteúdo existente nos notebooks, ou (5) sincronizar artefatos textuais com o Obsidian (Segundo Cérebro).
---

# NotebookLM Architect

Protocolo de operação para o MCP `notebooklm-mcp-server`. Garante que nenhuma etapa crítica
seja pulada, especialmente no fluxo de importação de pesquisa e geração de artefatos assíncronos.

## Regra #1 — Verificação de Auth

**Antes de qualquer operação de escrita**, executar `notebook_list`.

- ✅ Resposta normal → prosseguir
- ❌ `RPC Error 16` → auth expirado. Instruir usuário:
  ```
  Execute no terminal: notebooklm-mcp-auth --file
  Siga as instruções para extrair cookies do Chrome e cole quando solicitado.
  ```
  Após confirmação, tentar `notebook_list` novamente antes de continuar.

> Tokens expiram em ~48h. Nunca assuma que a sessão está válida se a última operação foi há mais de 24h.

## Regra #2 — Deep Research (Nunca Pular o Import)

Fluxo obrigatório — cada etapa depende da anterior:

```
research_start(query, notebook_id, mode="fast"|"deep")
  ↓
research_status(notebook_id, max_wait=300, poll_interval=30)
  ↓  ← aguardar status="completed" antes de continuar
research_import(notebook_id, task_id)
  ↓
notebook_get(notebook_id)  ← confirmar que a fonte apareceu
```

A falha mais comum é executar `research_import` antes de `research_status` concluir,
ou omitir o `research_import` completamente. Ambos resultam em importação silenciosamente falhada.

## Regra #3 — Artefatos Assíncronos Exigem Polling

Audio, Slides, Infographic e Video são gerados de forma assíncrona.
**Nunca retornar ao usuário sem confirmar que a geração concluiu.**

```
[artifact]_create(notebook_id, confirm=True)
  ↓
studio_status(notebook_id)  ← poll a cada 60s até artifact.status="completed"
  ↓
retornar URL/link ao usuário
```

Ver detalhes completos por tipo de artefato em: `references/artifacts.md`

## Regra #4 — Sincronia com Obsidian

Para artefatos textuais (Reports, Flashcards, Mind Map):
- Salvar em `C:\Users\Vinicius\0_projetos\segundo cerebro\segundo cerebro\0_Inbox\`
- Usar frontmatter padrão do vault (data, fonte, tipo, status, tags)
- Linkar ao MOC correspondente

Para artefatos de mídia (Audio, Slides, Infographic):
- Criar nota de referência em `0_Inbox/` com o link e metadados
- Protocolo "Resumo + Link" já estabelecido no vault

## Regra #5 — Gap Research Assistido (Shadow Linking)

Ao realizar uma auditoria ou leitura densa, se o Agente detectar múltiplos **Shadow Links** (links formatados como `[[Conceito Ausente]]` que não possuem arquivo .md associado):
1. O Agente deve registrar essas lacunas mentalmente.
2. O Agente **DEVE SEMPRE** gerar um prompt questionando o PO: *"Levantei 5 lacunas críticas (Shadow Links). Deseja que eu ative o módulo NotebookLM Deep Research para criar a fundamentação teórica de [Lista das lacunas]?"*
3. **Somente após a aprovação do usuário**, o agente executará a `research_start`. A criação não-supervisionada de fundações empilha débito técnico.

## Decision Flow

```
Usuário menciona NotebookLM ou pede artefato
  ↓
Verificar auth (notebook_list)
  ↓ auth ok
Qual é o objetivo?
  ├── Inserir fonte    → notebook_add_url / notebook_add_text / notebook_add_drive
  ├── Pesquisa        → Regra #2 (research_start → status → import)
  ├── Criar artefato  → Regra #3 + ver references/artifacts.md
  ├── Consultar       → notebook_query(notebook_id, query)
  └── Descrever       → notebook_describe(notebook_id)
```

## Referências

- **Tipos de Artefato e Polling**: `references/artifacts.md`
- **Protocolo Deep Research completo**: `references/workflow.md`
