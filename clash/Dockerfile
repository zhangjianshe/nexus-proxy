FROM dreamacro/clash

# 创建目录（其实 docker volume 会自动创建）
VOLUME [ "/config" ]
RUN mkdir -p /config

# 复制配置文件到 /config
COPY ./config.yaml /config/config.yaml

# 软连接 /config/config.yaml 到 Clash 默认读取路径
RUN mkdir -p /root/.config/clash && \
    ln -sf /config/config.yaml /root/.config/clash/config.yaml

# 开放端口
EXPOSE 7890 7891 7892
