# User configuration

export FPATH="${FPATH}:${HOME}/.zfunctions"
export PATH="${HOME}/.bin:${HOME}/.local/bin:${PATH}"

# Vi-Mode
bindkey -v
export KEYTIMEOUT=1

alias vim="nvim"
alias o="rifle"
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
alias emacs="emacsclient -nc"
alias mutt="neomutt"

# BackwardSeach
bindkey '^R' history-incremental-pattern-search-backward

export TERMINAL="termite"
export TERM="xterm-256color"
export BROWSER="chromium"
export EDITOR="nvim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
export DOWNLOADS="$HOME/Downloads"

# FStar ecosystem
export FSTAR_HOME=/opt/fstar
export KREMLIN_HOME=/usr/lib/kremlin

# Wayland
export XKB_DEFAULT_LAYOUT=us
export XKB_DEFAULT_VARIANT=euro
export XKB_DEFAULT_MODEL=thinkpad
export XKB_DEFAULT_OPTIONS=caps:escape
export _JAVA_AWT_WM_NONREPARENTING=1

# git-secret
export SECRETS_EXTENSION=.gpg

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
# Pure zsh theme
autoload -U promptinit; promptinit
prompt lean

# fzf Completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh-syntax-highlighting
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
