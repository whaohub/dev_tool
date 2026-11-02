# 环境变量（macOS / Ubuntu 通用）

# 默认编辑器（没有 nvim 时回退到 vim）
if (( $+commands[nvim] )); then
  export EDITOR="nvim"
elif (( $+commands[vim] )); then
  export EDITOR="vim"
fi
export VISUAL="$EDITOR"

# 个人可执行文件目录（追加到 PATH 末尾，不覆盖系统命令）
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$PATH:$HOME/.local/bin" ;;
esac

# 私有变量（API key 等）。此文件不入库，权限 600，模板见 secrets.example.zsh
[[ -f "$HOME/.config/zsh/secrets.zsh" ]] && source "$HOME/.config/zsh/secrets.zsh"
