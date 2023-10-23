dockerfile官方文档，https://docs.docker.com/engine/reference/builder/#syntax

## 1.jdk

```bash
[root@k8s-master01 jdk]# tree -L 1
.
├── Dockerfile
└── jdk-8u391-linux-x64.tar.gz

0 directories, 2 files


#生成镜像
docker build -t jdk:1.8 .
```

* 引用jdk:1.8镜像

```
vim Dockerfile

FROM jdk:1.8

# 复制应用程序到容器
COPY myapp.jar /opt/myapp/myapp.jar

# 定义工作目录并设置entrypoint
WORKDIR /opt/myapp
CMD ["java", "-jar -Xms1024m -Xmx2048m", "myapp.jar"]

```

* 缩小体积

```bash
#生成base镜像
docker build -f /root/jdk/baseDockerfile . -t base-alpine:latest

#生成jdk
docker build -f /root/jdk/jdkDockerfile . -t jdk:1.8


[root@k8s-master01 jdk]# docker images;
REPOSITORY                                                    TAG       IMAGE ID       CREATED             SIZE
jdk                                                           1.8    cf1ec13fdf8a      About an hour ago   180MB
base-alpine                                                   latest    8c57dd67eeda   About an hour ago   15.9MB
```

## 2.tomcat



## 3.tini

**tini 启动程序** 在 *Docker* 1.13 或更高版本中，已经集成了 *tini* 启动程序

*docker run方式：*

```
docker run --init 镜像名称
```

*docker-compose方式：*

```bash
version: '2.4'
services:  
  dmga-dg-portal:
    build: ./apps/dmga-dg-portal
    image: dmga-dg-portal:latest
    init: true  # 指定启动进程为tini
```

