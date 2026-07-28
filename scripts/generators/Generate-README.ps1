#requires -Version 5.1

<#
.SYNOPSIS
    Génère un README.md à partir du Neoxix Design System.

.DESCRIPTION
    Ce script utilise :
    - branding.json
    - tokens.json
    - README-TEMPLATE.md
    - les composants Markdown réutilisables

    Le générateur est développé progressivement.
#>

[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

[Console]::InputEncoding   = [System.Text.UTF8Encoding]::new($false)
[Console]::OutputEncoding  = [System.Text.UTF8Encoding]::new($false)
$OutputEncoding            = [System.Text.UTF8Encoding]::new($false)

$RepositoryRoot = Split-Path -Parent (
    Split-Path -Parent $PSScriptRoot
)

$BrandingRoot = Join-Path $RepositoryRoot "docs\assets\branding"

$BrandingFile = Join-Path $BrandingRoot "branding.json"
$TokensFile   = Join-Path $BrandingRoot "tokens.json"
$TemplateFile = Join-Path $BrandingRoot "README-TEMPLATE.md"
$HeroFile     = Join-Path $BrandingRoot "components\hero.md"

Write-Host "Neoxix README Generator" -ForegroundColor Cyan
Write-Host "Repository root : $RepositoryRoot"
Write-Host "Branding root   : $BrandingRoot"

# Vérification des fichiers requis
$RequiredFiles = @(
    $BrandingFile,
    $TokensFile,
    $TemplateFile,
    $HeroFile
)

foreach ($File in $RequiredFiles) {
    if (-not (Test-Path -LiteralPath $File -PathType Leaf)) {
        throw "Fichier requis introuvable : $File"
    }

    Write-Host "OK : $File" -ForegroundColor Green
}

# Chargement et validation de branding.json
try {
    $Branding = Get-Content -LiteralPath $BrandingFile -Raw -Encoding UTF8 |
        ConvertFrom-Json
}
catch {
    throw "Impossible de charger branding.json : $($_.Exception.Message)"
}

if ([string]::IsNullOrWhiteSpace($Branding.organization.name)) {
    throw "La propriété organization.name est absente de branding.json."
}

if ([string]::IsNullOrWhiteSpace($Branding.repository.name)) {
    throw "La propriété repository.name est absente de branding.json."
}

if ([string]::IsNullOrWhiteSpace($Branding.organization.tagline.fr)) {
    throw "La propriété organization.tagline.fr est absente de branding.json."
}

Write-Host "Organisation : $($Branding.organization.name)" -ForegroundColor Cyan
Write-Host "Projet       : $($Branding.repository.name)" -ForegroundColor Cyan

# Chargement et validation de tokens.json
try {
    $Tokens = Get-Content -LiteralPath $TokensFile -Raw -Encoding UTF8 |
        ConvertFrom-Json
}
catch {
    throw "Impossible de charger tokens.json : $($_.Exception.Message)"
}

if ([string]::IsNullOrWhiteSpace($Tokens.color.primary)) {
    throw "La propriété color.primary est absente de tokens.json."
}

if ([string]::IsNullOrWhiteSpace($Tokens.color.secondary)) {
    throw "La propriété color.secondary est absente de tokens.json."
}

if ([string]::IsNullOrWhiteSpace($Tokens.color.success)) {
    throw "La propriété color.success est absente de tokens.json."
}

if ([string]::IsNullOrWhiteSpace($Tokens.color.warning)) {
    throw "La propriété color.warning est absente de tokens.json."
}

Write-Host "Couleur primaire   : $($Tokens.color.primary)" -ForegroundColor Cyan
Write-Host "Couleur secondaire : $($Tokens.color.secondary)" -ForegroundColor Cyan

# Chargement des modèles Markdown
$TemplateContent = Get-Content `
    -LiteralPath $TemplateFile `
    -Raw `
    -Encoding UTF8

$HeroContent = Get-Content `
    -LiteralPath $HeroFile `
    -Raw `
    -Encoding UTF8

if ([string]::IsNullOrWhiteSpace($TemplateContent)) {
    throw "README-TEMPLATE.md est vide."
}

if ([string]::IsNullOrWhiteSpace($HeroContent)) {
    throw "components\hero.md est vide."
}

Write-Host "Template README chargé : $($TemplateContent.Length) caractères" -ForegroundColor Green
Write-Host "Composant Hero chargé  : $($HeroContent.Length) caractères" -ForegroundColor Green

# Préparation des données du Hero
$ProjectName    = [string]$Branding.repository.name
$ProjectTagline = [string]$Branding.organization.tagline.fr

$PrimaryColor = ([string]$Tokens.color.primary).TrimStart("#")
$SuccessColor = ([string]$Tokens.color.success).TrimStart("#")
$WarningColor = ([string]$Tokens.color.warning).TrimStart("#")

$EncodedProjectName = [uri]::EscapeDataString($ProjectName)

$Banner = @"
<img src="./docs/assets/branding/banner.svg" alt="$EncodedProjectName banner" width="100%">
"@

$Badges = @"
![Status](https://img.shields.io/badge/Status-In%20Development-$WarningColor) ![License](https://img.shields.io/badge/License-MIT-$SuccessColor) ![Documentation](https://img.shields.io/badge/Documentation-FR%20%7C%20EN-$PrimaryColor)
"@

$QuickLinks = @"
[Documentation](./docs) · [Roadmap](./ROADMAP.md) · [Changelog](./CHANGELOG.md) · [Labs](./01-Wireshark/01-Labs)
"@

# Remplacement littéral des variables
$GeneratedHero = $HeroContent

$GeneratedHero = $GeneratedHero.Replace(
    "{{PROJECT_NAME}}",
    $ProjectName
)

$GeneratedHero = $GeneratedHero.Replace(
    "{{PROJECT_TAGLINE}}",
    $ProjectTagline
)

$GeneratedHero = $GeneratedHero.Replace(
    "{{BANNER}}",
    $Banner.Trim()
)

$GeneratedHero = $GeneratedHero.Replace(
    "{{BADGES}}",
    $Badges.Trim()
)

$GeneratedHero = $GeneratedHero.Replace(
    "{{QUICK_LINKS}}",
    $QuickLinks.Trim()
)

Write-Host "Composant Hero généré : $($GeneratedHero.Length) caractères" -ForegroundColor Green

# Validation avant affichage
$RemainingPlaceholders = [regex]::Matches(
    $GeneratedHero,
    "\{\{[A-Z0-9_]+\}\}"
)

if ($RemainingPlaceholders.Count -gt 0) {
    $PlaceholderNames = $RemainingPlaceholders.Value |
        Sort-Object -Unique

    throw "Variables non remplacées dans le Hero : $($PlaceholderNames -join ', ')"
}

Write-Host "Validation Hero : aucune variable non remplacée." -ForegroundColor Green

# Aperçu
Write-Host ""
Write-Host "----- Aperçu du Hero généré -----" -ForegroundColor Cyan
Write-Host $GeneratedHero
Write-Host "----- Fin de l'aperçu -----" -ForegroundColor Cyan