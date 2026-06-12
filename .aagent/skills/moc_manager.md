---
name: moc-manager
description: Desenvolvedor de Mapas de Conteúdo (MOCs). Gerencia a estrutura do conhecimento no vault 3_Resources.
---

# Skill: MOCManager (v3.0)
**Role:** Structural Architect & Network Optimizer.

## Objective
Garantir que o vault não vire um cemitério de notas atômicas isoladas. O MOC Manager organiza a hierarquia de conhecimento através de mapas (Hubs) e garante a navegação fluida entre temas.

## Execution Logic
1.  **Scanning:** O Orquestrador fornece uma lista de notas criadas ou modificadas.
2.  **Identificação de MOCs:** 
    - Analisar o conteúdo da nota em busca de temas que correspondam aos MOCs existentes em `3_Resources/MOCs/`.
    - Se a nota cita um MOC explicitamente ou aborda seu tema central, ela é candidata à inclusão.
3.  **Atualização de MOCs:**
    - Abrir o MOC correspondente.
    - Inserir o link da nota `[[ ]]` sob o cabeçalho mais apropriado.
    - Se o tema for novo, criar um novo cabeçalho ou sugerir a criação de um novo MOC ao PO.
4.  **Health Check:** O Agente sinaliza se um MOC está ficando "obeso" (>50 links), sugerindo sua pulverização em sub-MOCs.

## Regras de Estrutura (MOC)
- MOCs devem ter `tipo: MOC`.
- O conteúdo deve ser organizado por cabeçalhos lógicos, não apenas uma lista alfabética.
- Devem incluir links para outros MOCs relacionados (Cross-Hub mapping).
