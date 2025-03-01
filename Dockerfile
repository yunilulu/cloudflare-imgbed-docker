FROM node:22.5.1

# 安裝 Git
RUN apt-get update && apt-get install -y git && apt-get clean

WORKDIR /app

# 從 GitHub 克隆最新代碼
RUN git clone https://github.com/MarSeventh/CloudFlare-ImgBed.git .

# 安裝依賴
RUN npm install

# 創建數據目錄
RUN mkdir -p ./data

# 創建入口點腳本
RUN echo '#!/bin/bash\n\
\n\
# 根據環境變數建立 wrangler.toml\n\
cat > wrangler.toml << EOL\n\
name = "${NAME:-cloudflare-imgbed}"\n\
compatibility_date = "${COMPATIBILITY_DATE:-2024-07-24}"\n\
\n\
[vars]\n\
ALLOW_RANDOM = "${ALLOW_RANDOM:-false}"\n\
BASIC_USER = "${BASIC_USER:-user}"\n\
BASIC_PASS = "${BASIC_PASS:-password}"\n\
TG_BOT_TOKEN = "${TG_BOT_TOKEN:-}"\n\
TG_CHAT_ID = ${TG_CHAT_ID:--1}\n\
AUTH_CODE = "${AUTH_CODE:-}"\n\
ALLOWED_DOMAINS = "${ALLOWED_DOMAINS:-image.example.com}"\n\
WHITELIST_MODE = "${WHITELIST_MODE:-false}"\n\
DISABLE_TELEMETRY = "${DISABLE_TELEMETRY:-true}"\n\
EOL\n\
\n\
echo "已生成 wrangler.toml 配置文件："\n\
cat wrangler.toml\n\
\n\
# 啟動應用程式\n\
exec npx wrangler pages dev ./ --kv img_url --r2 img_r2 --port 8080 --ip 0.0.0.0 --persist-to ./data\n\
' > /app/entrypoint.sh && chmod +x /app/entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["/app/entrypoint.sh"]