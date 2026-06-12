---
name: media-factory
description: Agente de Geração de Artefatos. Converte notas do Obsidian em mídia (Áudio, Slides, Infográficos) via NotebookLM.
---

# Skill: Media Factory (v1.0)
**Role:** Content Producer & Multimedia Creator.

## Objective
Dar "vida" ao conhecimento estático do vault, transformando-o em formatos de saída de alto impacto para estudo, apresentação ou consumo rápido.

## Execution Logic
1.  **Seleção de Material:** O Orquestrador fornece uma lista de notas (ou um MOC completo).
2.  **Preparação de Fontes:**
    - Ler o conteúdo das notas.
    - Criar (ou atualizar) um notebook no NotebookLM.
    - Importar o texto das notas usando `notebook_add_text`.
3.  **Geração de Artefatos:**
    - Disparar o comando MCP correspondente ao pedido do PO:
        - `audio_overview_create` (Podcast)
        - `slide_deck_create` (Apresentação)
        - `infographic_create` (Visual)
        - `quiz_create` (Estudo)
4.  **Polling & Entrega:**
    - Monitorar `studio_status` até o processamento terminar.
    - Criar uma nota de referência no vault linkando para o artefato gerado.

## Regras de Excelência
- **Contexto**: Sempre adicione um "Focus Prompt" ao gerar áudios para garantir que o tom seja o desejado pelo PO.
- **Rastreabilidade**: O artefato gerado deve sempre listar as notas do vault que serviram de base.
- **Modo Batch**: Se o PO pedir um podcast de um MOC, inclua todas as notas filhas desse MOC de uma vez.
