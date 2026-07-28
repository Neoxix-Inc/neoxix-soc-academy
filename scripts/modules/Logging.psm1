#requires -Version 5.1

<#
.SYNOPSIS
    Module de journalisation du Neoxix SDK.

.DESCRIPTION
    Fournit des fonctions standardisées pour écrire des messages
    dans la console et dans un fichier de journal.

    Compatible avec Windows PowerShell 5.1 et PowerShell 7+.
#>

Set-StrictMode -Version Latest

$script:NeoxixLogFile = $null
$script:NeoxixDebugEnabled = $false

function Start-NeoxixLog {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Path,

        [Parameter()]
        [switch]$EnableDebug
    )

    if ([string]::IsNullOrWhiteSpace($Path)) {
        $RepositoryRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
        $LogDirectory = Join-Path $RepositoryRoot "logs"

        if (-not (Test-Path -LiteralPath $LogDirectory)) {
            New-Item -ItemType Directory -Path $LogDirectory -Force | Out-Null
        }

        $Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
        $Path = Join-Path $LogDirectory "neoxix-$Timestamp.log"
    }

    $ParentDirectory = Split-Path -Parent $Path

    if (-not [string]::IsNullOrWhiteSpace($ParentDirectory)) {
        if (-not (Test-Path -LiteralPath $ParentDirectory)) {
            New-Item -ItemType Directory -Path $ParentDirectory -Force | Out-Null
        }
    }

    $script:NeoxixLogFile = $Path
    $script:NeoxixDebugEnabled = $EnableDebug.IsPresent

    "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] [INFO] Neoxix log started." |
        Set-Content -LiteralPath $script:NeoxixLogFile -Encoding UTF8

    return $script:NeoxixLogFile
}

function Stop-NeoxixLog {
    [CmdletBinding()]
    param()

    if ($script:NeoxixLogFile) {
        "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] [INFO] Neoxix log stopped." |
            Add-Content -LiteralPath $script:NeoxixLogFile -Encoding UTF8
    }

    $script:NeoxixLogFile = $null
    $script:NeoxixDebugEnabled = $false
}

function Write-NeoxixLogEntry {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet("INFO", "SUCCESS", "WARNING", "ERROR", "DEBUG")]
        [string]$Level,

        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$Message,

        [Parameter()]
        [ConsoleColor]$Color = [ConsoleColor]::Gray
    )

    if ($Level -eq "DEBUG" -and -not $script:NeoxixDebugEnabled) {
        return
    }

    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $FormattedMessage = "[$Timestamp] [$Level] $Message"

    Write-Host $FormattedMessage -ForegroundColor $Color

    if ($script:NeoxixLogFile) {
        $FormattedMessage |
            Add-Content -LiteralPath $script:NeoxixLogFile -Encoding UTF8
    }
}

function Write-NeoxixInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$Message
    )

    Write-NeoxixLogEntry `
        -Level "INFO" `
        -Message $Message `
        -Color Cyan
}

function Write-NeoxixSuccess {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$Message
    )

    Write-NeoxixLogEntry `
        -Level "SUCCESS" `
        -Message $Message `
        -Color Green
}

function Write-NeoxixWarning {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$Message
    )

    Write-NeoxixLogEntry `
        -Level "WARNING" `
        -Message $Message `
        -Color Yellow
}

function Write-NeoxixError {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$Message
    )

    Write-NeoxixLogEntry `
        -Level "ERROR" `
        -Message $Message `
        -Color Red
}

function Write-NeoxixDebug {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$Message
    )

    Write-NeoxixLogEntry `
        -Level "DEBUG" `
        -Message $Message `
        -Color DarkGray
}

function Get-NeoxixLogFile {
    [CmdletBinding()]
    param()

    return $script:NeoxixLogFile
}

Export-ModuleMember -Function @(
    "Start-NeoxixLog",
    "Stop-NeoxixLog",
    "Write-NeoxixInfo",
    "Write-NeoxixSuccess",
    "Write-NeoxixWarning",
    "Write-NeoxixError",
    "Write-NeoxixDebug",
    "Get-NeoxixLogFile"
)