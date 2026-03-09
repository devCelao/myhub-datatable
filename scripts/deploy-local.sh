#!/usr/bin/env bash
set -euo pipefail

EXECUTION_ORDER="tables views procedures events"

DB_HOST="${DB_HOST:-mysql}"
DB_PORT="${DB_PORT:-3306}"
DB_USER="${DB_USER:?Variável DB_USER não definida}"
DB_PASSWORD="${DB_PASSWORD:?Variável DB_PASSWORD não definida}"
DB_NAME="${DB_NAME:?Variável DB_NAME não definida}"
BASE_BRANCH="${BASE_BRANCH:-main}"

git config --global --add safe.directory /workspace

CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "detached")

CHANGED=$(git diff --name-only --diff-filter=ACMRT "$BASE_BRANCH" -- src/ | grep '\.sql$' || true)

if [ -z "$CHANGED" ]; then
  echo ""
  echo "  Nenhum arquivo .sql alterado em relação à branch '$BASE_BRANCH'."
  echo ""
  exit 0
fi

TOTAL=0
SUCCESS=0
FAILED=0
ERRORS=""

echo ""
echo "══════════════════════════════════════════════════════"
echo "  Deploy Local — Branch: $CURRENT_BRANCH"
echo "  Base: $BASE_BRANCH"
echo "══════════════════════════════════════════════════════"

for FOLDER in $EXECUTION_ORDER; do
  FOLDER_FILES=$(echo "$CHANGED" | grep "^src/$FOLDER/" | sort || true)

  if [ -z "$FOLDER_FILES" ]; then
    continue
  fi

  echo ""
  echo "┌──────────────────────────────────────────────────"
  echo "│ Executando: $FOLDER"
  echo "└──────────────────────────────────────────────────"

  while IFS= read -r FILE; do
    [ -z "$FILE" ] && continue

    FILENAME=$(basename "$FILE")
    TOTAL=$((TOTAL + 1))

    if [ ! -f "/workspace/$FILE" ]; then
      echo "  ▶ $FILENAME ... SKIP (removido na branch)"
      continue
    fi

    echo -n "  ▶ $FILENAME ... "

    OUTPUT=$(mysql \
      --host="$DB_HOST" \
      --port="$DB_PORT" \
      --user="$DB_USER" \
      --password="$DB_PASSWORD" \
      --database="$DB_NAME" \
      --default-character-set=utf8mb4 \
      --batch \
      < "/workspace/$FILE" 2>&1) && STATUS=$? || STATUS=$?

    if [ $STATUS -eq 0 ]; then
      echo "OK"
      SUCCESS=$((SUCCESS + 1))
    else
      echo "ERRO (exit: $STATUS)"
      echo "    $OUTPUT"
      FAILED=$((FAILED + 1))
      ERRORS="${ERRORS}\n  ✗ ${FOLDER}/${FILENAME}: ${OUTPUT}"
    fi
  done <<< "$FOLDER_FILES"
done

echo ""
echo "══════════════════════════════════════════════════════"
echo "  Resultado"
echo "══════════════════════════════════════════════════════"
echo "  Total:     $TOTAL"
echo "  Sucesso:   $SUCCESS"
echo "  Falhas:    $FAILED"
echo "══════════════════════════════════════════════════════"

if [ $FAILED -gt 0 ]; then
  echo ""
  echo "  Erros encontrados:"
  echo -e "$ERRORS"
  echo ""
  exit 1
fi

echo ""
echo "  Deploy local concluído com sucesso!"
echo ""
