# cloudflare-imgbed-docker

非常感謝原專案：
https://github.com/MarSeventh/CloudFlare-ImgBed

此為它的 Dockerfile，還沒搞過任何優化。

docker-compose.yml 使用示例，與 Dockerfile 放在同一個資料夾。
可以使用這裡的 Dockerfile 自己 build 一個 image，或是拉這裡 actions 跑好的 image。
```yml
version: "3.8"
services:
  cloudflare-imgbed:
    # build:
    #   context: .
    #   dockerfile: Dockerfile
    image: ghcr.io/yunilulu/cloudflare-imgbed-docker:latest
    container_name: cloudflare-imgbed
    ports:
      - "8080:8080"
    volumes:
      - ${PWD}/data:/app/data
    environment:
      - NAME=cloudflare-imgbed
      - COMPATIBILITY_DATE=2024-07-24
      - ALLOW_RANDOM=false
      - BASIC_USER=user
      - BASIC_PASS=password
      - TG_BOT_TOKEN=yourtoken
      - TG_CHAT_ID=-1
      - AUTH_CODE=yourcode
      - ALLOWED_DOMAINS=image.example.com
      - WHITELIST_MODE=false
      - DISABLE_TELEMETRY=true
```
