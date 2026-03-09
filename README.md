# myhub-datatable

Repositório de versionamento do schema do banco de dados MySQL do projeto FaciHub.

## Estrutura do Projeto

```
src/
├── tables/          DDL de tabelas (CREATE TABLE, ALTER TABLE)
├── views/           Definições de views (CREATE OR REPLACE VIEW)
├── procedures/      Stored procedures
└── events/          Eventos agendados do MySQL
```

### Convenção de Nomenclatura

Todos os arquivos seguem o padrão de **prefixo numérico** para garantir a ordem de execução:

| Tipo       | Padrão                         | Exemplo                                          |
|------------|--------------------------------|--------------------------------------------------|
| Tables     | `NN_<nome>_ddl.sql`            | `01_usuario_ddl.sql`                             |
| Views      | `NN_vw_<NomeView>.sql`         | `01_vw_TokensRedefinicaoSenhaValidos.sql`        |
| Procedures | `NN_sp_<NomeProcedure>.sql`    | `01_sp_LimparTokensRedefinicaoSenhaExpirados.sql`|
| Events     | `NN_evt_<NomeEvento>.sql`      | `01_evt_LimparTokensRedefinicaoSenha.sql`        |

A ordem de execução entre pastas é fixa:

```
tables → views → procedures → events
```

Dentro de cada pasta, os arquivos são executados pela ordem numérica do prefixo.

## Pipelines (GitHub Actions)

### Auto Tag (`auto-tag.yml`)

Cria automaticamente tags de versão semântica ao fazer push na `main`.

- **Trigger**: Push na `main` ou manual
- **Input manual**: Tipo de incremento (`patch`, `minor`, `major`)
- **Resultado**: Nova tag `vX.Y.Z` criada e publicada

### Deploy Database (`deploy-database.yml`)

Pipeline de deploy dos artefatos SQL no servidor de produção.

- **Trigger**: Somente manual (`workflow_dispatch`)
- **Input**: Tag de versão (ex: `v1.2.0`)

#### Fluxo de Execução

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  validate   │────▶│  transfer   │────▶│   execute   │
└─────────────┘     └─────────────┘     └─────────────┘
```

**Job 1 — validate**
1. Verifica se a tag informada existe no repositório
2. Localiza a tag anterior (ex: `v1.2.0` → anterior `v1.1.0`)
3. Identifica apenas os arquivos `.sql` alterados entre as duas tags (dentro de `src/`)
4. Se for a primeira tag, inclui todos os arquivos

**Job 2 — transfer**
1. Faz checkout na tag informada
2. Prepara somente os arquivos alterados mantendo a estrutura de pastas
3. Copia via SCP para o servidor em `DEPLOY_PATH/Datatables`
4. Injeta os arquivos dentro do container Docker do MySQL via `docker cp`

**Job 3 — execute**
1. Executa os SQLs via `docker exec mysql mysql ...` na ordem:
   - `tables` → `views` → `procedures` → `events`
2. Dentro de cada pasta, respeita a ordem numérica dos arquivos
3. Captura saída e exit code de cada arquivo individualmente
4. Exibe relatório final com contagem de sucesso/falhas
5. Falha o pipeline se qualquer artefato retornar erro
6. Limpa artefatos do servidor e do container ao final (mesmo em caso de falha)

#### Cenários de Interrupção

| Cenário                          | Comportamento                                    |
|----------------------------------|--------------------------------------------------|
| Tag não existe                   | Pipeline para imediatamente, sem erro             |
| Nenhum `.sql` alterado na tag    | Pipeline para sem executar transfer/execute        |
| Erro em um artefato SQL          | Continua executando os demais, falha no final      |
| Falha na transferência           | Pipeline falha, execute não roda, limpeza acontece |

## Secrets Necessários

Configurar no repositório em **Settings → Secrets and variables → Actions**:

| Secret                   | Descrição                                |
|--------------------------|------------------------------------------|
| `HOST`                   | IP ou hostname do servidor VPS           |
| `USERNAME`               | Usuário SSH do servidor                  |
| `SSH_PRIVATE_KEY`        | Chave privada SSH para autenticação      |
| `DEPLOY_PATH`            | Caminho base de deploy no servidor       |
| `MYSQL_USER`             | Usuário do banco de dados MySQL          |
| `MYSQL_PASSWORD`         | Senha do banco de dados MySQL            |
| `MYSQL_DATABASE`         | Nome do banco de dados                   |

## Como Fazer um Deploy

### 1. Commitar as alterações SQL

```bash
git add src/tables/20_nova_tabela_ddl.sql
git commit -m "feat: adicionar tabela nova_tabela"
git push origin main
```

### 2. Criar a tag (automático ou manual)

A tag é criada automaticamente pelo workflow `auto-tag.yml` ao fazer push na `main`.

Para criar manualmente:
1. Acesse **Actions → Auto Tag → Run workflow**
2. Selecione o tipo de incremento (`patch`, `minor`, `major`)

### 3. Executar o deploy

1. Acesse **Actions → Deploy Database → Run workflow**
2. Informe a tag desejada (ex: `v1.3.0`)
3. Acompanhe os logs de cada job

### Exemplo de saída do deploy

```
══════════════════════════════════════════════════════
  🚀 Deploy Database — v1.3.0
══════════════════════════════════════════════════════

┌──────────────────────────────────────────────────
│ 📁 Executando: tables
└──────────────────────────────────────────────────
  ▶ 19_TokenRedefinicaoSenha.sql ... ✅
  ▶ 20_nova_tabela_ddl.sql ... ✅

┌──────────────────────────────────────────────────
│ 📁 Executando: views
└──────────────────────────────────────────────────
  ▶ 01_vw_TokensRedefinicaoSenhaValidos.sql ... ✅

══════════════════════════════════════════════════════
  📊 Resultado do Deploy
══════════════════════════════════════════════════════
  Total:     3
  Sucesso:   3
  Falhas:    0
══════════════════════════════════════════════════════

✅ Deploy concluído com sucesso!
```
