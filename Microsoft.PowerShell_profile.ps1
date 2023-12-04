#alias
Set-Alias vimconf openNvimConfig
Set-Alias neovide C:\tools\neovide\neovide.exe
Set-Alias cc clear
Set-Alias gitb getCurrentGitBranch

#importing modules
Import-Module posh-git
# Set-PoshPrompt -Theme star
Set-PoshPrompt -Theme  atomic

Import-Module PSReadLine
Import-Module PSFzf

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
# Set-PSReadLineOption -PredictionSource 'HistoryAndPlugin' -PredictionViewStyle 'ListView'
Set-PSReadLineKeyHandler -Key 'Ctrl+r' -ScriptBlock { Invoke-FzfTabCompletion }
Set-PSReadLineKeyHandler Tab MenuComplete

Set-PSFzfOption -PSReadlineChordReverseHistory 'Ctrl+h'

$env:FZF_DEFAULT_OPTS='--layout=reverse --border'

# For zoxide 
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})

function getCurrentGitBranch {
    git rev-parse --abbrev-ref HEAD
}

function openNvimConfig {
	Set-Location C:\Users\asus\AppData\Local\nvim\
	nvim init.lua
}

