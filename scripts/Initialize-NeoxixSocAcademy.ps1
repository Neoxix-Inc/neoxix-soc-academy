#requires -Version 5.1

<#
.SYNOPSIS
    Vérifie et initialise la structure standard du dépôt Neoxix SOC Academy.

.DESCRIPTION
    Ce script est idempotent : il vérifie l'existence des dossiers et fichiers
    de la structure standard (domaines pédagogiques, docs, templates, .github)
    et ne crée que ce qui manque. Il ne supprime jamais rien et n'écrase un
    fichier existant que si -Force est explicitement fourni.

    Compatible avec Windows PowerShell 5.1 et PowerShell 7+.
    Fonctionne depuis n'importe quel répertoire courant : la racine du dépôt
    est résolue à partir de l'emplacement du script lui-même.

.PARAMETER Force
    Autorise l'écrasement du contenu des fichiers déjà existants qui seraient
    normalement créés par ce script. Sans ce paramètre, un fichier existant
    n'est jamais modifié.

.EXAMPLE
    .\Initialize-NeoxixSocAcademy.ps1 -WhatIf
    Affiche ce qui serait créé sans rien modifier.

.EXAMPLE
    .\Initialize-NeoxixSocAcademy.ps1
    Crée les dossiers et fichiers manquants de la structure standard.
#>

