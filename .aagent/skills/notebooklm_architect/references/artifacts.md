# Artefatos NotebookLM — Guia Completo

Todos os artefatos requerem `confirm=True` após confirmação do usuário.
Artefatos assíncronos exigem polling via `studio_status`.

---

## Artefatos Assíncronos (Requerem Polling)

### Audio Overview
- **Ferramenta**: `audio_overview_create`
- **Parâmetros úteis**: `format` (deep_dive | brief | critique | debate), `language`, `focus_prompt`
- **Polling**: `studio_status(notebook_id)` a cada 60s
- **Entrega**: URL de download de arquivo de áudio (MP3)
- **Tempo típico**: 3–8 minutos

```
audio_overview_create(notebook_id, format="deep_dive", language="pt", confirm=True)
  ↓ loop até studio_status retornar artifact.status="completed"
  → retornar artifact.url ao usuário
```

### Slide Deck
- **Ferramenta**: `slide_deck_create`
- **Parâmetros úteis**: `format` (detailed_deck | presenter_slides), `length` (short | default), `language`, `focus_prompt`
- **Polling**: `studio_status(notebook_id)` a cada 60s
- **Entrega**: Link para Google Slides (exportável como PPTX)
- **Tempo típico**: 2–5 minutos

### Infographic
- **Ferramenta**: `infographic_create`
- **Parâmetros úteis**: `orientation` (landscape | portrait | square), `detail_level` (concise | standard | detailed), `language`, `focus_prompt`
- **Polling**: `studio_status(notebook_id)` a cada 60s
- **Entrega**: Link de imagem para download (PNG/JPG)
- **Tempo típico**: 2–4 minutos

### Video Overview
- **Ferramenta**: `video_overview_create`
- **Parâmetros úteis**: `format` (explainer | brief), `visual_style` (auto_select | classic | whiteboard | kawaii | anime), `language`, `focus_prompt`
- **Polling**: `studio_status(notebook_id)` a cada 60–120s
- **Entrega**: URL de download de vídeo (MP4)
- **Tempo típico**: 10–20 minutos

---

## Artefatos Síncronos (Resposta Imediata)

### Mind Map
- **Ferramenta**: `mind_map_create`
- **Entrega**: Dados estruturados (nós e conexões) inline na resposta
- **Conversão para Obsidian**: Converter para JSON Canvas e salvar em `0_Inbox/`
- **Conversão para HTML**: Gerar HTML interativo com D3.js ou similar para visualização no browser

**Template JSON Canvas para Obsidian:**
```json
{
  "nodes": [
    {"id": "root", "type": "text", "text": "Tema Central", "x": 0, "y": 0, "width": 200, "height": 60},
    {"id": "n1", "type": "text", "text": "Subtópico 1", "x": 300, "y": -100, "width": 160, "height": 50}
  ],
  "edges": [
    {"id": "e1", "fromNode": "root", "toNode": "n1"}
  ]
}
```
Salvar como `.canvas` para abrir nativamente no Obsidian.

### Report / Briefing Doc
- **Ferramenta**: `report_create`
- **Parâmetros**: `report_format` (Briefing Doc | Study Guide | Blog Post | Create Your Own)
- **Entrega**: Texto Markdown inline
- **Ação**: Salvar diretamente em `0_Inbox/` com frontmatter do vault

### Flashcards
- **Ferramenta**: `flashcards_create`
- **Parâmetros**: `difficulty` (easy | medium | hard)
- **Entrega**: Texto Markdown com pares pergunta/resposta
- **Ação**: Salvar em `0_Inbox/` — compatível com plugins de spaced repetition (Anki, Obsidian SR)

### Data Table
- **Ferramenta**: `data_table_create`
- **Parâmetros**: `description` (descrição da tabela desejada)
- **Entrega**: Tabela Markdown inline

### Quiz
- **Ferramenta**: `quiz_create`
- **Parâmetros**: `question_count` (padrão: 2), `difficulty`
- **Entrega**: Questões de múltipla escolha em Markdown

---

## Protocolo de Polling (Padrão)

```python
# Pseudocódigo para artefatos assíncronos
criar_artefato(notebook_id, confirm=True)

# Polling loop
while True:
    status = studio_status(notebook_id)
    for artifact in status.artifacts:
        if artifact.status == "completed":
            retornar artifact.url  # sucesso
        elif artifact.status == "failed":
            reportar erro ao usuário
    aguardar 60 segundos
    # Timeout máximo: 20 minutos
```

## Comportamento Esperado do `studio_status`

O retorno contém uma lista de artefatos com campos:
- `type`: tipo do artefato (audio, slides, infographic, video, mind_map)
- `status`: `generating` | `completed` | `failed`
- `url`: disponível apenas quando `status = "completed"`

> **Atenção**: Múltiplos artefatos podem existir no estúdio simultaneamente. Filtrar pelo `type` pedido.
