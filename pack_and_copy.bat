@echo off
setlocal

REM Packs SpaceWizards.SharpFont and copies the package into Everdeep's local package folder.
REM Usage:
REM   pack_and_copy.bat [Configuration] [OutputDirectory]
REM Bump <Version> in Source\SharpFont\SharpFont.csproj first, and the version in EverdeepEngine.csproj after.

set "CONFIG=%~1"
if "%CONFIG%"=="" set "CONFIG=Release"

set "OUTPUT_DIR=%~2"
if "%OUTPUT_DIR%"=="" set "OUTPUT_DIR=artifacts\nuget"

for %%I in ("%~dp0..") do set "PARENT_DIR=%%~fI"
set "EVERDEEP_PACKAGES_DIR=%PARENT_DIR%\Everdeep\Packages"
set "EVERDEEP_DEV_PACKAGES_DIR=%PARENT_DIR%\Everdeep-Development\Packages"

cd /d "%~dp0" || exit /b 1

if exist "%OUTPUT_DIR%" rd /s /q "%OUTPUT_DIR%"
mkdir "%OUTPUT_DIR%"

dotnet pack Source\SharpFont\SharpFont.csproj -c %CONFIG% -o "%OUTPUT_DIR%"
if errorlevel 1 (
  echo Packing SharpFont failed.
  exit /b 1
)

set "COPY_DEST="
if exist "%EVERDEEP_PACKAGES_DIR%" (
  set "COPY_DEST=%EVERDEEP_PACKAGES_DIR%"
) else if exist "%EVERDEEP_DEV_PACKAGES_DIR%" (
  set "COPY_DEST=%EVERDEEP_DEV_PACKAGES_DIR%"
) else (
  echo Neither destination folder exists:
  echo   %EVERDEEP_PACKAGES_DIR%
  echo   %EVERDEEP_DEV_PACKAGES_DIR%
  exit /b 1
)

copy /Y "%OUTPUT_DIR%\*.nupkg" "%COPY_DEST%\" >nul
if errorlevel 1 (
  echo Copy failed.
  exit /b 1
)

echo Copied packages to: %COPY_DEST%
exit /b 0
