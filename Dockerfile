# --- 阶段 1: 构建 Astro 应用 ---
# 使用Node.js官方LTS镜像作为构建环境
FROM node:20-alpine AS builder

WORKDIR /app

# 复制 package.json 和 package-lock.json (或 yarn.lock/pnpm-lock.yaml)
# 这样可以在依赖未改变时利用Docker缓存
COPY package.json ./
COPY package-lock.json ./
# 如果使用 yarn 或 pnpm，复制对应的锁文件
# COPY yarn.lock ./
# COPY pnpm-lock.yaml ./

# 安装项目依赖 (不安装开发依赖，减小体积)
RUN npm install --frozen-lockfile --omit=dev

# 复制所有项目文件到构建环境 (这一步会把您本地或服务器上git pull下来的整个项目代码复制进去)
COPY . .

# 执行 Astro 构建命令 (确保 astro.config.mjs 中 output: 'static')
RUN npm run build


# --- 阶段 2: 运行 Web 服务器 (Nginx) ---
# 使用轻量级的Nginx官方镜像
FROM nginx:alpine

# 复制构建好的静态文件到Nginx的默认静态文件目录
# 构建后的静态文件位于 /app/dist 目录下
COPY --from=builder /app/dist /usr/share/nginx/html

# 暴露HTTP端口
EXPOSE 80

# 启动Nginx服务
CMD ["nginx", "-g", "daemon off;"]