[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
param(
    [Parameter()]
    [switch]$Force
)

$ErrorActionPreference = "Stop"

[Console]::InputEncoding   = [System.Text.UTF8Encoding]::new($false)
[Console]::OutputEncoding  = [System.Text.UTF8Encoding]::new($false)
$OutputEncoding            = [System.Text.UTF8Encoding]::new($false)

$RepositoryRoot = Split-Path -Parent $PSScriptRoot

$LoggingModule = Join-Path $PSScriptRoot "modules\Logging.psm1"

if (Test-Path -LiteralPath $LoggingModule -PathType Leaf) {
    Import-Module $LoggingModule -Force
    Start-NeoxixLog | Out-Null
}
else {
    function Write-NeoxixInfo    { param([string]$Message) Write-Host "[INFO] $Message" -ForegroundColor Cyan }
    function Write-NeoxixSuccess { param([string]$Message) Write-Host "[SUCCESS] $Message" -ForegroundColor Green }
    function Write-NeoxixWarning { param([string]$Message) Write-Host "[WARNING] $Message" -ForegroundColor Yellow }
}

Write-NeoxixInfo "Racine du dépôt : $RepositoryRoot"

# ----------------------------------------------------------------------------
# Structure standard
# ----------------------------------------------------------------------------

$Domains = @(
    "00-Environment",
    "01-Wireshark",
    "02-Wazuh",
    "03-Splunk",
    "04-CrowdStrike",
    "05-Incident-Response",
    "06-Threat-Hunting",
    "07-Final-Projects",
    "08-Portfolio",
    "09-CCNA",
    "10-Fortinet-NSE4"
)

$RequiredDirectories = New-Object System.Collections.Generic.List[string]

foreach ($Domain in $Domains) {
    $RequiredDirectories.Add($Domain) | Out-Null
    $RequiredDirectories.Add((Join-Path $Domain "01-Labs")) | Out-Null
}

$WiresharkSubfolders = @(
    "02-PCAP-Files",
    "03-Evidence",
    "04-Reports",
    "05-Diagrams",
    "06-Scripts",
    "07-Resources"
)

foreach ($Subfolder in $WiresharkSubfolders) {
    $RequiredDirectories.Add((Join-Path "01-Wireshark" $Subfolder)) | Out-Null
}

$RequiredDirectories.AddRange([string[]]@(
    "docs",
    "docs\adr",
    "docs\assets",
    "templates",
    "diagrams",
    "scripts",
    "scripts\generators",
    "scripts\modules",
    ".github",
    ".github\ISSUE_TEMPLATE"
))

# Fichiers requis : chemin relatif -> contenu placeholder minimal si absent.
# Ce script ne réécrit jamais un fichier déjà rempli sans -Force.
$RequiredFiles = [ordered]@{}

foreach ($Domain in $Domains) {
    $ReadmePath = Join-Path $Domain "README.md"
    $RequiredFiles[$ReadmePath] = "# $Domain`n`nTODO -- Decrire l'objectif de ce domaine.`n"
}

$RequiredFiles["docs\README.md"]                 = "# Documentation`n`nTODO -- Index de documentation.`n"
$RequiredFiles["docs\adr\README.md"]              = "# Architecture Decision Records`n`nTODO -- Registre des decisions d'architecture.`n"
$RequiredFiles["docs\LAB-INDEX.md"]               = "# Index des laboratoires`n`nTODO -- Index centralise des laboratoires.`n"
$RequiredFiles["docs\CONTRIBUTION-WORKFLOW.md"]   = "# Workflow de contribution`n`nTODO -- Decrire le workflow.`n"
$RequiredFiles["templates\README.md"]             = "# Templates`n`nTODO -- Index des templates.`n"

# ----------------------------------------------------------------------------
# Création des dossiers manquants
# ----------------------------------------------------------------------------

$CreatedDirectories = 0
$SkippedDirectories = 0

foreach ($RelativeDirectory in $RequiredDirectories) {
    $FullPath = Join-Path $RepositoryRoot $RelativeDirectory

    if (Test-Path -LiteralPath $FullPath -PathType Container) {
        $SkippedDirectories++
        continue
    }

    if ($PSCmdlet.ShouldProcess($FullPath, "Créer le dossier")) {
        New-Item -ItemType Directory -Path $FullPath -Force | Out-Null
        Write-NeoxixSuccess "Dossier créé : $RelativeDirectory"
        $CreatedDirectories++
    }
}

# ----------------------------------------------------------------------------
# Création des fichiers manquants
# ----------------------------------------------------------------------------

$CreatedFiles = 0
$SkippedFiles = 0
$OverwrittenFiles = 0

foreach ($RelativeFile in $RequiredFiles.Keys) {
    $FullPath = Join-Path $RepositoryRoot $RelativeFile
    $Content = $RequiredFiles[$RelativeFile]
    $Exists = Test-Path -LiteralPath $FullPath -PathType Leaf

    if ($Exists -and -not $Force) {
        $SkippedFiles++
        continue
    }

    if ($Exists -and $Force) {
        if ($PSCmdlet.ShouldProcess($FullPath, "Écraser le contenu existant (-Force)")) {
            Set-Content -LiteralPath $FullPath -Value $Content -Encoding UTF8 -NoNewline
            Write-NeoxixWarning "Fichier écrasé (-Force) : $RelativeFile"
            $OverwrittenFiles++
        }
        continue
    }

    if ($PSCmdlet.ShouldProcess($FullPath, "Créer le fichier")) {
        $ParentDirectory = Split-Path -Parent $FullPath

        if (-not (Test-Path -LiteralPath $ParentDirectory)) {
            New-Item -ItemType Directory -Path $ParentDirectory -Force | Out-Null
        }

        Set-Content -LiteralPath $FullPath -Value $Content -Encoding UTF8 -NoNewline
        Write-NeoxixSuccess "Fichier créé : $RelativeFile"
        $CreatedFiles++
    }
}

# ----------------------------------------------------------------------------
# Résumé
# ----------------------------------------------------------------------------

Write-NeoxixInfo ""
Write-NeoxixInfo "----- Résumé -----"
Write-NeoxixInfo "Dossiers créés   : $CreatedDirectories"
Write-NeoxixInfo "Dossiers déjà OK : $SkippedDirectories"
Write-NeoxixInfo "Fichiers créés   : $CreatedFiles"
Write-NeoxixInfo "Fichiers déjà OK : $SkippedFiles"

if ($OverwrittenFiles -gt 0) {
    Write-NeoxixWarning "Fichiers écrasés (-Force) : $OverwrittenFiles"
}

if (Get-Command Stop-NeoxixLog -ErrorAction SilentlyContinue) {
    Stop-NeoxixLog
}
