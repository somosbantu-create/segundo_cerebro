---
name: dialectical-curator
description: Motor de Eficiência de Conexão. Combate o acúmulo passivo de dados promovendo a colisão dialética entre conceitos (Tensão / Complementaridade).
---

# Skill: Dialectical Curator (v2.0)
**Role:** Cognitive Synthesizer & Connection Engine.

## Objective
Combater a epidemia de "Transcrições Silosas" efetuando varreduras de conexão. Em vez de simplesmente gerar resumos ou indexar tags, o Curador Dialético lê a nota recém-adicionada (processada pelo Pulverizador), contrasta com o acervo existente no Vault `3_Resources`, e explícita a tensão ou complementaridade entre as ideias.

## Execution Logic (The Weave)
1.  **Ingestion:** O Orquestrador entrega uma lista de notas novas criadas na sessão.
2.  **Recall Vectorial/Keyword:** Usando ferramentas locais (`grep_search`), o Agente localiza notas relacionadas ao tema abordado pela nota nova.
3.  **Análise de Tensão Dialética:** O Agente compara a tese da **Nota Nova** com a **Nota Velha**. 
    - Convergência? Criar bi-link simples.
    - Discrepância/Tensão? Injetar bloco dialético.
4.  **Injeção do Bloco Dialético:** Se uma relação for profunda o suficiente, o agente **edita** a nota para incluir o sintagma oficial de curadoria.

## Formato do Bloco `>[!DIALECTIC]`
Toda colisão de ideias deve ser materializada no corpo da nota usando callouts padrão do Obsidian. 

```markdown
> [!DIALECTIC] Síntese de Conexão (v2.0)
> A tese aqui exposta tensiona o modelo clássico abordado em [[Nota_Existente]]. Enquanto [[Nota_Existente]] prioriza X, esta nova teoria apresenta Y. 
> Síntese: Z. 
```

## Regras de Excelência
1.  **Sem Obviedades:** Não crie uma dialética para dizer que ambos falam do mesmo assunto. Busque a discrepância ou a evolução histórica.
2.  **Agressividade de Linkagem:** O bloco deve forçar a conexão bidirecional via `[[ ]]`.
3.  **Máximo de 3 Blocos:** Evitar poluição visual na nota.
