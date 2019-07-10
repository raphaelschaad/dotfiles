# SystemConfig

Dotfiles etc. for my machine.

IMPORTANT: Ensure the presence of a `.gitignore` in this repo ignoring `.gitconfig.local` and `.gitcookies` (stored in 1Password), which contain the GitHub username, token, access credentials, etc.

## Setting up a new machine
1. Install essential [Apps](./apps.md) like Dropbox, 1Password, and Sublime Text
2. `$ mkdir ~/bin && ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl $_/subl`
3. Install [Homebrew](http://brew.sh)
4. `brew` [essentials](./brew.md)
5. `$ mkdir -p ~/Code/GitHub/raphaelschaad && cd $_`
6. `$ git clone https://github.com/raphaelschaad/SystemConfig.git`
7. Copy files “gitconfig.local” and “gitcookies” stored in 1Password into locally cloned SystemConfig folder with a dot prefix.
8. `$ ln -s $(pwd)/SystemConfig/{.profile,.gitconfig,.gitignore_global_osx,.gitconfig.local,.gitcookies} ~`
9. Download and install latest [Inconsolata font](http://www.levien.com/type/myfonts/inconsolata.html)
10. Import my Terminal.app [Profile](./Novel-Schaad.terminal)
11. Restart Terminal.app

## Link/Import app-specific config file
### From `SystemConfig`
`$ cd ~/Code/GitHub/raphaelschaad/SystemConfig/`

#### Xcode
[My Font & Color Theme](./Default-Schaad.dvtcolortheme)
`$ mkdir ~/Library/Developer/Xcode/UserData/FontAndColorThemes && ln -s $(pwd)/Default-Schaad.dvtcolortheme $_`

#### Sublime Text
`$ ln -s $(pwd)/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings` for [user preferences](./Preferences.sublime-settings) (easily accessible with ⌘, from within Sublime Text [left view = default preferences; right view = user preferences])

`$ ln -s $(pwd)/Node.sublime-build ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Node.sublime-build` for [Node.js Build System](./Node.sublime-build)

#### Visual Studio Code
`$ ln -s $(pwd)/vscode-settings.json ~/Library/Application\ Support/Code/User/settings.json` for [user preferences](./vscode-settings.json) (easily accessible with ⌘, from within VS Code)

### From `Dropbox/Synced\ App\ Files`
#### macOS Spelling Dictionary
If linking (hard or soft) `~/Library/Spelling/LocalDictionary` to Dropbox, the links eventually get overwritten. Instead, manually copy/sync/merge (opendiff) the file periodically.

#### Google Earth Pro
1. File > Open… (CMD+O) > Sync.kmz
2. My Places > right click > Delete Contents
3. Drag folder “Sync” to My Places
4. Temporary Places > right click > Delete Contents
