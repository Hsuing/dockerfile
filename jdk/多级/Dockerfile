FROM dockerhub.com/herlly:latest AS build
RUN mkdir /src
COPY ./ /src/
RUN mvn -T 1C -f /src/abc/pom.xml package -Dmaven.compile.fork=true -Dmaven.test.skip=true

FROM dockerhub.com/jdk:latest
ARG DEPENDENCY=/src/abc/target
ARG app
ENV APP ${app}
RUN mkdir -p /opt/${app} \
    && mkdir -p /logs/${app}
COPY --from=build ${DEPENDENCY}/${app}.jar /opt/${app}/
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
WORKDIR /opt/${app}
EXPOSE 20880
VOLUME /logs/${app}
ENTRYPOINT ["/sbin/tini","--","/docker-entrypoint.sh"]