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

# Xorg
# set -x DISPLAY ":0"
# set -x XAUTHORITY "$HOME/.Xauthority"

set -x PATH "$HOME/.bin:$HOME/.local/bin:$HOME/.cargo/bin/:$HOME/.dotnet/tools:$HOME/.node_modules/bin:$PATH"

# Java Tiling fix
set -x _JAVA_AWT_WM_NONREPARENTING 1

# NPM
set -x npm_config_prefix ~/.node_modules

# Util options
set -x LESS '--ignore-case --raw-control-chars'
set -x PAGER 'less'

# Colors
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

# opam configuration
source /home/malet/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
