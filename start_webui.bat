@echo off
echo ========================================
echo   MoneyPrinterTurbo WebUI ????
echo ========================================
echo.

REM ?? Python ??
python --version >nul 2>&1
if errorlevel 1 (
    echo ??: ??? Python????? Python 3.10+
    pause
    exit /b 1
)

REM ????
echo ??????...
pip install -r requirements.txt

REM ?? Streamlit WebUI
echo.
echo ???? WebUI...
echo ????: http://localhost:8501
echo.
streamlit run webui/Main.py --server.port 8501 --server.address 0.0.0.0

pause
