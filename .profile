# Shell configuration file order:
# - bash: https://scriptingosx.com/2017/04/about-bash_profile-and-bashrc-on-macos/
# - zsh: https://scriptingosx.com/2019/06/moving-to-zsh-part-2-configuration-files/

#
# Environment Variables
#

HOMEBREW=$(brew --prefix)

# Add paths to the PATH variable
export PATH="~/bin:$PATH" # E.g. op (1Password), subl (Sublime Text).
export PATH="$HOMEBREW/bin:$HOMEBREW/sbin:$PATH" # Prioritize Homebrew's Git etc. over the OS-bundled ones.
export PATH="$HOMEBREW/opt/ruby/bin:$PATH" # Homebrew Ruby gem installed binaries' default path.

# Suppress shell "Warning: Failed to set locale category LC_NUMERIC to en_CH." when macOS' Language & Region settings don't play well with CLI tools.
export LC_ALL=en_US.UTF-8

# Use Visual Studio Code as standard editor
# `--wait` for the files to be closed before returning.
# Setting both standard variables, see: https://unix.stackexchange.com/questions/4859/visual-vs-editor-whats-the-difference
export VISUAL='code --wait'
export EDITOR="$VISUAL"

# Configure Git autocomplete
if [ -n "$ZSH_VERSION" ]; then
  # Zsh ships with a tab-completion library for Git: https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Zsh
  # The shell seems to already autocomplete, though, and running `autoload -Uz compinit && compinit` seems to slow down shell startup.
elif [ -n "$BASH_VERSION" ]; then
  # Use Homebrew's bundled Git bash completions over the OS-bundled ones (no need to `> brew install bash-completion`).
  source $HOMEBREW/etc/bash_completion.d/git-completion.bash
  source $HOMEBREW/etc/bash_completion.d/git-prompt.sh
  source $HOMEBREW/etc/bash_completion.d/hub.bash_completion.sh
fi

# Customize the prompt.
if [ -n "$ZSH_VERSION" ]; then
  export PROMPT='%B%1~%b > '
  # Show current Git branch name in Git repositories on the right side.
  autoload -Uz vcs_info
  precmd_vcs_info() { vcs_info }
  precmd_functions+=( precmd_vcs_info )
  setopt prompt_subst
  export RPROMPT=%B%F{green}\$vcs_info_msg_0_%b%f
  zstyle ':vcs_info:git:*' formats '%b'

  # There doesn't seem to be an easy way to show changes next to the branch w/o messing with git-completion.zsh etc.
elif [ -n "$BASH_VERSION" ]; then
  # Show current Git branch name in Git repositories.
  export PS1='\u@\h:\[\e[;1m\]\w \[\e[32m\]$(__git_ps1 "(%s)")\[\e[0m\]$ '

  # Show changes next to branch.
  export GIT_PS1_SHOWDIRTYSTATE=1 # unstaged (*), staged (+)
  export GIT_PS1_SHOWSTASHSTATE=1 # stashed ($)
  export GIT_PS1_SHOWUNTRACKEDFILES=1 # untracked files (%)
fi

# Customize the color of ls.
export LSCOLORS=Dxfxcxdxbxegedabagacad # Use bold brown (most of the times yellow) for directories and pink for links.
export CLICOLOR=1 # Use ANSI color sequences to distinguish file types.

# Setting GitHub API token for Homebrew to avoid error "GitHub API rate limit exceeded" when `> brew search`ing.
export HOMEBREW_GITHUB_API_TOKEN=$(git config github.token)

# So ffmpeg finds libass' fonts to render subtitles
export FONTCONFIG_FILE=/usr/local/etc/fonts/fonts.conf

# node.js nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# `> twilio` autocomplete setup added via `> twilio autocomplete <bash|zsh>`
if [ -n "$ZSH_VERSION" ]; then
  TWILIO_AC_ZSH_SETUP_PATH=/Users/schaad/.twilio-cli/autocomplete/zsh_setup && test -f $TWILIO_AC_ZSH_SETUP_PATH && source $TWILIO_AC_ZSH_SETUP_PATH;
elif [ -n "$BASH_VERSION" ]; then
  TWILIO_AC_BASH_SETUP_PATH=~/.twilio-cli/autocomplete/bash_setup && test -f $TWILIO_AC_BASH_SETUP_PATH && source $TWILIO_AC_BASH_SETUP_PATH;
fi

#
# Aliases
#

# Xcode
alias xcp="open *.xcodeproj"
alias xcw="open *.xcworkspace"
alias ddd='rm -rf ~/Library/Developer/Xcode/DerivedData/'

# I'm a dummy.
alias brwe=brew

# lsusb
alias lsusb='system_profiler SPUSBDataType'

#
# Functions
#

# Open files with `/Applications`
# Note the importance of the whitespace in the function definition to avoid syntax errors with bash.

# `> writer` for iA Writer.app
writer() {
  open $1 -a /Applications/iA\ Writer.app/
}
