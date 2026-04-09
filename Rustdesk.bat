@echo off
setlocal
echo ================================
echo Instalando RustDesk
echo ================================

:: CONFIG
set VERSION=1.4.5
set URL=https://github.com/rustdesk/rustdesk/releases/download/1.4.5/rustdesk-1.4.5-x86_64.msi
set SERVER=rustdesk.telecon.cloud
set KEY=IDd2wWqnXdH5mU84odLnNIB6bzFNjYm0ArN3xqjQqOE=

:: TEMP
set TEMP_DIR=%TEMP%\rustdesk_install
mkdir "%TEMP_DIR%" >nul 2>&1
cd /d "%TEMP_DIR%"

echo Baixando...
powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile 'rustdesk.msi'"
if not exist rustdesk.msi (
    echo ERRO no download
    pause
    exit /b
)

echo Instalando silenciosamente...
msiexec /i rustdesk.msi /qn /norestart /l*v "%TEMP_DIR%\install.log"
timeout /t 10 >nul

:: AGUARDAR O SERVIÇO INICIAR
echo Configurando servidor personalizado...
timeout /t 5 >nul

:: CONFIGURAÇÃO PERSISTENTE USANDO --config
:: Formato: host=SERVER,key=KEY
set CONFIG_STRING=host=%SERVER%,key=%KEY%

cd /d "C:\Program Files\RustDesk\"
rustdesk.exe --config "%CONFIG_STRING%"

echo ================================
echo FINALIZADO - RustDesk configurado!
echo ================================
pause