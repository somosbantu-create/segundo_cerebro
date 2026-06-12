param(
    [switch]$Force = $false
)

Write-Host "=========================================="
Write-Host " 🚀 Setup do Segundo Cerebro Agentico"
Write-Host "=========================================="
Write-Host ""

$vaultPath = "vault"
$templatePath = "vault-template"

# 1. Verifica Node e Git
Write-Host "[1/4] Verificando dependencias..."
if (-not (Get-Command "git" -ErrorAction SilentlyContinue)) {
    Write-Warning "Git nao encontrado. Recomendavel instalar."
}
if (-not (Get-Command "node" -ErrorAction SilentlyContinue)) {
    Write-Warning "Node.js nao encontrado. Necessario para servidores MCP."
}

# 2. Configura a Constellation
Write-Host "[2/4] Configurando constellation.yaml..."
if (-not (Test-Path "constellation.yaml")) {
    Copy-Item "constellation.example.yaml" -Destination "constellation.yaml"
    Write-Host "  > constellation.yaml criado. Lembre-se de inserir suas chaves nele mais tarde."
} else {
    Write-Host "  > constellation.yaml ja existe."
}

# 3. Cria o Vault
Write-Host "[3/4] Inicializando o Vault..."
if (-not (Test-Path $vaultPath)) {
    Copy-Item -Path $templatePath -Destination $vaultPath -Recurse
    Write-Host "  > Pasta vault/ criada a partir do template."
    
    # Pergunta nome do usuario
    $userName = Read-Host "Qual o seu nome para o Agente chama-lo?"
    if ([string]::IsNullOrWhiteSpace($userName)) { $userName = "Usuario" }
    
    # Substitui nome no arquivo de instrucoes
    $instFile = "$vaultPath\Instrucoes_Agente.md"
    if (Test-Path $instFile) {
        $content = Get-Content $instFile -Raw
        $content = $content -replace '\{\{USER_NAME\}\}', $userName
        $content = $content -replace '\{\{VAULT_PATH\}\}', (Resolve-Path $vaultPath).Path
        $content | Set-Content $instFile
        Write-Host "  > Instrucoes do agente personalizadas para $userName."
    }
} else {
    Write-Host "  > A pasta vault/ ja existe. Pulando criacao."
}

Write-Host "[4/4] Finalizando!"
Write-Host "=========================================="
Write-Host "✅ Setup concluido com sucesso."
Write-Host "Siga os proximos passos no README.md para:"
Write-Host "1. Configurar servidores MCP no seu Editor IA (Cursor/Roo Code/Antigravity)"
Write-Host "2. Inserir suas chaves no constellation.yaml"
Write-Host "3. Abrir a pasta '$vaultPath' no Obsidian."
Write-Host "=========================================="
