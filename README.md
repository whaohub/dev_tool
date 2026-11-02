# dev_tool

个人开发环境配置（macOS 主力 / Ubuntu 服务器通用）。所有配置集中在仓库里，
`$HOME` 只保留软链接，换机器时 `git clone` + 跑一次安装脚本即可。

## 快速安装

```bash
git clone https://github.com/whaohub/dev_tool.git ~/env_config/dev_tool
~/env_config/dev_tool/install.sh            # 装依赖 + 建软链接（可重复执行）
# 服务器还要切换登录 shell：
chsh -s "$(command -v zsh)"
```

先预览：`./install.sh --dry-run` · 只建链接：`./install.sh --skip-packages`

## 目录

| 路径 | 说明 | 文档 |
|------|------|------|
| `install.sh` | 一键安装（自动识别 macOS / Ubuntu，幂等，带备份） | [移植说明](docs/porting.md) |
| `oh-my-zsh/` | zsh 配置（模块化 `conf.d/`、p10k、跨平台工具探测） | [终端文档](docs/terminal.md) |
| `tmux/.tmux.conf` | tmux 配置（分屏、窗格、OSC 52 复制、可选 TPM 插件） | [终端文档](docs/terminal.md#2-快捷键) |
| `git/.gitconfig` | git + delta 配置（通过 `include.path` 引入，不覆盖身份） | [终端文档](docs/terminal.md#5-git-集成) |
| `nvim/` | Neovim 配置（0.11，lazy.nvim，同时兼容 VSCode 插件） | [nvim/README.md](nvim/README.md) |
| `docs/` | 使用文档与移植说明 | [docs/terminal.md](docs/terminal.md) · [docs/porting.md](docs/porting.md) |

## 包含的工具栈

**shell**：zsh + oh-my-zsh + powerlevel10k + zsh-autosuggestions / syntax-highlighting / completions
**CLI**：eza（ls）、bat（cat）、zoxide（cd）、fzf（Ctrl-R / Ctrl-T / Alt-C）、ripgrep、fd、git-delta、tmux
**编辑器**：neovim（LSP / treesitter / telescope / cmp）

工具缺失时会自动降级跳过（如 Debian 的 `batcat`、`fdfind`、无 `eza` 时回退 `exa`/`ls`）。

## 软链接一览

```
~/.zshrc     -> oh-my-zsh/.zshrc
~/.zprofile  -> oh-my-zsh/.zprofile
~/.p10k.zsh  -> oh-my-zsh/.p10k.zsh
~/.tmux.conf -> tmux/.tmux.conf
~/.gitconfig ：通过 include.path 引入 git/.gitconfig
~/.config/zsh/secrets.zsh ：私有变量（不入库，权限 600）
```
