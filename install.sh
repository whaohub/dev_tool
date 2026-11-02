#!/usr/bin/env bash
# =============================================================================
#  dev_tool 一键安装脚本（macOS / Ubuntu / Debian）
#
#  用法:
#    ./install.sh                 # 安装依赖 + 建立软链接
#    ./install.sh --dry-run       # 只显示会做什么，不做修改
#    ./install.sh --skip-packages # 不动系统包，只建立软链接
#    ./install.sh --help
#
#  幂等：重复执行安全；被替换的旧文件会备份为 <文件>.bak.<时间戳>
# =============================================================================
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d%H%M%S)"
DRY_RUN=0
SKIP_PACKAGES=0

# ------------------------------ 输出 ------------------------------
info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
ok()   { printf '\033[1;32m  ✓\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m  !\033[0m %s\n' "$*"; }
die()  { printf '\033[1;31mERROR:\033[0m %s\n' "$*" >&2; exit 1; }

run() {
  if [ "$DRY_RUN" -eq 1 ]; then
    printf '\033[1;90m  [dry-run] %s\033[0m\n' "$*"
  else
    eval "$@"
  fi
}

usage() {
  sed -n '2,14p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
  exit 0
}

# ------------------------------ 参数 ------------------------------
for arg in "$@"; do
  case "$arg" in
    --dry-run)       DRY_RUN=1 ;;
    --skip-packages) SKIP_PACKAGES=1 ;;
    -h|--help)       usage ;;
    *) die "未知参数: $arg（用 --help 查看用法）" ;;
  esac
done

# ------------------------------ 基本检测 ------------------------------
OS="$(uname -s)"
case "$OS" in
  Darwin) PLATFORM=macos ;;
  Linux)  PLATFORM=linux ;;
  *)      die "不支持的系统: $OS（仅支持 macOS / Linux）" ;;
esac

info "仓库目录: $REPO_DIR"
info "平台: $PLATFORM$([ "$DRY_RUN" -eq 1 ] && echo "（dry-run 模式）")"

# ------------------------------ 依赖安装 ------------------------------
install_macos_packages() {
  # 系统自带的 zsh / git 足够用，不通过 brew 覆盖
  for cmd in zsh git; do
    command -v "$cmd" >/dev/null 2>&1 || warn "未找到 $cmd（macOS 通常自带，请检查 Xcode CLT）"
  done

  if ! command -v brew >/dev/null 2>&1; then
    warn "未找到 Homebrew，跳过依赖安装"
    warn "手动安装: https://brew.sh 然后重新运行本脚本"
    return
  fi

  local pkgs="fzf bat zoxide git-delta fd ripgrep tmux eza"
  local installed missing p
  installed="$(brew list --formula 2>/dev/null)"
  for p in $pkgs; do
    printf '%s\n' "$installed" | grep -qx "$p" || missing="$missing $p"
  done
  if [ -z "$missing" ]; then
    ok "Homebrew 依赖已齐全"
    return
  fi
  info "安装:$missing"
  run "brew install $missing"
}

install_linux_packages() {
  local sudo_cmd=""
  [ "$(id -u)" -ne 0 ] && sudo_cmd="sudo"

  if command -v apt-get >/dev/null 2>&1; then
    local want="zsh git curl fzf bat zoxide fd-find ripgrep tmux git-delta eza"
    local install=""
    for p in $want; do
      # 已安装则跳过
      if dpkg -s "$p" >/dev/null 2>&1; then
        continue
      fi
      # 仓库里不存在则跳过（如 Ubuntu 22.04 没有 eza / git-delta）
      if ! apt-cache show "$p" >/dev/null 2>&1; then
        warn "软件源中没有 $p，跳过（可稍后手动安装）"
        continue
      fi
      install="$install $p"
    done
    if [ -z "$install" ]; then
      ok "apt 依赖已齐全"
    else
      info "apt 安装:$install"
      run "$sudo_cmd apt-get update -qq && $sudo_cmd apt-get install -y $install"
    fi
  elif command -v dnf >/dev/null 2>&1; then
    info "dnf 安装 zsh git fzf bat zoxide fd-find ripgrep tmux"
    run "sudo dnf install -y zsh git fzf bat zoxide fd-find ripgrep tmux"
  elif command -v pacman >/dev/null 2>&1; then
    info "pacman 安装 zsh git fzf bat zoxide fd ripgrep tmux eza"
    run "sudo pacman -S --needed --noconfirm zsh git fzf bat zoxide fd ripgrep tmux eza"
  else
    warn "未识别包管理器，请手动安装: zsh fzf bat zoxide fd ripgrep tmux"
  fi
}

if [ "$SKIP_PACKAGES" -eq 0 ]; then
  info "检查命令行工具依赖"
  case "$PLATFORM" in
    macos) install_macos_packages ;;
    linux) install_linux_packages ;;
  esac
else
  info "已跳过系统包安装（--skip-packages）"
fi

# ------------------------------ oh-my-zsh + 插件 ------------------------------
OMZ_DIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZ_DIR" ]; then
  info "安装 oh-my-zsh"
  run "git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git '$OMZ_DIR'"
