@setlocal enableextensions
@cd /d "%~dp0"

powershell.exe -executionpolicy unrestricted -command .\windowsupdate.ps1
pause