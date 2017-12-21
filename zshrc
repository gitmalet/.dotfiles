# User configuration

export PATH="${HOME}/.bin:${PATH}"

# Vi-Mode
bindkey -v
export KEYTIMEOUT=1

alias vim="nvim"
alias o="xdg-open"
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

# BackwardSeach
bindkey '^R' history-incremental-pattern-search-backward

export TERMINAL="termite"
export TERM="xterm-256color"
export BROWSER="chromium"
export EDITOR="nvim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
export DOWNLOADS="$HOME/Downloads"

# Wayland
export XKB_DEFAULT_LAYOUT=us
export XKB_DEFAULT_VARIANT=euro
export XKB_DEFAULT_MODEL=thinkpad
export XKB_DEFAULT_OPTIONS=caps:escape
export _JAVA_AWT_WM_NONREPARENTING=1

# virtualenvwrapper
export WORKON_HOME="~/.virtualenvs/"
[[ -s /usr/bin/virtualenvwrapper.sh ]] && source /usr/bin/virtualenvwrapper.sh

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-atelier-heath.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Geometry Theme
# GEOMETRY_SYMBOL_PROMPT="❭"				# default prompt symbol
# GEOMETRY_SYMBOL_RPROMPT="❵"				# multiline prompts
# GEOMETRY_SYMBOL_EXIT_VALUE="$?"			# displayed when exit != 0
# GEOMETRY_SYMBOL_ROOT="❫"				# when logged in user is root
# GEOMETRY_COLOR_EXIT_VALUE="red"			# prompt symbol color when exit != 0
# GEOMETRY_COLOR_PROMPT="magenta"			# prompt symbol color
# GEOMETRY_COLOR_ROOT="grey"				# root prompt symbol color
# GEOMETRY_COLOR_DIR="magenta"			# current directory color
# GEOMETRY_PROMPT_PREFIX=""				# prefix prompt with nothing
# GEOMETRY_PROMPT_PLUGINS=(virtualenv exec_time jobs git )
# [ -f ~/.geometry/geometry.zsh ] && source ~/.geometry/geometry.zsh

# fzf Completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh-syntax-highlighting
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
