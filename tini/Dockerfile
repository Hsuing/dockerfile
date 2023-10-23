FROM alpinelatest

ENV TZ=AsiaShanghai
RUN echo httpmirrors.aliyun.comalpinev3.15main  etcapkrepositories
RUN echo httpmirrors.aliyun.comalpinev3.15community  etcapkrepositories
RUN apk update && 
    apk add --no-cache tzdata && 
    apk add --no-cache tini

RUN ln -snf usrsharezoneinfo$TZ etclocaltime && echo $TZ  etctimezone

COPY jdk-8u391-linux-x64.tar.gz tmpjdk.tar.gz

RUN mkdir optjava && 
    tar -xf tmpjdk.tar.gz -C optjava --strip-components=1

ENV JAVA_HOME optjava
ENV PATH $PATH$JAVA_HOMEbin

RUN  mkdir vela

COPY zookeeper-3.5.4-beta.jar velazookeeper-3.5.4-beta.jar

# 设置tini作为entrypoint
ENTRYPOINT [sbintini,--]

CMD [java, -version]

#CMD [java, -jar -Xms500m -Xmx1024m, velazookeeper-3.5.4-beta.jar] 

#CMD [java,-Djava.security.egd=filedev.urandom,-jar,app.jar]