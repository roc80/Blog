#!/bin/bash

# 检查是否提供了文件名
if [ -z "$1" ]; then
  echo "Usage: ./new-post.sh <filename>"
  exit 1
fi

FILENAME="$1" # 获取脚本后面输入的名称作为文件名
POST_DIR="./src/content/weeks" # 根据你的配置调整路径
FILE_PATH="${POST_DIR}/${FILENAME}.md"

# 获取当前日期和时间
CURRENT_DATE=$(date +"%Y-%m-%d %H:%M:%S")

# 创建文件内容
cat << EOF > "${FILE_PATH}"
---
title: ${FILENAME}
pubDate: ${CURRENT_DATE}
tags: [周记]
---

EOF

echo "文章 '${FILENAME}.md' 已创建在 ${POST_DIR}."
echo "文件路径: ${FILE_PATH}"