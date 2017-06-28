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
`$ cd /Code/GitHub/raphaelschaad/SystemConfig/`

#### Xcode
[My Font & Color Theme](./Default-Schaad.dvtcolortheme)
`$ mkdir ~/Library/Developer/Xcode/UserData/FontAndColorThemes && ln -s $(pwd)/Default-Schaad.dvtcolortheme $_`

#### Processing + Sublime Text 2 + HYPE
Note that this is outdated and [Processing 3 + Sublime Text 3 + HYPE](https://vimeo.com/174246472) as proper processing library is now the way to go.

`$ ln -s $(pwd)/Default\ \(OSX\).sublime-keymap ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Default\ \(OSX\).sublime-keymap` for [⌘(⇧)R to run Processing from Sublime](./Default (OSX).sublime-keymap)

`$ ln -s $(pwd)/Processing.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Processing.sublime-settings` for [2 spaces instead of tabs for Processing in Sublime](./Processing.sublime-settings)

`$ ln -s $(pwd)/hype_setup.sublime-snippet ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/Processing/Snippets/hype_setup.sublime-snippet` for [Joshua Davis' Sublime HYPE setup snippet](./hype_setup.sublime-snippet)

### From `Dropbox/Synced\ App\ Files`
#### macOS Spelling Dictionary
If linking (hard or soft) ~/Library/Spelling/LocalDictionary to Dropbox, the links eventually get overwritten. Instead, manually copy/sync/merge (opendiff) the file periodically.

#### Google Earth Pro
1. File > Open… (CMD+O) > Sync.kmz
2. My Places > right click > Delete Contents
3. Drag folder “Sync” to My Places
4. Temporary Places > right click > Delete Contents

### Chrome Extension Auto Text Expander
Paste contents of `Chrome Extension Auto Text Expander Shortcuts.json` into Options > Import / Export Shortcuts
