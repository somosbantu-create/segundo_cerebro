#!/bin/bash

echo "=========================================="
echo " 🚀 Setup do Segundo Cerebro Agentico"
echo "=========================================="
echo ""

VAULT_PATH="vault"
TEMPLATE_PATH="vault-template"

# 1. Verifica Node e Git
echo "[1/4] Verificando dependencias..."
if ! command -v git &> /dev/null; then
    echo "Aviso: Git nao encontrado. Recomendavel instalar."
fi
if ! command -v node &> /dev/null; then
    echo "Aviso: Node.js nao encontrado. Necessario para servidores MCP."
fi

# 2. Configura a Constellation
echo "[2/4] Configurando constellation.yaml..."
if [ ! -f "constellation.yaml" ]; then
    cp constellation.example.yaml constellation.yaml
    echo "  > constellation.yaml criado."
else
    echo "  > constellation.yaml ja existe."
fi

# 3. Cria o Vault
echo "[3/4] Inicializando o Vault..."
if [ ! -d "$VAULT_PATH" ]; then
    cp -r "$TEMPLATE_PATH" "$VAULT_PATH"
    echo "  > Pasta vault/ criada a partir do template."
    
    echo -n "Qual o seu nome para o Agente chama-lo? "
    read USER_NAME
    if [ -z "$USER_NAME" ]; then
        USER_NAME="Usuario"
    fi
    
    # Substitui nome no arquivo de instrucoes
    INST_FILE="$VAULT_PATH/Instrucoes_Agente.md"
    if [ -f "$INST_FILE" ]; then
        ABS_PATH=$(pwd)/$VAULT_PATH
        # Funciona em mac e linux
        sed -i.bak "s/{{USER_NAME}}/$USER_NAME/g" "$INST_FILE"
        sed -i.bak "s|{{VAULT_PATH}}|$ABS_PATH|g" "$INST_FILE"
        rm -f "$INST_FILE.bak"
        echo "  > Instrucoes do agente personalizadas para $USER_NAME."
    fi
else
    echo "  > A pasta vault/ ja existe. Pulando criacao."
fi

echo "[4/4] Finalizando!"
echo "=========================================="
echo "✅ Setup concluido com sucesso."
echo "Siga os proximos passos no README.md para:"
echo "1. Configurar servidores MCP no seu Editor IA (Cursor/Roo Code/Antigravity)"
echo "2. Inserir suas chaves no constellation.yaml"
echo "3. Abrir a pasta '$VAULT_PATH' no Obsidian."
echo "=========================================="
