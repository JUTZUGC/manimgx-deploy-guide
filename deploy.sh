#!/usr/bin/env bash
set -euo pipefail
# ManimGX 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://manimgx.academa.ai/user-guide/quickstart/
# 更新日期：2026-10-30
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v python3 >/dev/null 2>&1 || command -v python >/dev/null 2>&1 || { echo "需要先安装 Python 3"; exit 1; }

mkdir -p .download
cd .download

python -c "import sys; sys.exit(0 if sys.version_info >= (3, 13) else '需要 Python 3.13 或更高版本')"
python -m pip install --upgrade pip
python -m pip install manimgx
python -c "import manimgx; print('manimgx 导入成功')"

echo ""

echo "安装完成：写一个 scene.py，运行 manimgx render scene.py 就能得到 1080p60 的 MP4；详细用法见官方 Quickstart"
echo "若结果异常或需要改配置，请参考官方文档：https://manimgx.academa.ai/user-guide/quickstart/"
