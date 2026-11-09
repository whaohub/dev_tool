# 历史 / 补全 / 按键（macOS / Ubuntu 通用）
# 注：compinit 由 oh-my-zsh 负责执行，这里不再重复调用（重复会拖慢启动）

# ------------------------------ 历史记录 ------------------------------
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt extended_history      # 记录命令时间戳与耗时
setopt inc_append_history    # 命令立即写入历史文件
setopt share_history         # 多个终端共享历史
setopt hist_ignore_all_dups  # 同一个命令只保留一条
setopt hist_ignore_space     # 以空格开头的命令不记录（放敏感命令）
setopt hist_reduce_blanks    # 压掉多余空格
setopt hist_verify           # 调用历史命令前先确认

# ------------------------------ 目录跳转 ------------------------------
setopt auto_cd               # 直接输入目录名即可进入
setopt auto_pushd            # cd 时自动记录目录栈
setopt pushd_ignore_dups
setopt pushd_minus           # `cd -2` 可用
DIRSTACKSIZE=20

# 让 Ctrl-W 按路径分段删除（默认会连 `/` 一起删）
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# ------------------------------ 补全样式 ------------------------------
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 补全缓存（加快大项目下的补全，两个平台都适用）
_zcompcache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"
[[ -d ${_zcompcache:h} ]] || mkdir -p "${_zcompcache:h}" 2>/dev/null
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$_zcompcache"
unset _zcompcache

# ------------------------------ 按键绑定 ------------------------------
bindkey -e                                   # emacs 模式

# Ctrl+←/→ 按单词移动（macOS iTerm2 / Linux 终端通用序列）
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
# Alt/Option+←/→ 的两种常见序列
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word
# 方向键按字符移动（^[OD/^[OC 是普通 ←/→ 的 SS3 应用光标序列，不是 Alt+←/→）
bindkey '^[OD' backward-char
bindkey '^[OC' forward-char

# Home / End / Delete（xterm 与 linux consolevariant 都覆盖）
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[3;5~' kill-word        # Ctrl+Delete

# Ctrl+Backspace 删除前一个单词
bindkey '^H' backward-kill-word

# 上下键按前缀搜索历史（先输入前缀，再按 ↑ 只翻同前缀的命令）
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history
