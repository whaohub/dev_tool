# zsh 配置

`~/.zshrc` 指向本目录 `.zshrc`，配置按模块拆分在 `conf.d/`。
完整使用说明见 **[../docs/terminal.md](../docs/terminal.md)**，移植到服务器见 **[../docs/porting.md](../docs/porting.md)**。

## 文件

| 文件 | 软链接到 | 作用 |
|------|----------|------|
| `.zshrc` | `~/.zshrc` | 入口：instant prompt → iTerm2 集成 → oh-my-zsh → conf.d → p10k |
| `.zprofile` | `~/.zprofile` | 登录 shell 环境（Homebrew 路径探测、镜像、OrbStack） |
| `.p10k.zsh` | `~/.p10k.zsh` | 提示符配置（`p10k configure` 生成） |
| `conf.d/00-env.zsh` | - | EDITOR / PATH / 私有变量加载 |
| `conf.d/10-options.zsh` | - | 历史、补全样式、按键绑定 |
| `conf.d/20-aliases.zsh` | - | 别名与函数 |
| `conf.d/30-tools.zsh` | - | eza / bat / zoxide / fzf（跨平台探测） |
| `secrets.example.zsh` | - | 私有变量模板 → 复制到 `~/.config/zsh/secrets.zsh` |

## 约定

1. `conf.d/*.zsh` 按文件名顺序加载，**不能有终端输出**（会破坏 p10k instant prompt）
2. 新增工具一律先探测再启用，例如：
   ```zsh
   (( $+commands[foo] )) && alias bar='foo --baz'
   ```
3. 私有变量只放 `~/.config/zsh/secrets.zsh`，不要写进仓库

## 新增一段配置

```bash
$EDITOR conf.d/20-aliases.zsh   # 或新建 conf.d/40-xxx.zsh
exec zsh
```
