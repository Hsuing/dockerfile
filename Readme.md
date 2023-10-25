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

## 4.dotnet



## 5.node

在上述示例中，第一阶段使用 `node:14` 作为基础镜像，用于构建应用程序。首先设置工作目录为 `/app`，然后复制 `package.json` 和 `package-lock.json` 文件到工作目录，并运行 `npm install` 安装项目依赖项。

接下来，将所有文件复制到工作目录，并运行 `npm run build` 命令来构建应用程序。构建后的文件将位于 `/app/dist` 目录中。

然后，进入第二阶段，使用同样的 `node:14` 基础镜像作为运行时镜像。设置工作目录为 `/app`，然后复制第一阶段构建的 `package.json` 和 `dist` 目录到工作目录。

接着，运行 `npm install --production` 命令来安装生产环境所需的依赖项，减少镜像的体积。

最后，使用 `CMD` 指令设置容器启动时要运行的命令，这里使用 `npm start` 来启动应用程序

## 6.go





