@echo off
REM Setup script for Part 3: TFX Deployment
REM This creates a virtual environment and installs required packages

echo =========================================
echo Setting Up Virtual Environment for Part 3
echo =========================================
echo.

REM Step 1: Create virtual environment
echo [Step 1/4] Creating virtual environment...
python -m venv venv_tfx
echo Virtual environment created: venv_tfx
echo.

REM Step 2: Activate virtual environment
echo [Step 2/4] Activating virtual environment...
call venv_tfx\Scripts\activate.bat
echo.

REM Step 3: Upgrade pip
echo [Step 3/4] Upgrading pip...
python -m pip install --upgrade pip
echo.

REM Step 4: Install required packages
echo [Step 4/4] Installing required packages...
echo This will take several minutes (downloading TensorFlow, PyTorch, etc.)
echo.
pip install tensorflow
pip install torch
pip install transformers
pip install fastapi
pip install uvicorn
pip install requests
pip install numpy
echo.

echo =========================================
echo Setup Complete!
echo =========================================
echo.
echo To use this environment:
echo 1. Run: venv_tfx\Scripts\activate.bat
echo 2. Then run: python create_saved_model.py
echo.
echo =========================================
pause
