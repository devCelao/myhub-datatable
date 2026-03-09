# MyHub — Datatable

Artefatos SQL do banco de dados (tables, views, procedures, events).

## Estrutura

```
src/
├── tables/
├── views/
├── procedures/
└── events/
```

## Deploy Local

Requisitos: Docker e Docker Compose.

```bash
# 1. Configurar variáveis de ambiente
cp .env.example .env

# 2. Subir o MySQL
docker compose up -d

# 3. Aplicar os artefatos alterados na branch atual
docker compose -f docker-compose.deploy.yml up --build
```

O deploy detecta automaticamente quais `.sql` foram alterados em relação à branch `main` e os executa na ordem: **tables → views → procedures → events**.

Para usar outra branch base, defina `BASE_BRANCH` no `.env`.
