# User configuration

export FPATH="${FPATH}:${HOME}/.zfunctions"
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

# Pure zsh theme
autoload -U promptinit; promptinit
prompt pure

# fzf Completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh-syntax-highlighting
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
