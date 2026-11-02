# 移植到 Ubuntu 服务器

整套配置与 macOS 共用，`install.sh` 会自动走 Linux 分支。
下面是一键方式、手动方式和服务器环境的注意事项。

---

## 1. 一键安装（推荐）

```bash
# 1. 拿到仓库（任选其一）
git clone https://github.com/whaohub/dev_tool.git ~/env_config/dev_tool
# 或在没有外网时，从本机 rsync/scp 过去：
# rsync -av ~/env_config/dev_tool/ user@server:~/env_config/dev_tool/

# 2. 安装
bash ~/env_config/dev_tool/install.sh

# 3. 切换登录 shell（只需一次）
echo "$(command -v zsh)" | sudo tee -a /etc/shells
chsh -s "$(command -v zsh)"
```

脚本会做：装依赖 → 装 oh-my-zsh（若无）→ clone 3 个插件 → 建立软链接（旧文件自动备份）
→ `git include` → 生成 `~/.config/zsh/secrets.zsh`（600）。
**可重复执行**，也可先 `--dry-run` 预览。

```bash
./install.sh --dry-run          # 只看不做
./install.sh --skip-packages    # 服务器不能装包时，只建软链接
```

---

## 2. 手动安装（无外网 / 不想跑脚本）

```bash
sudo apt update
sudo apt install -y zsh git curl tmux fzf bat zoxide ripgrep fd-find
# 可选（Ubuntu 22.04 源里可能没有）：
sudo apt install -y git-delta eza

# oh-my-zsh
git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions   ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-completions       ~/.oh-my-zsh/custom/plugins/zsh-completions

# 软链接
ln -sfn ~/env_config/dev_tool/oh-my-zsh/.zshrc    ~/.zshrc
ln -sfn ~/env_config/dev_tool/oh-my-zsh/.zprofile ~/.zprofile
ln -sfn ~/env_config/dev_tool/oh-my-zsh/.p10k.zsh ~/.p10k.zsh
ln -sfn ~/env_config/dev_tool/tmux/.tmux.conf     ~/.tmux.conf

# git 配置（非破坏式）
git config --global --add include.path ~/env_config/dev_tool/git/.gitconfig
```

---

## 3. 平台差异对照

| 项目 | macOS | Ubuntu / Debian | 配置中的处理 |
|------|-------|-----------------|--------------|
| `bat` | `bat` | `batcat` | 自动探测（`BAT_BIN`） |
| `fd` | `fd` | `fdfind` | 自动探测（`FD_BIN`） |
| `eza` | `eza` | 24.04 有 `eza`，22.04 只有 `exa` | 依次尝试 `eza` → `exa` |
| `git-delta` | `git-delta` | `git-delta`（22.04 无） | 缺省回退默认 pager |
| 剪贴板 | `pbcopy` | `xclip` / `wl-copy` / OSC 52 | tmux 用 `set-clipboard on`（OSC 52） |
| Homebrew | `/opt/homebrew/bin/brew` | `/home/linuxbrew/.linuxbrew/bin/brew`（可选） | `.zprofile` 里按路径探测 |
| 字体 | 本机安装 Meslo Nerd Font | 由 SSH **客户端**提供字体 | 无需在服务器装字体 |
| iTerm2 集成 | 有 | 无 | 脚本存在才加载，自动跳过 |
| OrbStack | 有 | 无 | 文件存在才加载，自动跳过 |

---

## 4. 服务器场景注意事项

### 4.1 没有 Nerd Font 也能用

p10k 默认使用 Nerd Font 图标。如果服务器上看到的提示符是乱码方块，
那是**本地终端字体**的问题（SSH 时渲染在本地）。装好本地字体即可。
若某些场景字体实在不可用，可改成纯 ASCII 提示符：

```bash
p10k configure   # 选择 "no" powerline / "ASCII" 选项
```

### 4.2 复制粘贴（OSC 52）

`tmux/.tmux.conf` 使用 `set -g set-clipboard on`，复制内容通过终端序列送到**本地**剪贴板，
适合 SSH 场景（服务器不需要 `xclip`）。
若终端不支持 OSC 52，改成注释里的 `xclip` / `wl-copy` 版本。

### 4.3 没有 sudo 的机器

```bash
./install.sh --skip-packages
```

缺的工具会被 `30-tools.zsh` 自动跳过，不影响使用；
也可以把静态二进制放到 `~/.local/bin`（已在 PATH 中）。

### 4.4 只想要部分配置

各模块互相独立，按需软链接即可：

```bash
ln -sfn ~/env_config/dev_tool/tmux/.tmux.conf ~/.tmux.conf   # 只要 tmux
ln -sfn ~/env_config/dev_tool/oh-my-zsh/.zshrc ~/.zshrc      # 只要 zsh
```

只想用现代工具别名而不想换 sh：把 `conf.d/30-tools.zsh` 加入现有 `~/.bashrc`/`~/.zshrc` 的 source 列表。

### 4.5 容器 / 极简镜像

Docker 里通常没有 zsh，且不需要主题：

```bash
apt install -y zsh fzf bat zoxide tmux    # 或直接 cp conf.d/20-aliases.zsh
```

`10-options.zsh` 的补全缓存目录会自动创建（`~/.cache/zsh/zcompcache`），无需预建。

### 4.6 私钥 / API key

`~/.config/zsh/secrets.zsh` 需要手动填，或者把本地这份用 `scp` 传过去：

```bash
scp ~/.config/zsh/secrets.zsh user@server:~/.config/zsh/secrets.zsh
```

---

## 5. 更新与回滚

```bash
# 拉取新配置（软链接自动生效）
git -C ~/env_config/dev_tool pull && exec zsh

# 回滚：安装时旧文件都已备份
ls -1 ~/.zshrc.bak.* ~/.tmux.conf.bak.* ~/.p10k.zsh.bak.*
mv ~/.zshrc.bak.<时间戳> ~/.zshrc   # 注意这会覆盖软链接
```
