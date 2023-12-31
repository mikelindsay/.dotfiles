winget install -e --id Git.Git
git clone https://github.com/mikelindsay/.dotfiles.git $env:userprofile\.dotfiles

pushd .
cd $env:userprofile\.dotfiles
git pull
popd

$linkExists = Test-Path $env:userprofile\.glaze-wm
If (-not $linkExists) {
	New-Item -ItemType SymbolicLink -Target $env:userprofile\.dotfiles\.glaze-wm -Path $env:userprofile\.glaze-wm
}
winget install GlazeWM