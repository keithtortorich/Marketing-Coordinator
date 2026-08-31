#!/bin/bash
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR"

# Backend: Python deps
python3 -m venv backend/venv
source backend/venv/bin/activate
pip install -q --upgrade pip
pip install -q -r backend/requirements.txt
deactivate

echo 'export PATH="$CLAUDE_PROJECT_DIR/backend/venv/bin:$PATH"' >> "$CLAUDE_ENV_FILE"

# Frontend: Node deps
cd frontend
npm install
cd ..
