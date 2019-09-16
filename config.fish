alias o "rifle"
alias ipy "python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
alias emacs "emacsclient -nc"
alias mutt "neomutt"

set -x TERMINAL "alacritty"
set -x TERM "xterm-256color"
set -x BROWSER "firefox"
set -x EDITOR "nvim"
set -x USE_EDITOR $EDITOR
set -x VISUAL $EDITOR
set -x DOWNLOADS "$HOME/Downloads"
set -x DISPLAY ":0"

set -x PATH "$HOME/.bin:$HOME/.local/bin:$HOME/.cargo/bin/:$HOME/.dotnet/tools:$PATH"

# Java Tiling fix
export _JAVA_AWT_WM_NONREPARENTING=1

# Util options
set -x LESS '--ignore-case --raw-control-chars'
set -x PAGER 'less'

# Colors
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end
