export EDITOR=nvim
export VISUAL=nvim

export XDG_CONFIG_HOME="$HOME/.config"

# Helper to source the first file that exists (cross-platform plugin loader)
source_first() {
  for file in "$@"; do
    if [[ -f "$file" ]]; then
      source "$file"
      return 0
    fi
  done
  return 1
}

# PATH (typeset -U dedupes, so nested tmux shells don't keep re-prepending)
typeset -U path
export PATH="$HOME/.local/bin:$PATH"
source_first \
  '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' \
  '/usr/share/google-cloud-sdk/path.zsh.inc' \
  '/opt/google-cloud-sdk/path.zsh.inc'

# Debian / Raspberry Pi OS compatibility (bat -> batcat, fd -> fdfind)
if ! command -v bat &>/dev/null && command -v batcat &>/dev/null; then
  alias bat='batcat'
fi
if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
  alias fd='fdfind'
fi

# Shell options
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS INTERACTIVE_COMMENTS NO_BEEP EXTENDED_GLOB

alias give='z ~/development/giveinteractive/'
alias grant='z ~/development/grant-programs/'

alias nconf='z ~/.config/nvim/ && nvim'
alias aconf='z ~/.config/aerospace && nvim ~/.config/aerospace/aerospace.toml'
alias zconf='nvim ~/dotfiles/zsh/.zshrc'
alias sconf='z ~/.config/sketchybar/ && nvim'
alias tconf='z ~/.config/tmux/ && nvim'
alias gconf='z ~/.config/ghostty/ && nvim config'
alias cyarn='clear && yarn'

alias ll='eza -l --git --icons'
alias lg='lazygit'

alias start-backend='give && z backend && yarn run server:watch-debug'
alias migrations-backend='give && z backend && rm -r ./dist && yarn run build && yarn run migration:run'
alias start-react='give && z react-client && yarn run server:start'
alias start-cron='give && z backend && yarn run cron:watch-debug'
alias start-api='give && z backend && yarn run rest-watch-debug'
alias start-api-watch='give && z backend && yarn run rest-build:watch'
alias start-gp-backend='grant && z backend && yarn run server:watch-debug'
alias start-gp-react='grant && z react-client && yarn run server:start'

alias db='nvim +DBUI'

alias tm='~/.config/tmux/utils/give-tmux-session.sh'

# Jump helpers: fzf to nvim
v() {
  local fd_cmd="fd"
  command -v fd &>/dev/null || fd_cmd="fdfind"
  local file
  file=$($fd_cmd --type f --hidden --exclude .git | fzf --query="${*:-}" --preview 'bat --color=always --line-range :200 {}')
  [[ -n "$file" ]] && ${EDITOR:-nvim} "$file"
}

vg() {
  local res
  res=$(rg --line-number --no-heading --color=always --smart-case "${*:-}" |
    fzf --ansi \
        --delimiter : \
        --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
        --preview-window '+{2}-/2')
  if [[ -n "$res" ]]; then
    local file line
    file=$(echo "$res" | cut -d: -f1)
    line=$(echo "$res" | cut -d: -f2)
    ${EDITOR:-nvim} "$file" "+$line"
  fi
}

mkd() {
  mkdir -p -- "$1" && z -P -- "$1"
}

filesize() {
  du -sh * | sort -h
}

paths() {
  echo $PATH | tr ':' '\n'
}

gmr() {
  local target=$1
  local title=$2
  local reviewer=$3

  glab mr create \
    --target-branch "$target" \
    --title "$title" \
    --description "-" \
    --assignee "maconsuckow" \
    --reviewer "$reviewer"
}

# History (SHARE_HISTORY implies INC_APPEND_HISTORY)
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY HIST_REDUCE_BLANKS HIST_VERIFY EXTENDED_HISTORY

# Completion (must run before zoxide/fzf so their completions register)
# Full rebuild at most once a day; touch so the dump's mtime resets even if unchanged
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then compinit && touch ~/.zcompdump; else compinit -C; fi
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/zcompcache"

# gcloud shell completion
source_first \
  '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' \
  '/usr/share/google-cloud-sdk/completion.zsh.inc' \
  '/opt/google-cloud-sdk/completion.zsh.inc'

# Vi mode: instant Esc, plus a few emacs keys in insert mode
bindkey -v
KEYTIMEOUT=1
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^?' backward-delete-char   # Backspace past where insert mode began
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^W' backward-kill-word

# Cursor shape: block in normal mode, beam in insert mode
# (defined before starship so its keymap-select hook wraps this one)
zle-keymap-select() {
  if [[ $KEYMAP == vicmd ]]; then printf '\e[2 q'; else printf '\e[6 q'; fi
}
zle -N zle-keymap-select
zle-line-init() { printf '\e[6 q' }
zle -N zle-line-init
preexec() { printf '\e[6 q' }   # reset before running commands

command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
command -v starship &>/dev/null && eval "$(starship init zsh)"

# Transient prompt: collapse the submitted prompt to a bare arrow
transient-prompt-accept-line() {
  local PROMPT=$'%B%F{#a9b665}➜  %f%b' RPROMPT=''
  zle .reset-prompt
  zle .accept-line
}
zle -N accept-line transient-prompt-accept-line

# Up/Down: search history for commands starting with what's typed
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Ctrl-X Ctrl-E: edit the current command in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

export COLORTERM=truecolor
# Force shell and all compliant CLIs to use color by default
export CLICOLOR=1
export GO_FORCE_COLOR=1

# fzf: Ctrl-R history, Ctrl-T files, Alt-C dirs, ** completion
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
command -v fd &>/dev/null || export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
command -v fd &>/dev/null || export FZF_ALT_C_COMMAND='fdfind --type d --hidden --exclude .git'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :200 {}'"

# fzf shell bindings (handle modern fzf --zsh as well as older distro packages)
if fzf --zsh &>/dev/null; then
  source <(fzf --zsh)
elif [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
elif [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# fzf-tab (replaces standard completion selection menu with fzf)
source_first \
  "/opt/homebrew/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh" \
  "/usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh" \
  "/usr/share/fzf-tab/fzf-tab.zsh" \
  "$HOME/.local/share/fzf-tab/fzf-tab.plugin.zsh" \
  "$HOME/.local/share/fzf-tab/fzf-tab.zsh"

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath 2>/dev/null || ls -1 --color=always $realpath'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -1 --color=always $realpath 2>/dev/null || ls -1 --color=always $realpath'
zstyle ':fzf-tab:complete:(\\|*/|)kill:*:*' fzf-preview '[[ $group == "[process ID]" ]] && ps -p $word -o comm,pid,user,pcpu,pmem -w'
zstyle ':fzf-tab:*' switch-group '<' '>'

# Autosuggestions: dim gray; Ctrl-Right accepts one word
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6c6c6c"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
source_first \
  "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "$HOME/.local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

bindkey '^[[1;5C' forward-word

# Machine-local overrides and secrets (not in dotfiles)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Must be sourced last
source_first \
  "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  "$HOME/.local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
