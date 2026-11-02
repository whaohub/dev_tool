# Neovim 快捷键说明

对应 `lua/keymaps.lua`（全局）与 `lua/lsp.lua`（LSP 附加后生效）。
Leader 键：`空格`。

## 基础
| 模式 | 快捷键 | 功能 |
|------|--------|------|
| 插入 | `jj` | 退出插入模式 |
| 普通 | `<Leader>w` | 保存 |
| 普通 | `<Leader>q` / `<Leader>Q` | 退出窗口 / 退出全部 |
| 普通 | `<Leader>e` | 打开/关闭文件树 |
| 普通 | `<Leader>h` | C/C++ 头文件与源文件切换（clangd） |

## 窗口
| 模式 | 快捷键 | 功能 |
|------|--------|------|
| 普通 | `Ctrl+h/j/k/l` | 在窗口间移动 |
| 普通 | `Ctrl+↑/↓` | 调整窗口高度 |
| 普通 | `Ctrl+←/→` | 调整窗口宽度 |

## 缓冲区（bufferline）
| 普通 | 功能 |
|------|------|
| `gt` / `gT` | 下一个 / 上一个缓冲区 |
| `<Leader>1..9` | 跳到第 N 个缓冲区 |
| `<Leader>bc` | 关闭当前缓冲区 |
| `<Leader>bp` | 选择要关闭的缓冲区 |
| `<Leader>bo` | 关闭其它缓冲区 |

## 查找（telescope）
| 普通 | 功能 |
|------|------|
| `<Leader>ff` | 查找文件 |
| `<Leader>fg` | 查找 git 文件 |
| `<Leader>fo` | 最近打开的文件 |
| `<Leader>fb` | 缓冲区列表 |
| `<Leader>fl` | 全局搜索（live grep） |
| `<Leader>fc` | 搜索光标下单词 |
| `<Leader>fd` | 诊断列表 |
| `<Leader>fh` | 帮助文档 |

## 诊断 / 符号（trouble）
| 普通 | 功能 |
|------|------|
| `<Leader>xx` | 全部诊断 |
| `<Leader>xX` | 当前文件诊断 |
| `<Leader>cs` | 符号面板 |
| `<Leader>cl` | LSP 定义/引用面板 |
| `<Leader>xL` / `<Leader>xQ` | Location / Quickfix 列表 |

## 代码（LSP 附加后，缓冲区生效）
| 普通 | 功能 |
|------|------|
| `gd` / `gD` | 跳转定义 / 声明 |
| `gi` / `,D` | 跳转实现 / 类型定义 |
| `K` | 悬停文档 |
| `Ctrl+k` | 函数签名 |
| `gr` | 引用列表 |
| `,rn` | 重命名 |
| `,ca` | 代码操作 |
| `<Leader>qf` | 应用首选修复 |
| `,f` | 格式化 |
| `[d` / `]d` | 上/下一条诊断 |
| `,e` / `,q` | 诊断浮窗 / 诊断写入 location list |
| `<Leader>dh` | 切换 inlay hints |
| `,wa` / `,wr` / `,wl` | 添加/移除/列出 workspace 目录 |

## Git（gitsigns）
| 普通 | 功能 |
|------|------|
| `]c` / `[c` | 下一个 / 上一个改动块 |
| `<Leader>gp` | 预览改动块 |
| `<Leader>gb` | 查看该行 blame |
| `<Leader>gs` / `<Leader>gr` | 暂存 / 回退改动块 |

## Treesitter 增量选择
| 模式 | 快捷键 | 功能 |
|------|--------|------|
| 普通 | `gss` | 开始选择（当前 AST 节点） |
| 视觉 | `gsi` | 扩大到上层节点 |
| 视觉 | `gsc` | 扩大到作用域 |
| 视觉 | `gsd` | 缩小选区 |

## 视觉模式缩进
`<` / `>` 缩进后保持选中。

## 终端（toggleterm）
| 模式 | 快捷键 | 功能 |
|------|--------|------|
| 普通/插入 | `Ctrl+_` | 打开/关闭浮动终端 |
| 终端 | `Esc` / `jk` | 回到普通模式 |
| 终端 | `Ctrl+h/j/k/l` | 切换到其它窗口 |
