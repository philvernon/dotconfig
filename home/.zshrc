# --------------------------------------------------
# OPTIONS
# --------------------------------------------------

export EDITOR="nvim"
export GOPATH="$HOME/go"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"

export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPTS='--color=bg+:-1'

# --------------------------------------------------
# PATHS
# --------------------------------------------------

typeset -U path PATH

path=(
  "/opt/homebrew/bin"
  "/opt/homebrew/sbin"
  "$ANDROID_HOME/emulator"
  "$ANDROID_HOME/platform-tools"
  "$HOME/.cargo/bin"
  "$HOME/.local/bin"
  "$GOPATH/bin"
  "$HOME/bin"
  "$PNPM_HOME"
  "./node_modules/.bin"
  $path
)
export PATH

# --------------------------------------------------
# Plugins
# --------------------------------------------------

plugins_file="$HOME/.zsh_plugins"

if [[ ! "${plugins_file}.zsh" -nt "${plugins_file}.txt" ]]; then
  (
    source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
    antidote bundle < "${plugins_file}.txt" > "${plugins_file}.zsh"
  )
fi

source "${plugins_file}.zsh"

# --------------------------------------------------
# Completion
# --------------------------------------------------

if [[ -f "$HOME/.zsh/completions/_pnpm" ]]; then
  source "$HOME/.zsh/completions/_pnpm"
fi

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' prefix ''

# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

zstyle ':fzf-tab:*' show-group none
zstyle ':fzf-tab:*' fzf-pad 0
zstyle ':fzf-tab:*' fzf-min-height 0
zstyle ':fzf-tab:*' popup-min-size 0 0
zstyle ':fzf-tab:complete:cd:*' popup-pad 4 4
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# --------------------------------------------------
# Aliases
# --------------------------------------------------

alias c="clear"
alias tree="tree -I node_modules"
alias ev="exit"
alias nrd="npm run dev"
alias pbc="pwd | pbcopy"
alias tmus="tmux"
# FOR NVIM CONFIG REWRITE
alias vimn="NVIM_APPNAME=neovim-rewrite nvim"
alias pe="cd ~/.pi"

# Go to config
alias vc="cd ~/.config"
alias vcn="cd $HOME/.config/nvim"
alias cz="nvim $HOME/.zshrc"

# nvim
alias vim="nvim"
alias v="nvim"
alias vb="nvim '+SessionRestore'"
alias n="nvim"
alias ,="nvim ."

# apps
alias r="ranger"



# --------------------------------------------------
# Custom
# --------------------------------------------------

nf() {
	local search
	search=$(fzf-tmux -p --query="$1" -1)
	if [[ -n "$search" ]]; then
			nvim "$search"
	fi
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# function tmux-sesh() {
# 	sesh connect "$(
#   sesh list --icons | fzf-tmux -p 80%,70% \
#     --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
#     --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
#                 --layout reverse \
#     --bind 'tab:down,btab:up' \
#     --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
#     --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
#     --bind 'ctrl-g:change-prompt(⚙️   )+reload(sesh list -c --icons)' \
#     --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
#     --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
#     --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
#     --preview-window 'right:55%' \
#     --preview 'sesh preview {}'
#         )"
# }

# focus_window() {
#     SPACE_NAME=$(yabai -m query --spaces --space | jq -r ".label")
#     WINDOW_ID=$(yabai -m query --windows --space | jq -r ".[] | select (.app=${SPACE_NAME}).id")
#     yabai -m window --focus "${WINDOW_ID}"
# }

# --------------------------------------------------
# Keybinds
# --------------------------------------------------

bindkey -s "^F" 'nf^M'

# --------------------------------------------------
# Tools
# --------------------------------------------------

eval "$(mise activate zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# pnpm
export PNPM_HOME="/Users/phil/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

# Added by Antigravity IDE
export PATH="/Users/phil/.antigravity-ide/antigravity-ide/bin:$PATH"

# Hermes Agent — ensure ~/.local/bin is on PATH
export PATH="$HOME/.local/bin:$PATH"
