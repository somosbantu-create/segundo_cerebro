# 🌌 Segundo Cérebro (Agentic Framework v6.0)

> O sistema operacional de conhecimento e produtividade open-source que pensa com você.

O **Segundo Cérebro** não é apenas um lugar para guardar notas. É um ecossistema multi-agente projetado para funcionar dentro do seu editor IA favorito (como Antigravity, Roo Code/Cline, Cursor, Windsurf, Open Code ou Hermes), transformando informação bruta em execução ativa.

---

## 🚀 Como Iniciar (Para novos usuários)

Este repositório é um *template*. Para iniciar o seu Segundo Cérebro do zero:

1. **Clone o Repositório**:
   ```bash
   git clone <[url-deste-repo](https://github.com/somosbantu-create/segundo_cerebro)> meu-segundo-cerebro
   cd meu-segundo-cerebro
   ```

2. **Execute o Setup Automático**:
   - No Windows: `./install.ps1`
   - No macOS/Linux: `./install.sh`
   
   *O script irá criar sua pasta `vault/` vazia com o método PARA, configurar seu nome nas instruções da IA e gerar o arquivo de configuração `constellation.yaml`.*

3. **Abra o Vault no Obsidian**:
   Abra o aplicativo Obsidian e escolha "Open folder as vault". Selecione a pasta `vault/` recém-criada.

4. **Conecte seu Editor IA**:
   Abra a pasta **raiz do projeto** (`meu-segundo-cerebro/`) no seu editor de Inteligência Artificial preferido (Cursor, VSCode com Roo Code, Antigravity, etc.). O agente detectará a pasta `.aagent/` e o `constellation.yaml` automaticamente, ganhando suas habilidades.

---

## 🧠 A Constelação de Agentes

O framework opera através de uma rede de agentes ("Skills") definida na pasta `.aagent/skills/`. O **Orquestrador** lê essas fichas e escolhe a ferramenta ideal para cada tarefa:

| Agente | Especialidade | Ação |
| :--- | :--- | :--- |
| **⚡ Pulverizador** | Ingestão atômica de dados | Arquivamento Raw, Atomização de notas longas |
| **🔗 Curador** | Conexões e dialética | Mapeamento de ideias e injeção de conexões |
| **🌐 Web Scout** | Captura Web e YouTube | Processamento de URLs e transcrições |
| **📚 Arquiteto** | Pesquisa profunda | Consulta ao NotebookLM e estruturação |
| **🎓 Scholar** | Pesquisa acadêmica | Integração com Zotero para recuperar papers |
| **🔍 Auditor** | Saúde do vault e métricas | Varredura de links órfãos e notas perdidas |
| **🛡️ Guardião** | Hábitos e Processos | Sincronização de tarefas com Notion |
| **📅 Tracker** | Agenda e Deadlines | Sincronização com Google Calendar |

---

## 🛠️ Configuração de Conectores (MCP)

Para que os agentes especialistas (como o Tracker, Guardião ou Arquiteto) funcionem com potencial máximo, eles precisam acessar seus dados externos através de **Model Context Protocol (MCP)**.

Edite o arquivo `constellation.yaml` gerado pelo setup e configure os serviços que desejar:

### 1. Notion MCP (Para o Agente Guardião)
- Instale a integração via pacote MCP: `@modelcontextprotocol/server-notion`
- Acesse `https://www.notion.so/my-integrations` e crie uma nova "Internal Integration".
- Compartilhe as páginas ou bancos de dados do seu Notion com esta integração recém-criada.
- Cole o `Internal Integration Token` no `constellation.yaml` e no arquivo de configuração do MCP da sua IDE.

### 2. Google Cloud / Calendar (Para o Agente Tracker)
- Acesse o Google Cloud Console, crie um projeto e ative as APIs do **Google Calendar** e **Google Drive**.
- Crie uma Service Account e faça o download do arquivo de chaves JSON.
- Forneça o caminho absoluto desse JSON no seu `constellation.yaml`.
- Compartilhe sua agenda do Google com o email da Service Account.

### 3. NotebookLM e Zotero
- Para o **Zotero**: Forneça sua API Key (gerada no site do Zotero) e o seu User ID no arquivo de configuração.
- O pacote `notebooklm-mcp-server` pode ser ativado nas configurações da sua IDE para habilitar o Arquiteto a ingerir vastas quantidades de PDFs.

---

## 📁 Estrutura de Diretórios e Regras de Segurança

Para garantir a privacidade das suas notas, o arquivo `.gitignore` base proíbe que qualquer pasta contendo suas notas de fato (como `/vault/` ou a antiga `/segundo cerebro/`) seja comitada no repositório.

**Assim, você pode ter o repositório da engine (`.aagent`, scripts, configurações gerais) hospedado no GitHub da sua equipe, enquanto as notas de cada membro ficam estritamente locais.**

---

*Desenvolvido para pensar de forma distribuída.*
