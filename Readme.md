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

