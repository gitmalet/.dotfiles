# User configuration

export FPATH="${FPATH}:${HOME}/.zfunctions"
export PATH="${HOME}/.local/bin:${HOME}/.cargo/bin/:${HOME}/.node_modules/bin/:${PATH}"

# Vi-Mode
bindkey -v
export KEYTIMEOUT=1

alias o="rifle"
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
alias emacs="emacsclient -nc"
alias mutt="neomutt"

# BackwardSeach
bindkey '^R' history-incremental-pattern-search-backward

export TERMINAL="alacritty"
export TERM="xterm-256color"
export BROWSER="firefox"
export EDITOR="nvim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
export DOWNLOADS="$HOME/Downloads"

# FStar ecosystem
export FSTAR_HOME=/opt/fstar
export KREMLIN_HOME=/usr/lib/kremlin

# Wayland
export _JAVA_AWT_WM_NONREPARENTING=1

# git-secret
export SECRETS_EXTENSION=.gpg

# Util options
export LESS="--ignore-case --raw-control-chars"
export PAGER="less"

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# fzf Completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
