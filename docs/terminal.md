# 终端使用文档（macOS / Ubuntu 通用）

这套配置 = **zsh + oh-my-zsh + powerlevel10k + 现代 CLI 工具**，
配置文件全部放在本仓库，`$HOME` 下只保留软链接。

---

## 1. 结构

```
dev_tool/
├── install.sh                 一键安装/更新（自动识别 macOS / Ubuntu）
├── oh-my-zsh/
│   ├── .zshrc                 ~/.zshrc       入口
│   ├── .zprofile              ~/.zprofile    登录 shell 环境（brew 等）
│   ├── .p10k.zsh              ~/.p10k.zsh    提示符
│   ├── conf.d/
│   │   ├── 00-env.zsh         EDITOR / PATH / 私有变量
│   │   ├── 10-options.zsh     历史、补全样式、按键绑定
│   │   ├── 20-aliases.zsh     别名、函数
│   │   └── 30-tools.zsh       eza / bat / zoxide / fzf（跨平台探测）
│   └── secrets.example.zsh    私有变量模板
├── tmux/.tmux.conf            ~/.tmux.conf
├── git/.gitconfig             通过 include.path 引入，不覆盖你的身份配置
├── nvim/                      Neovim 配置
└── docs/                      本目录
```

### 启动顺序

```
.zshrc
 ├─ p10k instant prompt        （最先，保证秒开）
 ├─ iTerm2 shell integration   （仅当脚本存在）
 ├─ oh-my-zsh + 主题+插件
 ├─ conf.d/*.zsh               （按文件名顺序，全部无输出）
 └─ ~/.p10k.zsh
```

> 规则：`conf.d/` 里的脚本**不能有终端输出**，否则会破坏 instant prompt。

---

## 2. 快捷键

### 终端（zsh）

| 按键 | 作用 |
|------|------|
| `Ctrl-R` | fzf 搜索历史命令（取代 zsh 自带的反向搜索） |
| `Ctrl-T` | fzf 选择文件并插入路径（右侧 bat 预览） |
| `Alt-C` | fzf 选择目录并 cd |
| `Ctrl-←/→`、`Alt-←/→` | 按单词移动光标 |
| `Ctrl-W` | 删除前一个词（按路径分段删除） |
| `Ctrl-Backspace` | 删除前一个单词 |
| `Ctrl-Delete` | 删除后一个单词 |
| `Home` / `End` | 行首 / 行尾 |
| `↑` / `↓` | 按已输入前缀搜索历史 |
| `Tab` | 带菜单的补全（大小写与模糊匹配）；连续 Tab 进入选择模式 |
| `Ctrl-C` / `Ctrl-D` | 中断 / 退出 |
| `空格开头` 的命令 | 不写入历史（适合带 token 的临时命令） |

### tmux（prefix = `Ctrl-B`，保持默认）

| 按键 | 作用 |
|------|------|
| `prefix r` | 重载 tmux 配置 |
| `prefix \|` / `prefix -` | 左右 / 上下分屏（保持当前目录） |
| `prefix c` | 新窗口（保持当前目录） |
| `prefix h/j/k/l` | 切换窗格（可连按） |
| `prefix Ctrl-h/j/k/l` | 调整窗格大小（连按，每次 10 格） |
| `Alt-方向键` | 直接切换窗格（无需 prefix） |
| `prefix Esc` | 进入复制模式（vi 风格） |
| 复制模式 `v` / `y` | 选择 / 复制到系统剪贴板（OSC 52） |
| `prefix I` | 安装 TPM 插件（首次，需已安装 tpm） |
| 鼠标 | 点击切换窗格、拖动边框、滚轮滚动 |

---

## 3. 别名与函数

| 别名 | 说明 |
|------|------|
| `ls` / `l` / `ll` / `la` / `lt` | eza：图标、目录优先、`ll/la` 带 git 状态、`lt` 树状 |
| `cat 文件` | bat 语法高亮（`--style=plain --paging=never`） |
| `cd 关键字` | zoxide 智能跳转（未匹配时退化为普通 cd） |
| `mkcd dir` | 建目录并进入 |
| `gs` / `ga` / `gaa` | git status / add / add -A |
| `gd` / `gds` / `gl` | git diff / diff --staged / log 图形化 |
| `gp` / `gpl` / `gco` / `gcb` | push / pull / checkout / checkout -b |
| `gcm` / `gca` | commit -m / commit --amend |
| `..` / `...` / `....` | 上跳 1 / 2 / 3 层 |
| `ports` | 查看监听端口 |
| `path` | 逐行打印 `$PATH` |
| `reload` | `exec zsh` 重载配置 |
| `zshconfig` | 用 `$EDITOR` 打开配置 |
| `vi` / `vim` | 指向 nvim（未装 nvim 时回退） |

