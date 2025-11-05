#!/bin/bash

# 掷圣杯游戏部署脚本
# 这个脚本将帮助你快速部署游戏到GitHub Pages

echo "=== 掷圣杯圣杯游戏圣杯游戏 ==="
echo

# 检查是否安装了git
if ! command -v git &> /dev/null; then
    echo "错误：未安装git。请先安装git。"
    echo "Windows: https://git-scm.com/download/win"
    echo "macOS: https://git-scm.com/download/mac"
    echo "Linux: 通常发行版的包管理器安装git"
    exit 1
fi

# 检查是否安装了curl
if ! command -v curl &> /dev/null; then
    echo "错误：未安装curl。请先安装curl。"
    echo "Windows: 通常已包含在git bash中"
    echo "macOS: brew brew install curl"
    echo "Linux: sudo发行发行版的包管理器安装curl"
    exit 1
fi

# 检查是否用户是否GitHub账号
echo "请输入你的GitHub用户名："
read github_username

echo "请输入你的GitHub仓库名（例如：divination-cups）："
read repo_name

# 检查仓库是否存在
echo "检查仓库是否存在..."
repo_exists=$(curl -s -o /dev/null -w "%{http_code}" https://github.com/$github_username/$repo_name)

if [ $repo_exists -ne 200 ]; then
    echo "仓库不存在不存在，将创建新仓库..."
    
    # 检查是否安装了GitHub CLI（可选）
    if command -v gh &> /dev/null; then
        echo "使用GitHub CLI创建仓库..."
        gh repo create $repo_name --public --description "掷圣杯游戏 - 传统占卜占卦小游戏"
    else
        echo "提示：安装GitHub CLI (https://cli.github.com/) 可以简化仓库创建过程"
        echo "请手动在GitHub上创建仓库，然后继续..."
        echo "仓库创建地址：https://github.com/new"
        echo "按回车键继续..."
        read
    fi
fi

# 初始化git仓库（如果尚未初始化）
if [ ! -d .git ]; then
    echo "初始化git仓库..."
    git init
    git add .
    git commit -m "初始提交：掷圣杯游戏"
fi

# 添加远程仓库
git remote add origin https://github.com/$github_username/$repo_name.git 2>/dev/null

# 推送到GitHub
echo "推送到GitHub..."
git push -u origin main

# 启用GitHub Pages
echo "启用GitHub Pages..."
echo "请手动在GitHub仓库设置中启用GitHub Pages："
echo "1. 访问 https://github.com/$github_username/$repo_name/settings/pages"
echo "2. 在Source部分，选择main分支和根目录"
echo "3. 点击Save"
echo

# 完成消息
echo "=== 部署完成 ==="
echo "你的游戏将在几分钟后可以访问："
echo "https://$github_username.github.io/$repo_name/"
echo
echo "如果遇到问题，请参考README.md中的详细部署指南。"
