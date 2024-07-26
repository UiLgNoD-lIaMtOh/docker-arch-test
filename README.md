# 使用 docker buildx 命令来创建和推送 list 测试多平台镜像推送一个tag  
![Watchers](https://img.shields.io/github/watchers/UiLgNoD-lIaMtOh/docker-arch-test) ![Stars](https://img.shields.io/github/stars/UiLgNoD-lIaMtOh/docker-arch-test) ![Forks](https://img.shields.io/github/forks/UiLgNoD-lIaMtOh/docker-arch-test) ![Vistors](https://visitor-badge.laobi.icu/badge?page_id=UiLgNoD-lIaMtOh.docker-arch-test) ![LICENSE](https://img.shields.io/badge/license-CC%20BY--SA%204.0-green.svg)
<a href="https://star-history.com/#UiLgNoD-lIaMtOh/docker-arch-test&Date">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=UiLgNoD-lIaMtOh/docker-arch-test&type=Date&theme=dark" />
    <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=UiLgNoD-lIaMtOh/docker-arch-test&type=Date" />
    <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=UiLgNoD-lIaMtOh/docker-arch-test&type=Date" />
  </picture>
</a>

## ghrc.io
镜像仓库链接：[https://github.com/UiLgNoD-lIaMtOh/docker-arch-test/pkgs/container/alpine-test](https://github.com/UiLgNoD-lIaMtOh/docker-arch-test/pkgs/container/alpine-test)

## 通知 docker 使用 qemu 支持多架构编译
    docker run --platform linux/amd64 --privileged --rm tonistiigi/binfmt:master --install all

# 展示可支持的模拟架构
    docker run --privileged --rm tonistiigi/binfmt:master

# 安装并启用 buildx 插件
    docker buildx install

# 创建并使用一个新的构建器实例
    docker buildx create --use

## docker-arch-test 测试材料
    # docker-arch-test 目录结构
    .
    ├── arch-test.sh
    ├── docker-compose-amd64.yml
    ├── docker-compose-arm64.yml
    └── Dockerfile

## arch-test.sh 测试材料脚本内容
    #!/bin/ash
    uname -m
    uname -s

## docker-compose-amd64.yml 内容
    services:
      arch-app:
        build:
          context: .
        platform: linux/amd64
        image: ghcr.io/uilgnod-liamtoh/docker-arch-test:latest
        command:
          - "/bin/ash"
          - "/app/arch-test.sh"

## docker-compose-arm64.yml 内容
    services:
      arch-app:
        build:
          context: .
        platform: linux/arm64/v8
        image: ghcr.io/uilgnod-liamtoh/docker-arch-test:latest
        command:
          - "/bin/ash"
          - "/app/arch-test.sh"
          
## Dockerfile 内容
    FROM alpine:latest
    ADD arch-test.sh /app
    WORKDIR /app
    CMD ["/bin/ash", "/app/arch-test.sh"]
    
# 构建并推送多平台的镜像
    docker buildx build --platform linux/amd64,linux/arm64/v8 -t ghcr.io/uilgnod-liamtoh/docker-arch-test:latest --push .

## arm64 平台架构打印测试
    docker run --rm --platform linux/arm64 ghcr.io/uilgnod-liamtoh/docker-arch-test:latest
    # 打印效果
        aarch64
        Linux

## amd64 平台架构打印测试
    docker run --rm --platform linux/amd64 ghcr.io/uilgnod-liamtoh/docker-arch-test:latest
    # 打印效果
        x86_64
        Linux

## 测试成功，此方案可行有效
