dotfiles

IMPORTANT: Ensure the presence of a `.gitignore` in this repo ignoring `.gitconfig.local` and `.gitcookies` (stored in 1Password), which contain the GitHub username, token, access credentials, etc.

# Setting up a new machine
1. Install essential Apps like Xcode, Homebrew, and visual-studio-code (see Notes.app → Software).
2. `> mkdir -p ~/Code/GitHub/raphaelschaad && cd $_`
3. `> git clone https://github.com/raphaelschaad/SystemConfig.git`
4. Copy files `gitconfig.local` and `gitcookies` stored in 1Password into locally cloned `SystemConfig/` folder each with a dot prefix.
5. `> ln -s $(pwd)/SystemConfig/{.profile,.gitconfig,.gitignore_global_macos,.gitconfig.local,.gitcookies} ~`
6. If using zsh, `> ln -s ~/.profile ~/.zshrc`.
7. Restart Terminal.app.

# Linking/Importing app-specific config file
## From `SystemConfig`
`> cd ~/Code/GitHub/raphaelschaad/SystemConfig/`

### Visual Studio Code
`> ln -s $(pwd)/vscode-settings.json ~/Library/Application\ Support/Code/User/settings.json` for [User Preferences](./vscode-settings.json) (easily accessible with `⌘,` from within VS Code)

`> ln -s $(pwd)/vscode-keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json` for [User Keyboard Shortcuts](./vscode-keybindings.json) (easily accessible with `[⌘K ⌘S]` from within VS Code)

## From `<CLOUD>/Synced\ App\ Files`
### macOS Spelling Dictionary
When linking (hard or soft) `~/Library/Spelling/LocalDictionary` to cloud folder, the links eventually get overwritten. Instead, manually copy/sync/merge (`> opendiff file1 file2`) the file periodically.

### Google Earth Pro
1. File > Open… (`⌘O`) > Sync.kmz
2. My Places > right click > Delete Contents
3. Drag folder “Sync” to My Places
4. Temporary Places > right click > Delete Contents
