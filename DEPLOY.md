# MoneyPrinterTurbo Streamlit 部署指南

## 🚀 快速启动

### 本地启动

1. **双击启动脚本**
   `
   start_webui.bat
   `

2. **或手动启动**
   `ash
   pip install -r requirements.txt
   streamlit run webui/Main.py --server.port 8501
   `

3. **访问地址**
   - 本地: http://localhost:8501
   - 局域网: http://你的IP:8501

---

## ☁️ 云端部署

### 方案一：Streamlit Cloud（推荐）

1. **上传代码到 GitHub**
   - 仓库已创建: https://github.com/zxf451036cn-cell/MoneyPrinterTurbo

2. **登录 Streamlit Cloud**
   - 访问: https://share.streamlit.io
   - 使用 GitHub 账号登录

3. **部署应用**
   - 点击 "New app"
   - 选择仓库: zxf451036cn-cell/MoneyPrinterTurbo
   - 主文件: webui/Main.py
   - 点击 "Deploy!"

4. **配置环境变量**
   - 在 Streamlit Cloud 设置中添加环境变量:
     `
     MIMO_API_KEY=你的API Key
     `

### 方案二：Railway 部署

1. **登录 Railway**
   - 访问: https://railway.app
   - 使用 GitHub 账号登录

2. **创建新项目**
   - 点击 "New Project"
   - 选择 "Deploy from GitHub repo"
   - 选择 MoneyPrinterTurbo 仓库

3. **配置环境变量**
   - 添加环境变量:
     `
     PORT=8501
     MIMO_API_KEY=你的API Key
     `

4. **部署**
   - Railway 会自动检测并部署

### 方案三：VPS 部署

1. **购买 VPS**
   - 推荐: 阿里云、腾讯云、AWS
   - 配置: 2核4G 内存

2. **安装环境**
   `ash
   # 更新系统
   sudo apt update
   
   # 安装 Python
   sudo apt install python3 python3-pip
   
   # 安装依赖
   pip3 install -r requirements.txt
   `

3. **启动服务**
   `ash
   # 前台启动
   streamlit run webui/Main.py --server.port 8501 --server.address 0.0.0.0
   
   # 后台启动（推荐）
   nohup streamlit run webui/Main.py --server.port 8501 --server.address 0.0.0.0 > streamlit.log 2>&1 &
   `

4. **配置 Nginx 反向代理**
   `
ginx
   server {
       listen 80;
       server_name your-domain.com;
       
       location / {
           proxy_pass http://localhost:8501;
           proxy_http_version 1.1;
           proxy_set_header Upgrade ;
           proxy_set_header Connection "upgrade";
           proxy_set_header Host System.Management.Automation.Internal.Host.InternalHost;
           proxy_set_header X-Real-IP ;
           proxy_set_header X-Forwarded-For ;
           proxy_set_header X-Forwarded-Proto ;
       }
   }
   `

5. **配置 SSL（可选）**
   `ash
   sudo apt install certbot python3-certbot-nginx
   sudo certbot --nginx -d your-domain.com
   `

---

## 🐳 Docker 部署

### 创建 Dockerfile

`dockerfile
FROM python:3.11-slim

WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# 复制依赖文件
COPY requirements.txt .

# 安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制项目文件
COPY . .

# 暴露端口
EXPOSE 8501

# 启动命令
CMD ["streamlit", "run", "webui/Main.py", "--server.port=8501", "--server.address=0.0.0.0"]
`

### 使用 Docker Compose

创建 docker-compose.yml:
`yaml
version: '3.8'

services:
  webui:
    build: .
    ports:
      - "8501:8501"
    environment:
      - MIMO_API_KEY=
    volumes:
      - ./storage:/app/storage
    restart: unless-stopped
`

### 启动命令

`ash
# 构建镜像
docker build -t moneyprinter-turbo .

# 启动容器
docker run -d -p 8501:8501 -e MIMO_API_KEY=你的API Key moneyprinter-turbo

# 或使用 docker-compose
docker-compose up -d
`

---

## ⚙️ 配置说明

### Streamlit 配置文件位置
`
webui/.streamlit/config.toml
`

### 主要配置项

`	oml
[server]
port = 8501                    # 服务端口
address = "0.0.0.0"           # 监听地址
maxUploadSize = 200           # 最大上传大小(MB)

[browser]
gatherUsageStats = false       # 禁用使用统计

[theme]
primaryColor = "#FF6B6B"       # 主题颜色
`

---

## 🔧 常见问题

### Q1: 无法访问 WebUI
- 检查防火墙设置
- 确认端口 8501 已开放
- 检查服务器 IP 地址

### Q2: 视频生成失败
- 检查 API Key 配置
- 确认网络连接正常
- 查看日志文件

### Q3: 内存不足
- 升级服务器配置
- 减少并发任务数
- 使用 GPU 加速

---

## 📞 技术支持

- GitHub Issues: https://github.com/zxf451036cn-cell/MoneyPrinterTurbo/issues
- 项目文档: 查看 README.md

---

## 🎯 推荐部署方案

| 方案 | 难度 | 成本 | 适用场景 |
|------|------|------|---------|
| Streamlit Cloud | ⭐ 最简单 | 免费 | 快速测试、个人使用 |
| Railway | ⭐⭐ 简单 | 免费额度 | 小型项目 |
| VPS | ⭐⭐⭐ 中等 | ¥50-200/月 | 生产环境、自定义需求 |
| Docker | ⭐⭐⭐ 中等 | 取决于服务器 | 团队协作、标准化部署 |

**推荐新手使用 Streamlit Cloud，零配置快速部署！**
