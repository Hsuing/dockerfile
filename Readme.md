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

