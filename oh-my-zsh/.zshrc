# ============================================================================
#  zsh 入口文件（~/.zshrc -> 本文件）
#  结构：instant prompt → oh-my-zsh → conf.d/*.zsh → 主题
#  配置分模块放在 conf.d/ 下：
#    00-env.zsh      环境变量 / PATH
#    10-options.zsh  历史、补全、按键绑定
#    20-aliases.zsh  别名与函数
#    30-tools.zsh    现代命令行工具（eza/bat/zoxide/fzf）
# ============================================================================

# Powerlevel10k instant prompt：必须放在最前面（任何需要读输入的操作都不能在它上面）
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 本文件真实目录（~/.zshrc 是软链接，这里解析成实际路径）
typeset -g DOTFILES_ZSH=${${(%):-%x}:A:h}

# iTerm2 Shell Integration（标记、目录追踪、it2copy/imgcat 等，未安装则跳过）
[[ -f ~/.iterm2_shell_integration.zsh ]] && source ~/.iterm2_shell_integration.zsh

# ------------------------------ oh-my-zsh ------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting   # 必须放在插件列表最后
  zsh-completions
)

# 自动建议（灰色提示），同时从补全和历史中建议
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

source "$ZSH/oh-my-zsh.sh"

# ------------------------------ 分模块加载 ------------------------------
for _conf in "$DOTFILES_ZSH"/conf.d/*.zsh(N); do
  source "$_conf"
done
unset _conf

# ------------------------------ 主题 ------------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