补充：`auto_cd` 开启后，直接输入目录名即可进入；`cd -`、`cd -2` 可用。

---

## 4. 工具一览

| 工具 | 版本来源 | 作用 | 缺失时 |
|------|----------|------|--------|
| `eza` | brew / apt（22.04 退化为 `exa`） | 替代 `ls` | 回退到 `ls` 相关别名 |
| `bat` / `batcat` | brew / apt | 替代 `cat`、man 页高亮 | 不设 `cat` 别名 |
| `zoxide` | brew / apt | 智能 `cd` | 不包装 `cd` |
| `fzf` | brew / apt | `Ctrl-R/T`、`Alt-C` | 保留 zsh 原生命令 |
| `fd` / `fdfind` | brew / apt | fzf 的数据源 | 回退到 `find` |
| `ripgrep` | brew / apt | 快速搜索（nvim 也用） | - |
| `git-delta` | brew / apt | `git diff` 语法高亮 | 回退到默认 pager |
| `tmux` | brew / apt | 会话/分屏 | 不影响 shell |
| `powerlevel10k` | oh-my-zsh 主题 | 提示符（含 git 状态） | - |

工具缺失时 `30-tools.zsh` 会自动跳过，不会报错。

---

## 5. git 集成

`install.sh` 会把 `git/.gitconfig` **include** 进你的全局配置（不会覆盖 `user.name` / `user.email`）：

```gitconfig
[include]
    path = /path/to/dev_tool/git/.gitconfig
```

引入的内容：`core.pager = delta`、`init.defaultBranch = main`、
`merge.conflictstyle = zdiff3`、`diff.colorMoved`、`pull.ff = only`。

查看当前生效配置：`git config --global --list --show-origin`

---

## 6. 私有变量

```bash
mkdir -p ~/.config/zsh
cp oh-my-zsh/secrets.example.zsh ~/.config/zsh/secrets.zsh
chmod 600 ~/.config/zsh/secrets.zsh
# 编辑填入真实 key
```

`~/.config/zsh/secrets.zsh` 不会进仓库（`.gitignore` 已排除），权限 600。

---

## 7. 自检

```bash
# 语法检查
for f in oh-my-zsh/.zshrc oh-my-zsh/conf.d/*.zsh oh-my-zsh/.zprofile; do zsh -n "$f"; done

# 启动耗时（正常应 < 0.15s）
for i in 1 2 3; do /usr/bin/time -p zsh -i -c exit 2>&1 | grep real; done

# 关键能力
bindkey '^R'            # 应显示 fzf-history-widget
ll                      # eza 列表
git diff                # delta 渲染
tmux -f ~/.tmux.conf new-session -d && tmux show-options -g escape-time && tmux kill-server
```

---

## 8. 常见问题

| 现象 | 原因 / 解决 |
|------|-------------|
| 提示符出现方块/问号 | 终端字体不是 Nerd Font。macOS 装 `MesloLGS NF` 并在 iTerm2 里选中；SSH 到服务器时字体由**客户端**决定 |
| `cat: command not found` 或 `batcat` 报错 | Debian/Ubuntu 的包名是 `batcat`，配置已自动识别；若报错说明两者都没装 |
| `Ctrl-R` 没反应 | `fzf` 未安装，或版本 < 0.48 且没有发行版示例脚本；`sudo apt install fzf` 后重开终端 |
| `git diff` 没有高亮/侧栏 | 没装 delta：`brew install git-delta` / `apt install git-delta` |
| 启动变慢（> 0.5s） | 通常是 compdump 在重建，第二次启动即恢复；持续慢可用 `zsh -i -c 'zmodload zprof; source ~/.zshrc; zprof \| head'` 定位 |
| 在 tmux 里复制不到系统剪贴板 | 需要终端支持 OSC 52（iTerm2 默认支持）；不支持时改用 `pbcopy`/`xclip`（见 `tmux/.tmux.conf` 注释） |
| `exec zsh` 后提示 instant prompt | 说明有脚本往 stdout 输出内容，检查新加的 `conf.d/*.zsh` |
| 服务器上 `chsh` 提示 shell 非法 | `echo $(command -v zsh) >> /etc/shells` 后再 `chsh -s $(command -v zsh)` |

---

## 9. 维护

| 操作 | 命令 |
|------|------|
| 更新配置到新机器 | `git clone <repo> ~/env_config/dev_tool && ~/env_config/dev_tool/install.sh` |
| 只重建软链接 | `./install.sh --skip-packages` |
| 预览将要做什么 | `./install.sh --dry-run` |
| 恢复被覆盖的文件 | 安装时会备份为 `<文件>.bak.<时间戳>` |
| 更新插件 | `cd ~/.oh-my-zsh && git pull`（自定义插件同理） |
| 更新工具 | `brew upgrade` / `sudo apt upgrade` |
