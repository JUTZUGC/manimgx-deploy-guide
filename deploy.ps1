# ManimGX 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://manimgx.academa.ai/user-guide/quickstart/
# 更新日期：2026-10-30
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command python -ErrorAction SilentlyContinue)) { throw '需要先安装 Python 3' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

python -c "import sys; sys.exit(0 if sys.version_info >= (3, 13) else '需要 Python 3.13 或更高版本')"
python -m pip install --upgrade pip
python -m pip install manimgx
python -c "import manimgx; print('manimgx 导入成功')"

Write-Host ''

Write-Host '安装完成：写一个 scene.py，运行 manimgx render scene.py 就能得到 1080p60 的 MP4；详细用法见官方 Quickstart'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://manimgx.academa.ai/user-guide/quickstart/'
