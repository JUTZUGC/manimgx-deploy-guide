# ManimGX 一键安装指南

> 第三方部署指南 · 非 ManimGX 官方仓库。官方项目：[academa-labs/manimgx](https://github.com/academa-labs/manimgx)
> 内容来自官方文档（2026-10-30）。项目迭代快，请以[官方文档](https://manimgx.academa.ai/user-guide/quickstart/)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 同样的五个场景，ManimCE 要 278 秒，ManimGX 3 秒出片；API 还是 Manim 那一套，Agent 写脚本就能出 3D 视频。

⚠️ 需要 Python 3.13 或更高版本，Windows / macOS / Linux 都有预编译 wheel，无需 Rust 工具链。渲染走 wgpu：Windows 建议 DX12 或 Vulkan 显卡，老显卡、虚拟机和远程桌面可能退回软件渲染或直接失败。字体、排版与视频编码已内置，不用另装 ffmpeg。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/manimgx-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会先确认 Python 3.13+，再用 pip 装 manimgx，最后跑一次导入检查确认引擎可用，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## ManimGX 是什么？

ManimGX 是开源的用 Manim 的 Python API 写 3D 动画，Rust + wgpu 引擎直接把脚本渲染成 1080p60 的 MP4（协议：MIT，<img src="https://img.shields.io/github/stars/academa-labs/manimgx?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

Manim 兼容的 3D 动画引擎：用同一套 Scene / Mobject API 写脚本，Rust + wgpu 负责渲染与编码，直接输出 MP4；内置字体、排版和视频编码，可在浏览器里跑。

- 快：同场景比 ManimCE 快约 90 倍，比 ManimGL 快约 11 倍
- 兼容：沿用 Manim CE 的 Python API，老脚本改导入就能跑
- 真 3D：三维相机、光照、材质与空间曲线
- 零额外依赖：字体、排版、视频编码都打包好了
- 预编译 wheel：装完即用，不用编译 Rust
- 适合 Agent：脚本由模型生成，渲染交给引擎

（来源：[官方仓库](https://github.com/academa-labs/manimgx)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 2.3k stars 10 月新项目 | 名称搜索仅 10 条结果 |
| 渲染快 | 同场景比 ManimCE 快约 90 倍 |
| API 兼容 Manim CE | 迁移成本低 |
| 预编译 wheel | 不需要 Rust 工具链 |
| 自带字体与编码 | 不用另装 ffmpeg |
| MIT 协议 | 可商用可二开 |

| 需要注意 | 说明 |
|---|---|
| 要求 Python 3.13+ | 老环境要升级 |
| 渲染依赖 GPU 与图形驱动 | — |
| 生态比 Manim 社区小 | 示例还在积累 |
| 3D 场景调试比 2D 更费时间 | — |
| 早期项目 | 接口可能调整 |

> 以上基于官方文档与社区反馈整理（2026-10-30），以官方最新文档为准。

## 快速部署（官方方式）

```bash
python -c "import sys; sys.exit(0 if sys.version_info >= (3, 13) else '需要 Python 3.13 或更高版本')"
python -m pip install --upgrade pip
python -m pip install manimgx
python -c "import manimgx; print('manimgx 导入成功')"
```

部署步骤来源：[https://manimgx.academa.ai/user-guide/quickstart/](https://manimgx.academa.ai/user-guide/quickstart/)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 与 pyproject.toml 确认 Python 3.13+ 与预编译 wheel | 已核对 2026-10-30 |
| README 确认 pip 安装、manimgx render 用法与内置编码 | 已核对 2026-10-30 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-10-30 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-30 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目本身不含 MCP；本仓库的 MCP 只提供安装要求、渲染步骤与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-30）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\manimgx-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 第一个动画

新建 `scene.py`：

```python
import manimgx as m


class Hello3D(m.ThreeDScene):
    def construct(self) -> None:
        self.set_camera_orientation(phi=65 * m.DEGREES, theta=-45 * m.DEGREES)
        self.begin_ambient_camera_rotation(rate=0.5)
        cube = m.Cube(side_length=3, fill_opacity=0.3, stroke_width=2)
        self.play(m.Create(cube), run_time=2)
        self.wait(4)
```

渲染：

```bash
manimgx render scene.py
```

同目录会生成 `Hello3D.mp4`，1080p60。

## 让 Agent 自己装

官方给的提示词可以直接发给支持读链接的 Agent：

```text
Follow https://manimgx.academa.ai/llms.txt.
Install ManimGX, make a 3D animation of the solar system, and open it.
```

## 注意

- 必须 Python 3.13+，低于这个版本 pip 会直接拒绝
- 渲染依赖显卡驱动，虚拟机里可能拿不到 GPU
- 单帧特别复杂时仍会慢，先用小场景验证流程
- 示例与文档都在 manimgx.academa.ai，版本更新较快

## 常见坑

- pip 报 Requires-Python：先升级到 Python 3.13 或更高
- 导入报错缺运行库：Windows 装最新的显卡驱动与 VC++ 运行库
- 渲染黑屏或崩溃：确认不是远程桌面 / 虚拟机，或改用有 DX12 的机器
- 命令找不到：确认 pip 装到了当前 Python，用 python -m manimgx 也能跑
- 中文乱码：用项目内置字体或在脚本里显式指定字体
- 渲染很慢：先在最小场景跑通，再逐步加元素

## 免责声明

本仓库为第三方指南，与 ManimGX 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-30），项目迭代快，请以[官方文档](https://manimgx.academa.ai/user-guide/quickstart/)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
