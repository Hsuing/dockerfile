FROM jdk:1.8

LABEL maintainer="xiong.han"

ENV TOMCAT_MAJOR=8 \
    TOMCAT_VERSION=8.5.3 \
    TOMCAT_HOME=/opt/tomcat \
    CATALINA_HOME=/opt/tomcat \
    PATH="${PATH}:/opt/tomcat/bin" \
    CATALINA_OUT=/dev/null

COPY entrypoint.sh web.xml context.xml /tmp/

    # download and install tomcat 8
RUN apk add --no-cache curl && \
    curl -jksSL -o /tmp/apache-tomcat.tar.gz http://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    gunzip /tmp/apache-tomcat.tar.gz && \
    tar -C /opt -xf /tmp/apache-tomcat.tar && \
    ln -s /opt/apache-tomcat-${TOMCAT_VERSION} ${TOMCAT_HOME} && \        
    # add config
    mv /tmp/entrypoint.sh /bin/entrypoint.sh && \
    mv /tmp/web.xml /tmp/context.xml ${TOMCAT_HOME}/conf/ && \
    # install su-exec
    apk add --no-cache su-exec && \
    # clean up
    apk del curl && \
    rm -rf ${TOMCAT_HOME}/webapps/* && \    
    rm -rf /tmp/* /var/cache/apk/* && \
    USER_ID=${TOMCAT_USER_ID:-1000} && \
    GROUP_ID=${TOMCAT_GROUP_ID:-1000} && \
    addgroup -g ${GROUP_ID} tomcat && \
    adduser -u ${USER_ID} -G tomcat -h ${CATALINA_HOME} -D -s /sbin/nologin tomcat && \
    chown -L -R tomcat:tomcat ${CATALINA_HOME} && chmod 400 ${CATALINA_HOME}/conf/* && \
    sync
    
EXPOSE 8080