else
  ok "oh-my-zsh 已存在"
fi

clone_plugin() {
  local name="$1" url="$2"
  local dest="$OMZ_DIR/custom/plugins/$name"
  if [ -d "$dest/.git" ] || [ -d "$dest" ]; then
    ok "插件 $name 已存在"
  else
    info "安装 zsh 插件 $name"
    run "git clone --depth=1 '$url' '$dest'"
  fi
}

clone_theme() {
  local name="$1" url="$2"
  local dest="$OMZ_DIR/custom/themes/$name"
  if [ -d "$dest/.git" ] || [ -d "$dest" ]; then
    ok "主题 $name 已存在"
  else
    info "安装 zsh 主题 $name"
    run "git clone --depth=1 '$url' '$dest'"
  fi
}

info "检查 zsh 主题"
clone_theme powerlevel10k https://github.com/romkatv/powerlevel10k.git

info "检查 zsh 插件"
clone_plugin zsh-autosuggestions  https://github.com/zsh-users/zsh-autosuggestions.git
clone_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
clone_plugin zsh-completions      https://github.com/zsh-users/zsh-completions.git

# ------------------------------ 软链接 ------------------------------
# 若目标已存在且不是指向本仓库的软链接，备份后再替换
link() {
  local src="$1" dest="$2"
  if [ ! -e "$src" ]; then
    warn "缺少源文件，跳过: $src"
    return
  fi
  if [ -L "$dest" ]; then
    local current
    current="$(readlink "$dest")"
    if [ "$current" = "$src" ]; then
      ok "已链接 $dest"
      return
    fi
    info "更新软链接 $dest -> $src"
    run "ln -sfn '$src' '$dest'"
    return
  fi
  if [ -e "$dest" ]; then
    info "备份 $dest -> $dest.bak.$STAMP"
    run "mv '$dest' '$dest.bak.$STAMP'"
  fi
  info "链接 $dest -> $src"
  run "ln -sfn '$src' '$dest'"
}

info "建立配置软链接"
# 注意：~/.zshrc 是 ~/.oh-my-zsh 之外的入口，指向本仓库
link "$REPO_DIR/oh-my-zsh/.zshrc"    "$HOME/.zshrc"
link "$REPO_DIR/oh-my-zsh/.zprofile" "$HOME/.zprofile"
link "$REPO_DIR/oh-my-zsh/.p10k.zsh" "$HOME/.p10k.zsh"
link "$REPO_DIR/tmux/.tmux.conf"     "$HOME/.tmux.conf"

# ------------------------------ git 配置 ------------------------------
info "配置 git（非破坏式 include）"
if command -v git >/dev/null 2>&1; then
  GIT_CFG="$REPO_DIR/git/.gitconfig"
  if git config --global --get-all include.path 2>/dev/null | grep -qxF "$GIT_CFG"; then
    ok "git 已 include $GIT_CFG"
  else
    run "git config --global --add include.path '$GIT_CFG'"
  fi
  if [ "$PLATFORM" = macos ] || command -v delta >/dev/null 2>&1; then
    ok "git pager: delta"
  else
    warn "未安装 delta，git diff 将使用默认 pager（可 apt install git-delta）"
  fi
else
  warn "未找到 git，跳过 git 配置"
fi

# ------------------------------ 私有变量 ------------------------------
SECRETS_DIR="$HOME/.config/zsh"
SECRETS="$SECRETS_DIR/secrets.zsh"
info "准备私有变量目录 $SECRETS_DIR"
if [ -f "$SECRETS" ]; then
  ok "已存在 $SECRETS"
  run "chmod 600 '$SECRETS'"
else
  run "mkdir -p '$SECRETS_DIR'"
  run "cp '$REPO_DIR/oh-my-zsh/secrets.example.zsh' '$SECRETS'"
  run "chmod 600 '$SECRETS'"
  ok "已生成 $SECRETS（请填入真实值）"
fi

# ------------------------------ 完成提示 ------------------------------
ZSH_BIN="$(command -v zsh || true)"
CURRENT_SHELL="$(basename "${SHELL:-/bin/bash}")"

echo
info "安装完成"
if [ "$PLATFORM" = macos ]; then
  warn "iTerm2 手动建议：Profiles → Terminal → 勾选 Shell Integration；Appearance 选 Minimal"
  warn "字体：安装并选用 MesloLGS/Meslo Nerd Font（p10k 需要 Nerd Font 图标）"
else
  warn "服务器提示：非 iTerm2 环境图标需客户端 Nerd Font；tmux 复制走 OSC 52"
fi
if [ "$CURRENT_SHELL" != "zsh" ]; then
  warn "当前登录 shell 是 $CURRENT_SHELL，切换：chsh -s $ZSH_BIN"
fi
echo
echo "  重新打开终端，或执行:  exec zsh"
echo "  查看使用文档:          $REPO_DIR/docs/terminal.md"
echo "  移植说明:              $REPO_DIR/docs/porting.md"
