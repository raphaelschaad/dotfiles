# Bash Startup Files
# When a "login shell" starts up, it reads the file "/etc/profile" and then "~/.bash_profile" or "~/.bash_login" or "~/.profile" (whichever one exists - it only reads one of these, checking for them in the order mentioned).

# adding paths to the PATH variable
export PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH" # Prioritize Homebrew's Git over Xcode4's Git, Homebrew's PHP over OS X's PHP etc..
export PATH="$(brew --prefix)/opt/ruby/bin:$PATH" # Homebrew Ruby gem installed binaries' default path.
export PATH="$PATH:/opt/local/bin:/opt/local/sbin" # MacPorts
export PATH="$PATH:~/Development/android-sdk-macosx/platform-tools:~/Development/android-sdk-macosx/tools" # Android development
export PATH="$PATH:~/Code/GitHub/arcanist/bin" # 'arc' (Arcanist; Phabricator CLI)

# Arcanist Bash Tab Completion
source ~/Code/GitHub/other/arcanist/resources/shell/bash-completion

# Homebrew Git Completion, Prompt, etc. (also see /Applications/Xcode.app/Contents/Developer/usr/share/git-core/)
source `brew --prefix`/etc/bash_completion

# customize the prompt via PS1 variable

# default
#PS1='\h:\W \u\$ '
#PS1='\[\e[31m\]\u\[\e[32m\]@\[\e[34m\]\H\[\e[32m\]:\[\e[33m\]\w\[\e[32m\]$\[\e[0m\] '
#PS1='\u@\h:\[\e[;1m\]\w\[\e[0m\] $ '

# Show current git branch name in git repositories
PS1='\u@\h:\[\e[;1m\]\w \[\e[32m\]$(__git_ps1 "(%s)")\[\e[0m\]$ '
# The legacy Ruby way
#PS1="\u@\h:\[\e[;1m\]\w \[\e[32m\]\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`\[\e[0m\]$ "
#PS1="\u@\h:\[\e[;1m\]\w \[\e[32m\]\`ruby -e \"print (%x{git branch 2> /dev/null}.split(/\r?\n/).grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`\[\e[0m\]$ " # Split on \r\n or just \n to avoid error with Ruby > 2.0.0.

# Show changes next to branch
export GIT_PS1_SHOWDIRTYSTATE=1 # unstaged (*), staged (+)
export GIT_PS1_SHOWSTASHSTATE=1 # stashed ($)
export GIT_PS1_SHOWUNTRACKEDFILES=1 # untracked files (%)

export PS1

# Point uncrustify to default config used, when none specified with -c
export UNCRUSTIFY_CONFIG='/usr/local/share/uncrustify/defaults.cfg'

# Use TextMate as standard editor
export EDITOR='mate -w'

# customize the color of ls
#LSCOLORS=exfxcxdxbxegedabagacad # default from ls man page
#LSCOLORS=dxfxcxdxbxegedabagacad # yellow for directories
LSCOLORS=Dxfxcxdxbxegedabagacad # bold brown (most of the times yellow) for directories
CLICOLOR=1 # Use ANSI color sequences to distinguish file types.

export LSCOLORS
export CLICOLOR

# aliases
## Xcode
alias xcp="open *.xcodeproj"
alias xcw="open *.xcworkspace"
alias ddd='rm -rf ~/Library/Developer/Xcode/DerivedData/'

## http://hub.github.com
alias git=hub

# open files with /Applications
# Note the importance of the whitespace in the function definition to avoid syntax errors with bash.
## fw (Fireworks)
fw() {
	open $1 -a /Applications/Adobe\ Fireworks\ CS5/Adobe\ Fireworks\ CS5.app/
}

## writer (iA Writer)
writer() {
	open $1 -a /Applications/iA\ Writer.app/
}

# I'm a dummy
alias brwe=brew
