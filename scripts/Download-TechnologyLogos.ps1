#requires -Version 5.1

<#
.SYNOPSIS
    Télécharge et valide les logos technologiques de Neoxix SOC Academy.

.DESCRIPTION
    - Télécharge les logos SVG en bloc.
    - Classe les fichiers par catégorie.
    - Vérifie que chaque fichier est un véritable SVG.
    - Supprime automatiquement les téléchargements invalides.
    - Affiche un rapport final.
#>

[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

$RepositoryRoot = Split-Path -Parent $PSScriptRoot
$LogoRoot       = Join-Path $RepositoryRoot "docs\assets\logos"

$RequiredDirectories = @(
    (Join-Path $LogoRoot "security"),
    (Join-Path $LogoRoot "network"),
    (Join-Path $LogoRoot "platforms"),
    (Join-Path $LogoRoot "tools")
)

foreach ($Directory in $RequiredDirectories) {
    if (-not (Test-Path -LiteralPath $Directory)) {
        New-Item -ItemType Directory -Path $Directory -Force | Out-Null
    }
}

$Logos = @(
    @{
        Name        = "Wazuh"
        Category    = "security"
        FileName    = "wazuh.svg"
        Url         = "https://raw.githubusercontent.com/wazuh/wazuh-kibana-app/v4.0.4-7.9.3/public/img/icon_blue.svg"
    },
    @{
        Name        = "CrowdStrike"
        Category    = "security"
        FileName    = "crowdstrike.svg"
        Url         = "https://cdn.worldvectorlogo.com/logos/crowdstrike-1.svg"
    },
    @{
        Name        = "Splunk"
        Category    = "security"
        FileName    = "splunk.svg"
        Url         = "https://raw.githubusercontent.com/simple-icons/simple-icons/develop/icons/splunk.svg"
    },
    @{
        Name        = "Wireshark"
        Category    = "network"
        FileName    = "wireshark.svg"
        Url         = "https://raw.githubusercontent.com/simple-icons/simple-icons/develop/icons/wireshark.svg"
    },
    @{
        Name        = "Cisco"
        Category    = "network"
        FileName    = "cisco.svg"
        Url         = "https://raw.githubusercontent.com/simple-icons/simple-icons/develop/icons/cisco.svg"
    },
    @{
        Name        = "Fortinet"
        Category    = "network"
        FileName    = "fortinet.svg"
        Url         = "https://raw.githubusercontent.com/simple-icons/simple-icons/develop/icons/fortinet.svg"
    },
    @{
        Name        = "Linux"
        Category    = "platforms"
        FileName    = "linux.svg"
        Url         = "https://raw.githubusercontent.com/simple-icons/simple-icons/develop/icons/linux.svg"
    },
    @{
        Name        = "Git"
        Category    = "tools"
        FileName    = "git.svg"
        Url         = "https://raw.githubusercontent.com/simple-icons/simple-icons/develop/icons/git.svg"
    },
    @{
        Name        = "GitHub"
        Category    = "tools"
        FileName    = "github.svg"
        Url         = "https://raw.githubusercontent.com/simple-icons/simple-icons/develop/icons/github.svg"
    }
)

$Results = foreach ($Logo in $Logos) {
    $DestinationDirectory = Join-Path $LogoRoot $Logo.Category
    $DestinationPath      = Join-Path $DestinationDirectory $Logo.FileName
    $TemporaryPath        = "$DestinationPath.download"

    Write-Host ""
    Write-Host "Téléchargement : $($Logo.Name)" -ForegroundColor Cyan

    try {
        if (Test-Path -LiteralPath $TemporaryPath) {
            Remove-Item -LiteralPath $TemporaryPath -Force
        }

        & curl.exe `
            --location `
            --fail `
            --silent `
            --show-error `
            --retry 3 `
            --connect-timeout 20 `
            --output $TemporaryPath `
            $Logo.Url

        if ($LASTEXITCODE -ne 0) {
            throw "curl.exe a retourné le code $LASTEXITCODE."
        }

        if (-not (Test-Path -LiteralPath $TemporaryPath)) {
            throw "Le fichier téléchargé est introuvable."
        }

        $FileInfo = Get-Item -LiteralPath $TemporaryPath

        if ($FileInfo.Length -eq 0) {
            throw "Le fichier téléchargé est vide."
        }

        $Content = Get-Content -LiteralPath $TemporaryPath -Raw

        if ($Content -notmatch "<svg(?:\s|>)") {
            throw "Le contenu téléchargé n'est pas un fichier SVG valide."
        }

        Move-Item `
            -LiteralPath $TemporaryPath `
            -Destination $DestinationPath `
            -Force

        Write-Host "Validé : $DestinationPath" -ForegroundColor Green

        [PSCustomObject]@{
            Technology = $Logo.Name
            Category   = $Logo.Category
            Status     = "SUCCESS"
            File       = $DestinationPath
        }
    }
    catch {
        if (Test-Path -LiteralPath $TemporaryPath) {
            Remove-Item -LiteralPath $TemporaryPath -Force
        }

        Write-Warning "$($Logo.Name) : $($_.Exception.Message)"

        [PSCustomObject]@{
            Technology = $Logo.Name
            Category   = $Logo.Category
            Status     = "FAILED"
            File       = $DestinationPath
        }
    }
}

Write-Host ""
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host " Rapport de téléchargement des logos" -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan

$Results | Format-Table -AutoSize

$SuccessfulDownloads = @($Results | Where-Object Status -eq "SUCCESS").Count
$FailedDownloads     = @($Results | Where-Object Status -eq "FAILED").Count

Write-Host "Réussites : $SuccessfulDownloads" -ForegroundColor Green
Write-Host "Échecs    : $FailedDownloads" -ForegroundColor Yellow

if ($FailedDownloads -gt 0) {
    Write-Warning "Certains logos n'ont pas été téléchargés. Consulte le rapport avant tout commit."
    exit 1
}

Write-Host "Tous les logos ont été téléchargés et validés." -ForegroundColor Green
exit 0