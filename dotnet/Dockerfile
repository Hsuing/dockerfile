# 使用官方的 .NET Core SDK 镜像作为基础镜像
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env

# 设置工作目录
WORKDIR /app

# 复制项目文件到工作目录
COPY *.csproj ./
RUN dotnet restore

# 复制所有文件到工作目录并生成发布版本
COPY . ./
RUN dotnet publish -c Release -o out

# 创建最终的运行时镜像
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build-env /app/out .

# 指定容器启动时要运行的命令
ENTRYPOINT ["dotnet", "YourAppName.dll"]
