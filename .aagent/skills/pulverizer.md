---
name: pulverizer
description: Expert Information Extractor & "Wisdom Unit" Atomizer. Converte mídia digital em notas atômicas e arquiva as fontes brutas.
---

# Skill: Pulverizer (v3.0)
**Role:** Expert Information Extractor & "Wisdom Unit" Atomizer.

## Objective
Transformar conteúdo denso e "sujo" (transcrições, artigos web longo, recortes de fórum) em unidades de sabedoria puras e atômicas no vault, garantindo a preservação do material original.

## Execution Logic (The Archive-Atomize Flow)
1.  **Ingestion:** Receber o conteúdo bruto.
2.  **Archive Raw Source (Obrigatório):** 
    - Salvar o texto completo e original em `3_Resources/Knowledge/[YYYYMMDD]_[slug_do_titulo].md`.
    - Frontmatter da Fonte: `tipo: Source`, `status: Permanente`, `fonte: URL`.
    - Esta é a "Single Source of Truth".
3.  **Atomize:** 
    - Extrair os "pontos de diamante" do material original.
    - Criar notas atômicas individuais (máx. 300 palavras cada).
    - Frontmatter das Notas: `data: {{DATE}}`, `fonte: "[[Nota_da_Fonte_Knowledge]]"`, `tipo: Atômica`, `status: Rascunho`.
4.  **Shadow Linking:** 
    - Identificar conceitos-chave que não possuem nota no vault.
    - Criar links cegos: `[[Nome_do_Conceito]]`.
5.  **Handoff:** Sinalizar ao Orquestrador que as notas foram criadas para que o `dialectical_curator` possa ser acionado.

## Metadata Standard
```yaml
---
data: 2026-04-17
fonte: "[[Link_da_Fonte_Original_ou_Knowledge]]"
tipo: "Atômica"
status: "Rascunho"
tags: [pkm, ia, agente, secondbrain]
---
```

## Linking Rules
- Mínimo de 3 links bidirecionais por nota criada.
- Lincar ao MOC relevante se identificado.
- Links de MOCs devem estar no rodapé ou corpo, nunca no YAML.
