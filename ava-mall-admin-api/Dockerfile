### 基础镜像
FROM java:8
#系统编码
ENV  LANG="zh_CN.utf8"
#声明一个挂载点，容器内此路径会对应宿主机的某个文件夹
VOLUME /tmp
#应用构建成功后的jar文件被复制到镜像内，名字也改成了app.jar
ADD target/ava-mall-admin-api-1.0-SNAPSHOT.jar ava-mall-admin-api.jar
#启动容器时的进程
ENTRYPOINT ["java","-jar","/ava-mall-admin-api.jar"]
#暴露8080端口
EXPOSE 8600
