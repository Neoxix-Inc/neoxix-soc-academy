#requires -Version 5.1

<#
.SYNOPSIS
    Valide la structure du dépôt Neoxix SOC Academy.

.DESCRIPTION
    Script en lecture seule (aucune modification). Vérifie :
    - la présence des dossiers obligatoires ;
    - la présence des README obligatoires ;
    - la présence des templates obligatoires ;
    - l'absence de fichiers critiques vides ;
    - la validité des liens Markdown relatifs simples ;
    - l'absence de fichiers temporaires ou sensibles ;
    - l'absence de dépôt Git imbriqué versionnable non exclu par .gitignore.

    Compatible avec Windows PowerShell 5.1 et PowerShell 7+.
    Fonctionne depuis n'importe quel répertoire courant.

.OUTPUTS
    Code de sortie 0 si aucune erreur bloquante, 1 sinon.

.EXAMPLE
    .\Test-NeoxixSocAcademyStructure.ps1
#>

[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

[Console]::InputEncoding   = [System.Text.UTF8Encoding]::new($false)
[Console]::OutputEncoding  = [System.Text.UTF8Encoding]::new($false)
$OutputEncoding            = [System.Text.UTF8Encoding]::new($false)

$RepositoryRoot = Split-Path -Parent $PSScriptRoot

$Errors   = New-Object System.Collections.Generic.List[string]
$Warnings = New-Object System.Collections.Generic.List[string]

function Add-NeoxixError {
    param([string]$Message)
    $Errors.Add($Message) | Out-Null
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

function Add-NeoxixWarning {
    param([string]$Message)
    $Warnings.Add($Message) | Out-Null
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

function Write-NeoxixOk {
    param([string]$Message)
    Write-Host "[OK] $Message" -ForegroundColor Green
}

Write-Host "Neoxix SOC Academy - Validation de structure" -ForegroundColor Cyan
Write-Host "Racine du dépôt : $RepositoryRoot" -ForegroundColor Cyan
Write-Host ""

# ----------------------------------------------------------------------------
# 1. Dossiers obligatoires
# ----------------------------------------------------------------------------

$Domains = @(
    "00-Environment", "01-Wireshark", "02-Wazuh", "03-Splunk", "04-CrowdStrike",
    "05-Incident-Response", "06-Threat-Hunting", "07-Final-Projects", "08-Portfolio",
    "09-CCNA", "10-Fortinet-NSE4"
)

$RequiredDirectories = New-Object System.Collections.Generic.List[string]
foreach ($Domain in $Domains) { $RequiredDirectories.Add($Domain) | Out-Null }
$RequiredDirectories.AddRange([string[]]@("docs", "docs\adr", "templates", "scripts", ".github", ".github\ISSUE_TEMPLATE"))

foreach ($RelativeDirectory in $RequiredDirectories) {
    $FullPath = Join-Path $RepositoryRoot $RelativeDirectory
    if (Test-Path -LiteralPath $FullPath -PathType Container) {
        Write-NeoxixOk "Dossier présent : $RelativeDirectory"
    }
    else {
        Add-NeoxixError "Dossier obligatoire manquant : $RelativeDirectory"
    }
}

# ----------------------------------------------------------------------------
# 2. README obligatoires
# ----------------------------------------------------------------------------

$RequiredReadmes = New-Object System.Collections.Generic.List[string]
foreach ($Domain in $Domains) { $RequiredReadmes.Add((Join-Path $Domain "README.md")) | Out-Null }
$RequiredReadmes.AddRange([string[]]@(
    "README.md", "docs\README.md", "docs\adr\README.md", "templates\README.md"
))

foreach ($RelativeReadme in $RequiredReadmes) {
    $FullPath = Join-Path $RepositoryRoot $RelativeReadme
    if (-not (Test-Path -LiteralPath $FullPath -PathType Leaf)) {
        Add-NeoxixError "README obligatoire manquant : $RelativeReadme"
    }
}

# ----------------------------------------------------------------------------
# 3. Templates obligatoires
# ----------------------------------------------------------------------------

$RequiredTemplates = @(
    "LAB-README-TEMPLATE.md",
    "OBJECTIVES-SKILLS-TEMPLATE.md",
    "TOPOLOGY-INVENTORY-TEMPLATE.md",
    "CONFIGURATION-PROCEDURE-TEMPLATE.md",
    "VALIDATION-PROCEDURE-TEMPLATE.md",
    "TROUBLESHOOTING-TEMPLATE.md",
    "EVIDENCE-TEMPLATE.md",
    "LESSONS-LEARNED-TEMPLATE.md"
)

foreach ($TemplateName in $RequiredTemplates) {
    $FullPath = Join-Path (Join-Path $RepositoryRoot "templates") $TemplateName
    if (-not (Test-Path -LiteralPath $FullPath -PathType Leaf)) {
        Add-NeoxixError "Template obligatoire manquant : templates\$TemplateName"
    }
}

if ($Errors.Count -eq 0) {
    Write-NeoxixOk "Dossiers, README et templates obligatoires : tous présents"
}

# ----------------------------------------------------------------------------
# 4. Fichiers critiques vides
# ----------------------------------------------------------------------------

$CriticalFiles = New-Object System.Collections.Generic.List[string]
$CriticalFiles.AddRange([string[]]@("README.md", "ROADMAP.md", "CHANGELOG.md", "LICENSE", "CLAUDE.md"))
foreach ($RelativeReadme in $RequiredReadmes) { $CriticalFiles.Add($RelativeReadme) | Out-Null }
foreach ($TemplateName in $RequiredTemplates) { $CriticalFiles.Add((Join-Path "templates" $TemplateName)) | Out-Null }

foreach ($RelativeFile in ($CriticalFiles | Select-Object -Unique)) {
    $FullPath = Join-Path $RepositoryRoot $RelativeFile
    if (Test-Path -LiteralPath $FullPath -PathType Leaf) {
        $Item = Get-Item -LiteralPath $FullPath
        if ($Item.Length -eq 0) {
            Add-NeoxixError "Fichier critique vide : $RelativeFile"
        }
    }
}

if (($Errors | Where-Object { $_ -like "Fichier critique vide*" }).Count -eq 0) {
    Write-NeoxixOk "Aucun fichier critique vide détecté"
}

# ----------------------------------------------------------------------------
# 5. Liens Markdown relatifs simples
# ----------------------------------------------------------------------------

$MarkdownFiles = Get-ChildItem -LiteralPath $RepositoryRoot -Recurse -Filter "*.md" -File |
    Where-Object { $_.FullName -notmatch '\\\.git\\' -and $_.FullName -notmatch '\\neoxix-sdk\\' }

$LinkPattern = '\[[^\]]*\]\(([^)]+)\)'
$BrokenLinkCount = 0

foreach ($MarkdownFile in $MarkdownFiles) {
    $Content = Get-Content -LiteralPath $MarkdownFile.FullName -Raw -ErrorAction SilentlyContinue

    if ([string]::IsNullOrEmpty($Content)) {
        continue
    }

    $Matches = [regex]::Matches($Content, $LinkPattern)

    foreach ($Match in $Matches) {
        $Target = $Match.Groups[1].Value.Trim()

        if ($Target -match '^(https?|mailto):' -or $Target -match '^#' -or $Target -eq '') {
            continue
        }

        $TargetWithoutAnchor = ($Target -split '#')[0]

        if ([string]::IsNullOrEmpty($TargetWithoutAnchor)) {
            continue
        }

        $BaseDirectory = Split-Path -Parent $MarkdownFile.FullName
        $ResolvedPath = Join-Path $BaseDirectory $TargetWithoutAnchor

        if (-not (Test-Path -LiteralPath $ResolvedPath)) {
            $RelativeSource = $MarkdownFile.FullName.Substring($RepositoryRoot.Length + 1)
            Add-NeoxixError "Lien Markdown brisé dans ${RelativeSource} : $Target"
            $BrokenLinkCount++
        }
    }
}

if ($BrokenLinkCount -eq 0) {
    Write-NeoxixOk "Aucun lien Markdown relatif brisé détecté ($($MarkdownFiles.Count) fichiers analysés)"
}

# ----------------------------------------------------------------------------
# 6. Fichiers temporaires ou sensibles
# ----------------------------------------------------------------------------

$SensitivePatterns = @(
    "*.tmp", "*.temp", "*.bak", "*.swp", "~$*",
    "*.env", "*.secret", "*.secrets", "*.key", "*.pem", "*.pfx", "*.p12",
    "Thumbs.db", "Desktop.ini"
)

$SensitiveHits = 0

foreach ($Pattern in $SensitivePatterns) {
    $Matches = Get-ChildItem -LiteralPath $RepositoryRoot -Recurse -Filter $Pattern -File -ErrorAction SilentlyContinue |
        Where-Object { $_.FullName -notmatch '\\\.git\\' -and $_.FullName -notmatch '\\neoxix-sdk\\' }

    foreach ($Match in $Matches) {
        $RelativePath = $Match.FullName.Substring($RepositoryRoot.Length + 1)
        Add-NeoxixError "Fichier temporaire ou sensible détecté : $RelativePath"
        $SensitiveHits++
    }
}

if ($SensitiveHits -eq 0) {
    Write-NeoxixOk "Aucun fichier temporaire ou sensible détecté"
}

# ----------------------------------------------------------------------------
# 7. Dépôts Git imbriqués non exclus
# ----------------------------------------------------------------------------

$NestedGitDirectories = Get-ChildItem -LiteralPath $RepositoryRoot -Recurse -Directory -Filter ".git" -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -ne (Join-Path $RepositoryRoot ".git") }

$UnignoredNestedRepos = 0

foreach ($NestedGit in $NestedGitDirectories) {
    $NestedRepoPath = Split-Path -Parent $NestedGit.FullName
    $RelativePath = $NestedRepoPath.Substring($RepositoryRoot.Length + 1)

    $IsIgnored = $false
    if (Get-Command git -ErrorAction SilentlyContinue) {
        git -C $RepositoryRoot check-ignore -q -- "$RelativePath" 2>$null
        $IsIgnored = ($LASTEXITCODE -eq 0)
    }

    if ($IsIgnored) {
        Write-NeoxixOk "Dépôt Git imbriqué détecté mais exclu via .gitignore : $RelativePath"
    }
    else {
        Add-NeoxixError "Dépôt Git imbriqué versionnable (non exclu) : $RelativePath"
        $UnignoredNestedRepos++
    }
}

if ($NestedGitDirectories.Count -eq 0) {
    Write-NeoxixOk "Aucun dépôt Git imbriqué détecté"
}

# ----------------------------------------------------------------------------
# Résumé
# ----------------------------------------------------------------------------

Write-Host ""
Write-Host "----- Résumé -----" -ForegroundColor Cyan
Write-Host "Erreurs   : $($Errors.Count)" -ForegroundColor $(if ($Errors.Count -gt 0) { "Red" } else { "Green" })
Write-Host "Avertissements : $($Warnings.Count)" -ForegroundColor $(if ($Warnings.Count -gt 0) { "Yellow" } else { "Green" })

if ($Errors.Count -gt 0) {
    exit 1
}

exit 0
