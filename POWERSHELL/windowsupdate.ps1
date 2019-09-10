clear
# Comprobamos si somos administradores
if ([bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match"S-1-5-32-544")) {
Write-Host "Eres administrador. Podemos proseguir."

    if (-not (Get-PackageProvider -ListAvailable -Name NuGet)) {
        Write-Host "Instalando módulo NuGet"
        # Instalando el módulo NuGet
        Install-PackageProvider NuGet -Force
    }
    else {
        Write-Host "NuGet ya estaba instalado. Seguimos."
    }
    # Comprobamos si NO está instalado el módulo PowershellGet
    if ( -not (Get-Module -ListAvailable -Name PowerShellGet)){
        Write-Host "Instalando módulo PowershellGet"
        # Instalando o actualizando el módulo PowershellGet
        Install-Module -Name PowershellGet -Force
    }
    else{
        Write-Host "PowershellGet ya estaba instalado. Seguimos."
    }
    # Comprobamos si NO está instalado el módulo PSWindowsUpdate
    if ( -not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
        Write-Host "Instalando módulo de actualizaciones - PSWindowsUpdate"
        # Instalando el módulo PSWindowsUpdate
        Install-Module -Name PSWindowsUpdate -Force
        Write-Host "Importando módulo de actualizaciones - PSWindowsUpdate"
        # Importando el módulo PSWindowsUpdate
        Import-Module PSWindowsUpdate
    } 
    else {
    Write-Host "PSWindowsUpdate ya estaba instalado. Seguimos."
    }
    #Recuperamos la lista de actualizaciones disponibles
    Get-WindowsUpdate
    #Instalamos las actualizaciones pendientes
    Install-WindowsUpdate –AcceptAll –AutoReboot
}
else {
    Write-Host "No eres administrador. Por favor ejecuta el script con permisos de administrador"
}