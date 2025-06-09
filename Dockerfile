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

# 安装项目依赖
# 或者 yarn install --frozen-lockfile --production \
# 或者 pnpm install --frozen-lockfile --prod
RUN npm install --frozen-lockfile --omit=dev \
# 复制所有项目文件到构建环境
COPY . .

# 执行 Astro 构建命令
# 确保 astro.config.mjs 中 output: 'static'
RUN npm run build


# --- 阶段 2: 运行 Web 服务器 (Nginx) ---
# 使用轻量级的Nginx官方镜像
FROM nginx:alpine

# 复制构建好的静态文件到Nginx的默认静态文件目录
# 构建后的静态文件位于 /app/dist 目录下
COPY --from=builder /app/dist /usr/share/nginx/html

# 复制自定义的Nginx配置 (如果需要)
# 如果你有自定义的Nginx配置，例如特定的缓存策略或重定向规则
# 可以创建一个 nginx.conf 文件在项目根目录，然后复制过来
# COPY nginx.conf /etc/nginx/nginx.conf

# 暴露HTTP端口
EXPOSE 80

# 启动Nginx服务
CMD ["nginx", "-g", "daemon off;"]