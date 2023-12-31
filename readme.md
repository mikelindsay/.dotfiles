# Readme
Configuration
Test

```
$ScriptFromGitHub = Invoke-WebRequest https://raw.githubusercontent.com/mikelindsay/.dotfiles/master/install.ps1
Invoke-Expression $($ScriptFromGitHub.Content)
```