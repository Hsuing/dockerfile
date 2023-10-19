FROM alpine:latest
LABEL maintainer="xiong.han"

ENV TZ=Asia/Shanghai
RUN echo "http://mirrors.aliyun.com/alpine/v3.15/main/" > /etc/apk/repositories
RUN echo "http://mirrors.aliyun.com/alpine/v3.15/community/" >> /etc/apk/repositories
RUN apk update && \
    apk add --no-cache tzdata && \
    apk add --no-cache tini

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY jdk-8u391-linux-x64.tar.gz /tmp/jdk.tar.gz

RUN mkdir /opt/java && \
    tar -xf /tmp/jdk.tar.gz -C /opt/java --strip-components=1

ENV JAVA_HOME=/opt/java
ENV PATH=$PATH:$JAVA_HOME/bin

# 设置tini作为entrypoint
# ENTRYPOINT ["/sbin/tini", "--"]