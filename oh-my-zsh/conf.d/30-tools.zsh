# 现代命令行工具（macOS / Ubuntu 通用，未安装的自动跳过）
#   macOS : brew install eza bat zoxide fzf git-delta fd ripgrep
#   Ubuntu: apt install eza bat zoxide fzf git-delta fd-find ripgrep
#           （Debian/Ubuntu 的 bat 叫 batcat，fd 叫 fdfind，这里自动识别）

# ------------------------------ 二进制探测 ------------------------------
# bat / batcat
if (( $+commands[bat] )); then
  typeset -g BAT_BIN=bat
elif (( $+commands[batcat] )); then
  typeset -g BAT_BIN=batcat
fi

# eza / exa（Ubuntu 22.04 只有 exa）
if (( $+commands[eza] )); then
  typeset -g EZA_BIN=eza
elif (( $+commands[exa] )); then
  typeset -g EZA_BIN=exa
fi

# fd / fdfind
if (( $+commands[fd] )); then
  typeset -g FD_BIN=fd
elif (( $+commands[fdfind] )); then
  typeset -g FD_BIN=fdfind
fi

# ------------------------------ eza：替代 ls ------------------------------
if [[ -n $EZA_BIN ]]; then
  alias ls="$EZA_BIN --icons --group-directories-first"
  alias l="$EZA_BIN -l --icons --group-directories-first"
  alias ll="$EZA_BIN -l --icons --group-directories-first --git"
  alias la="$EZA_BIN -la --icons --group-directories-first --git"
  alias lt="$EZA_BIN --tree --level=2 --icons --group-directories-first"
fi

# ------------------------------ bat：替代 cat ------------------------------
if [[ -n $BAT_BIN ]]; then
  alias cat="$BAT_BIN --style=plain --paging=never"
  export BAT_THEME="ansi" # 跟随终端配色
  if (( $+commands[col] )); then
    export MANPAGER="sh -c 'col -bx | $BAT_BIN -l man -p'"
  fi
fi

# ------------------------------ zoxide：更聪明的 cd ------------------------------
# 访问过的目录会被记录，`cd 关键字` 直接跳转；原 cd 行为保留
(( $+commands[zoxide] )) && eval "$(zoxide init zsh --cmd cd)"

# ------------------------------ fzf：模糊查找 ------------------------------
if (( $+commands[fzf] )); then
  # 默认数据源优先用 fd，没有则退回 find
  if [[ -n $FD_BIN ]]; then
    export FZF_DEFAULT_COMMAND="$FD_BIN --type f --hidden --follow --exclude .git"
    export FZF_ALT_C_COMMAND="$FD_BIN --type d --hidden --follow --exclude .git"
  else
    export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/.git/*"'
    export FZF_ALT_C_COMMAND='find . -type d -not -path "*/.git/*"'
  fi
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border rounded --info=inline'
  [[ -n $BAT_BIN ]] && export FZF_CTRL_T_OPTS="--preview \"$BAT_BIN --style=numbers --color=always --line-range :120 {}\""

  # fzf >= 0.48 自带 zsh 集成；老版本（如 Ubuntu 22.04 的 0.38）用发行版脚本
  if fzf --zsh >/dev/null 2>&1; then
    source <(fzf --zsh)
  else
    for _f in \
      /usr/share/doc/fzf/examples/key-bindings.zsh \
      /usr/share/zsh/vendor-completions/fzf-zsh-completion.zsh; do
      [[ -f $_f ]] && source "$_f"
    done
    [[ -d /usr/share/zsh/vendor-completions ]] && fpath+=(/usr/share/zsh/vendor-completions)
    unset _f
  fi
fi
