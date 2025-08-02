#!/bin/bash

# 检查是否提供了文件名
if [ -z "$1" ]; then
  echo "Usage: ./new-post.sh <filename>"
  exit 1
fi

FILENAME="$1" # 获取脚本后面输入的名称作为文件名
POST_DIR="./src/content/blog" # 根据你的配置调整路径
FILE_PATH="${POST_DIR}/${FILENAME}.md"

# 获取当前日期和时间
CURRENT_DATE=$(date +"%Y-%m-%d %H:%M:%S")

# 创建文件内容
cat << EOF > "${FILE_PATH}"
---
title: ${FILENAME}
pubDate: ${CURRENT_DATE}
tags: []
---


<script src="https://giscus.app/client.js"
        data-repo="roc80/Blog"
        data-repo-id="R_kgDOO4NnfQ"
        data-category="Announcements"
        data-category-id="DIC_kwDOO4Nnfc4Ctshe"
        data-mapping="pathname"
        data-strict="1"
        data-reactions-enabled="1"
        data-emit-metadata="0"
        data-input-position="top"
        data-theme="preferred_color_scheme"
        data-lang="zh-CN"
        data-loading="lazy"
        crossorigin="anonymous"
        async>
</script>

EOF

echo "文章 '${FILENAME}.md' 已创建在 ${POST_DIR}."
echo "文件路径: ${FILE_PATH}"