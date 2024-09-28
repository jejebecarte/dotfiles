oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/amro.omp.json" | Invoke-Expression

$Modules = (
    "PSReadLine",
    "Terminal-Icons"
)
$Modules | ForEach-Object {
    if (Get-Module -ListAvailable -Name $_) {
        Import-Module $_
    }
}