# Login shell 环境（macOS / Ubuntu 通用，iTerm2、VS Code 终端、SSH 登录都会加载）
# 只放"所有 shell 都需要"的变量；交互式设置放在 ~/.zshrc 的 conf.d 里

# ------------------------------ Homebrew ------------------------------
if [[ -x /opt/homebrew/bin/brew ]]; then
  # macOS（Apple Silicon）
  export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
  export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
  export HOMEBREW_PIP_INDEX_URL="https://mirrors.aliyun.com/pypi/simple"
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  # macOS（Intel）
  export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
  export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
  eval "$(/usr/local/bin/brew shellenv)"
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  # Linux（Linuxbrew，可选）
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ------------------------------ 其它工具 ------------------------------
# OrbStack / Docker（未安装时静默跳过）
[[ -f "$HOME/.orbstack/shell/init.zsh" ]] && source "$HOME/.orbstack/shell/init.zsh"
