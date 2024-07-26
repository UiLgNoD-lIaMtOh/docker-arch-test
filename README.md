# 使用 docker buildx 命令来创建和推送 list 测试多平台镜像推送一个tag  
![Watchers](https://img.shields.io/github/watchers/UiLgNoD-lIaMtOh/docker-arch-test) ![Stars](https://img.shields.io/github/stars/UiLgNoD-lIaMtOh/docker-arch-test) ![Forks](https://img.shields.io/github/forks/UiLgNoD-lIaMtOh/docker-arch-test) ![Vistors](https://visitor-badge.laobi.icu/badge?page_id=UiLgNoD-lIaMtOh.docker-arch-test) ![LICENSE](https://img.shields.io/badge/license-CC%20BY--SA%204.0-green.svg)
<a href="https://star-history.com/#UiLgNoD-lIaMtOh/docker-arch-test&Date">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=UiLgNoD-lIaMtOh/docker-arch-test&type=Date&theme=dark" />
    <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=UiLgNoD-lIaMtOh/docker-arch-test&type=Date" />
    <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=UiLgNoD-lIaMtOh/docker-arch-test&type=Date" />
  </picture>
</a>

## ghcr.io
镜像仓库链接：[https://github.com/UiLgNoD-lIaMtOh/docker-arch-test/pkgs/container/alpine-test](https://github.com/UiLgNoD-lIaMtOh/docker-arch-test/pkgs/container/alpine-test)

## 描述
1.为了实现 actions workflow 自动化 docker 构建运行，需要添加 `GITHUB_TOKEN` 环境变量，这个是访问 GitHub API 的令牌，可以在 GitHub 主页，点击个人头像，Settings -> Developer settings -> Personal access tokens -> Tokens (classic) -> Generate new token -> Generate new token (classic) ，设置名字为 GITHUB_TOKEN 接着要配置 环境变量有效时间，勾选环境变量作用域 repo write:packages workflow 和 admin:repo_hook 即可，最后点击Generate token，如图所示
![image](https://github.com/user-attachments/assets/8f56f08d-ceee-49dd-98c9-7ba011cb54c5)
![image](https://github.com/user-attachments/assets/f42a92e9-f2e6-4424-8196-9802ace4ac5e)
![image](https://github.com/user-attachments/assets/e09dde46-c141-4782-a3c0-ead3939c4df2)
![image](https://github.com/user-attachments/assets/21d2a910-a436-4ae2-972b-6fd05364f29d)  

2.赋予 actions[bot] 读/写仓库权限，在仓库中点击 Settings -> Actions -> General -> Workflow Permissions -> Read and write permissions -> save，如图所示
![image](https://github.com/user-attachments/assets/2faa1a40-9891-4914-ace7-d5d23434b4bb)

3.转到 Actions  

    -> Clean Git Large Files 并且启动 workflow，实现自动化清理 .git 目录大文件记录  
    -> Docker Image Build and Deploy Images to GHCR CI 并且启动 workflow，实现自动化构建镜像并推送云端  
    -> Remove Old Workflow Runs 并且启动 workflow，实现自动化清理 workflow 并保留最后三个  

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
    ADD arch-test.sh /app/
    WORKDIR /app
    CMD ["/bin/ash", "arch-test.sh"]
    
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
