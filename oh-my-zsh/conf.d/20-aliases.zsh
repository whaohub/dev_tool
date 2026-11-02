# 别名（交互式 shell 使用，macOS / Ubuntu 通用）

# ------------------------------ 编辑器 ------------------------------
alias vi="nvim"
alias vim="nvim"
alias zshconfig="$EDITOR ~/.zshrc"
alias reload="exec zsh"

# ------------------------------ 目录 ------------------------------
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# ------------------------------ 常用 ------------------------------
alias c="clear"
alias h="history"
alias grep="grep --color=auto"
alias ports="lsof -nP -iTCP -sTCP:LISTEN"
alias path="print -l \$path"

# ------------------------------ git ------------------------------
alias gs="git status -sb"
alias ga="git add"
alias gaa="git add -A"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log --oneline --graph --decorate -20"
alias gp="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gcm="git commit -m"
alias gca="git commit --amend"

# ------------------------------ 函数 ------------------------------
# mkdir + cd
mkcd() {
  [[ -n "$1" ]] || { echo "usage: mkcd <dir>" >&2; return 1 }
  mkdir -p "$1" && cd "$1"
}
