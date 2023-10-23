FROM alpine:latest

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

ENV JAVA_HOME="/opt/java" \
	PATH="$PATH:${JAVA_HOME}/bin"

RUN  mkdir "/vela"

COPY zookeeper-3.5.4-beta.jar /vela/zookeeper-3.5.4-beta.jar

# 设置tini作为entrypoint
ENTRYPOINT ["/sbin/tini","--"]

CMD ["java", "-version"]

#CMD ["java"," -jar -Xms500m -Xmx1024m", "/vela/zookeeper-3.5.4-beta.jar"] 

#CMD ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]