param(
    [string]$DestinationName = "msdm",
    [string]$SiteTitle = "MSDM",
    [string]$SiteDescription = "The MSDM website",
    [string]$SiteUrl = "https://cerencodes.github.io/msdm/",
    [switch]$Force
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$destinationRoot = Split-Path -Parent $repoRoot
$destinationPath = Join-Path $destinationRoot $DestinationName

if ((Test-Path -LiteralPath $destinationPath) -and -not $Force) {
    throw "Destination already exists: $destinationPath`nRe-run with -Force after removing it or choose another -DestinationName."
}

if (Test-Path -LiteralPath $destinationPath) {
    Remove-Item -LiteralPath $destinationPath -Recurse -Force
}

$excludeNames = @(
    ".git",
    ".quarto",
    ".Rproj.user",
    "_site",
    "_freeze"
)

New-Item -ItemType Directory -Path $destinationPath | Out-Null

Get-ChildItem -LiteralPath $repoRoot -Force | Where-Object {
    $excludeNames -notcontains $_.Name
} | ForEach-Object {
    Copy-Item -LiteralPath $_.FullName -Destination $destinationPath -Recurse -Force
}

$quartoPath = Join-Path $destinationPath "_quarto.yml"
if (-not (Test-Path -LiteralPath $quartoPath)) {
    throw "Expected file not found: $quartoPath"
}

$quartoContent = Get-Content -LiteralPath $quartoPath -Raw
$quartoContent = [regex]::Replace(
    $quartoContent,
    '(?m)^  title: ".*"$',
    ('  title: "{0}"' -f $SiteTitle)
)
$quartoContent = [regex]::Replace(
    $quartoContent,
    '(?m)^  description: ".*"$',
    ('  description: "{0}"' -f $SiteDescription)
)
$quartoContent = [regex]::Replace(
    $quartoContent,
    '(?m)^  site-url: .*$',
    ('  site-url: {0}' -f $SiteUrl)
)

Set-Content -LiteralPath $quartoPath -Value $quartoContent -Encoding UTF8

Write-Host "Created duplicate site at: $destinationPath"
Write-Host "Updated _quarto.yml for: $SiteUrl"
Write-Host "Next: create the GitHub repo '$DestinationName', replace posts, and publish with GitHub Pages."
