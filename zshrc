# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:${HOME}/.bin:${HOME}/.multirust/toolchains/nightly/cargo/bin"

alias vim="nvim"
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
# Vi-Mode
bindkey -v
export KEYTIMEOUT=1

# BackwardSeach
bindkey '^R' history-incremental-pattern-search-backward

#export TERMINAL="termite"
export TERM="xterm-256color"
export BROWSER="chromium"
export EDITOR="nvim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
# Should be wayland keyboard settings
export XKB_DEFAULT_LAYOUT=us
export XKB_DEFAULT_VARIANT=euro
export XKB_DEFAULT_MODEL=thinkpad
export XKB_DEFAULT_OPTIONS=caps:escape

# virtualenvwrapper
export WORKON_HOME="~/.virtualenvs/"
source /usr/bin/virtualenvwrapper.sh

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-atelier-cave.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Geometry Theme
[ -f ~/.geometry/geometry.zsh ] && source ~/.geometry/geometry.zsh

# fzf Completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh-syntax-highlighting
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
