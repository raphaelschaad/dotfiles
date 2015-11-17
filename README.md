# SystemConfig

Dotfiles etc. for my machine.

IMPORTANT: Ensure the presence of a `.gitignore` in this repo ignoring `.gitconfig.local` (stored in 1Password), which contains the GitHub username, token, etc.

## Setting up a new machine
1. Install essential [Apps](./apps.md#essentials) like Dropbox, 1Password, and Sublime Text 2
2. `$ mkdir ~/bin && ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl $_/subl`
3. Install [Homebrew](http://brew.sh)
4. `brew` [essentials](./brew.md)
5. `$ mkdir -p ~/Code/GitHub/raphaelschaad && cd $_`
6. `$ git clone https://github.com/raphaelschaad/SystemConfig.git`
7. Copy file “gitconfig.local” stored in 1Password into locally cloned SystemConfig folder as “.gitconfig.local” (note the dot prefix)
8. `$ ln -s $(pwd)/SystemConfig/{.profile,.gitconfig,.gitignore_global_osx,.gitconfig.local} ~`
9. Install Xcode from App Store and link to my [Font & Color Theme](./Default-Schaad.dvtcolortheme) `$ mkdir ~/Library/Developer/Xcode/UserData/FontAndColorThemes && ln -s $(pwd)/SystemConfig/Default-Schaad.dvtcolortheme $_`
10. Download and install latest [Inconsolata font](http://www.levien.com/type/myfonts/inconsolata.html)
11. Import my Terminal.app [Profile](./Novel-Schaad.terminal)
12. Restart Terminal.app
