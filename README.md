# SystemConfig

Dotfiles etc. for my machine.

IMPORTANT: Ensure the presence of a `.gitignore` in this repo ignoring `.gitconfig.local` (stored in 1Password), which contains the GitHub username, token, etc.

## Setting up a new machine
1. Install essential [Apps](./apps.md) like Dropbox, 1Password, and Sublime Text 2
2. `$ mkdir ~/bin && ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl $_/subl`
3. Install [Homebrew](http://brew.sh)
4. `brew` [essentials](./brew.md)
5. `$ mkdir -p ~/Code/GitHub/raphaelschaad && cd $_`
6. `$ git clone https://github.com/raphaelschaad/SystemConfig.git`
7. Copy file “gitconfig.local” stored in 1Password into locally cloned SystemConfig folder as “.gitconfig.local” (note the dot prefix)
8. `$ ln -s $(pwd)/SystemConfig/{.profile,.gitconfig,.gitignore_global_osx,.gitconfig.local} ~`
9. Download and install latest [Inconsolata font](http://www.levien.com/type/myfonts/inconsolata.html)
10. Import my Terminal.app [Profile](./Novel-Schaad.terminal)
11. Restart Terminal.app

## Link app-specific config files
`$ cd /Code/GitHub/raphaelschaad/SystemConfig/`

### Xcode
[My Font & Color Theme](./Default-Schaad.dvtcolortheme)
`$ mkdir ~/Library/Developer/Xcode/UserData/FontAndColorThemes && ln -s $(pwd)/Default-Schaad.dvtcolortheme $_`

### Processing + Sublime Text 2 + HYPE
`$ ln -s $(pwd)/Default\ \(OSX\).sublime-keymap ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Default\ \(OSX\).sublime-keymap` for [⌘(⇧)R to run Processing from Sublime](./Default (OSX).sublime-keymap)

`$ ln -s $(pwd)/Processing.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Processing.sublime-settings` for [2 spaces instead of tabs for Processing in Sublime](./Processing.sublime-settings)

`$ ln -s $(pwd)/hype_setup.sublime-snippet ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/Processing/Snippets/hype_setup.sublime-snippet` for [Joshua Davis' Sublime HYPE setup snippet](./hype_setup.sublime-snippet)
