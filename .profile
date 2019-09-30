# Bash Startup Files
# When a "login shell" starts up, it reads the file "/etc/profile" and then "~/.bash_profile" or "~/.bash_login" or "~/.profile" (whichever one exists but only one of these, checking for them in the listed order).

# Add paths to the PATH variable
export PATH="~/bin:$PATH" # E.g. subl
export PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH" # Prioritize Homebrew's Git over Xcode4's Git, Homebrew's PHP over OS X's PHP etc..
export PATH="$(brew --prefix)/opt/ruby/bin:$PATH" # Homebrew Ruby gem installed binaries' default path.

# Suppress shell "Warning: Failed to set locale category LC_NUMERIC to en_CH." when macOS' Language & Region settings don't play well with CLI tools.
export LC_ALL=en_US.UTF-8

# Use Sublime Text as standard editor
# Setting both standard variables, see: https://unix.stackexchange.com/questions/4859/visual-vs-editor-whats-the-difference
export VISUAL='subl -w'
export EDITOR="$VISUAL"

# Homebrew's own Git, bash, and hub completion
# Not to be confused with the system bundled one /Applications/Xcode.app/Contents/Developer/usr/share/git-core/
# Also no need to `$ brew install bash-completion`
. $(brew --prefix)/etc/bash_completion.d/git-completion.bash
. $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
. $(brew --prefix)/etc/bash_completion.d/hub.bash_completion.sh

# Customize the prompt via PS1 variable

# Default
#PS1='\h:\W \u\$ '
#PS1='\[\e[31m\]\u\[\e[32m\]@\[\e[34m\]\H\[\e[32m\]:\[\e[33m\]\w\[\e[32m\]$\[\e[0m\] '
#PS1='\u@\h:\[\e[;1m\]\w\[\e[0m\] $ '

# Show current git branch name in git repositories (avoid the legacy Ruby way)
PS1='\u@\h:\[\e[;1m\]\w \[\e[32m\]$(__git_ps1 "(%s)")\[\e[0m\]$ '

# Show changes next to branch
export GIT_PS1_SHOWDIRTYSTATE=1 # unstaged (*), staged (+)
export GIT_PS1_SHOWSTASHSTATE=1 # stashed ($)
export GIT_PS1_SHOWUNTRACKEDFILES=1 # untracked files (%)

export PS1

# Customize the color of ls
#LSCOLORS=exfxcxdxbxegedabagacad # default from ls man page
#LSCOLORS=dxfxcxdxbxegedabagacad # yellow for directories
LSCOLORS=Dxfxcxdxbxegedabagacad # bold brown (most of the times yellow) for directories
CLICOLOR=1 # Use ANSI color sequences to distinguish file types.

export LSCOLORS
export CLICOLOR

# So ffmpeg finds libass' fonts to render subtitles
export FONTCONFIG_FILE=/usr/local/etc/fonts/fonts.conf

# Setting GitHub API token for Homebrew to avoid error "GitHub API rate limit exceeded" when `$ brew search`ing
export HOMEBREW_GITHUB_API_TOKEN=$(git config github.token)

# node.js nvm
export NVM_DIR=~/.nvm
. $(brew --prefix nvm)/nvm.sh

# Aliases
## Xcode
alias xcp="open *.xcodeproj"
alias xcw="open *.xcworkspace"
alias ddd='rm -rf ~/Library/Developer/Xcode/DerivedData/'

## http://hub.github.com
alias git=hub

## I'm a dummy
alias brwe=brew

## lsusb
alias lsusb='system_profiler SPUSBDataType'

## VLC
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

# Open files with /Applications
# Note the importance of the whitespace in the function definition to avoid syntax errors with bash.

## `writer` for iA Writer
writer() {
	open $1 -a /Applications/iA\ Writer.app/
}

# `twilio` autocomplete setup
TWILIO_AC_BASH_SETUP_PATH=~/.twilio-cli/autocomplete/bash_setup && test -f $TWILIO_AC_BASH_SETUP_PATH && source $TWILIO_AC_BASH_SETUP_PATH;
