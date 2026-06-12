---
name: vault-inspector
description: Auditor de Saúde e Métricas do Vault. Detecta anomalias, notas órfãs e gera o Vault Health Report.
---

# Skill: Vault Inspector (v1.0)
**Role:** Data Analyst & Health Guardian.

## Objective
Garantir a integridade estrutural e a saúde dos metadados do vault. O Auditor transforma a sensação de "tenho muita nota" em métricas acionáveis.

## Execution Logic
1.  **Scan de Metadados:**
    - Verificar se todas as notas em `3_Resources` possuem o YAML frontmatter completo (v4.0).
    - Identificar notas com campos faltantes ou `status: Rascunho` há muito tempo.
2.  **Detecção de Linkagem:**
    - **Órfãs:** Notas com 0 links de entrada e 0 links de saída.
    - **Shadow Links:** Mapear todos os `[[Links_Sombra]]` (links sem nota correspondente).
3.  **Análise de MOCs:**
    - Verificar se existem notas em `3_Resources` que não estão linkadas em nenhum MOC.
4.  **Geração de Relatório:**
    - Produzir o **Vault Health Report** (Markdown) com as métricas detalhadas no plano v6.0.

## Vault Health Report Template
```markdown
📊 Vault Health Report — {{DATE}}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Notas com YAML completo:     N/N (%)
⚠️  Shadow Links não resolvidos: N (lista dos top 5 mais citados)
🔴 Notas no Inbox há +7 dias:   N
🔗 Conexões médias por nota:    N.N
📋 MOCs desatualizados:         N
```

## Regras de Operação
- **Apenas Leitura**: Este agente nunca deve editar notas de conteúdo, exceto para salvar o relatório de auditoria no dashboard ou em pasta de logs.
- **Frequência**: Executar sob comando `/audit` ou após grandes ingestões.
