#!/usr/bin/env bash
set -euo pipefail

echo "========================================="
echo "Setting Up Virtual Environment for Part 3"
echo "========================================="
echo

# Pick a Python interpreter that actually exists
PY=()
if command -v python3 >/dev/null 2>&1; then
  PY=(python3)
elif command -v python >/dev/null 2>&1; then
  PY=(python)
elif command -v py >/dev/null 2>&1; then
  PY=(py -3)
else
  echo "ERROR: No Python found (python3/python/py)."
  echo "Fix: install Python OR disable Microsoft Store python aliases OR use WSL."
  exit 1
fi

echo "Using interpreter: ${PY[*]}"
"${PY[@]}" --version
echo

# Step 1: Create virtual environment
echo "[Step 1/4] Creating virtual environment..."
"${PY[@]}" -m venv venv_tfx
echo "Virtual environment created: venv_tfx"
echo

# Step 2: Activate virtual environment (Git Bash Windows uses Scripts/activate)
echo "[Step 2/4] Activating virtual environment..."
if [[ -f "venv_tfx/Scripts/activate" ]]; then
  # Git Bash / Windows venv
  # shellcheck disable=SC1091
  source "venv_tfx/Scripts/activate"
elif [[ -f "venv_tfx/bin/activate" ]]; then
  # Linux / WSL venv
  # shellcheck disable=SC1091
  source "venv_tfx/bin/activate"
else
  echo "ERROR: Could not find venv activation script."
  exit 1
fi
echo "Activated: $VIRTUAL_ENV"
echo

# Step 3: Upgrade pip
echo "[Step 3/4] Upgrading pip..."
python -m pip install --upgrade pip
echo

# Step 4: Install required packages
echo "[Step 4/4] Installing required packages..."
echo "This may take several minutes (TensorFlow, PyTorch, etc.)"
echo
python -m pip install tensorflow torch transformers fastapi uvicorn requests numpy
echo

echo "========================================="
echo "Setup Complete!"
echo "========================================="
echo
echo "To use this environment later:"
echo "  Git Bash (Windows): source venv_tfx/Scripts/activate"
echo "  Linux/WSL:          source venv_tfx/bin/activate"
echo "Then run:"
echo "  python create_saved_model.py"
echo

read -r -p "Press Enter to exit..."
