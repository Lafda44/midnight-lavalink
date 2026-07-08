FROM gradle:8-jdk17 AS build
WORKDIR /app
COPY gradle gradle
COPY gradlew build.gradle.kts settings.gradle.kts gradle.properties ./
COPY build-info.txt ./
COPY LavalinkServer LavalinkServer
COPY protocol protocol
COPY plugin-api plugin-api
RUN git init && git add -A && git commit -m "build" --allow-empty --no-gpg-sign 2>/dev/null; \
    gradle :Lavalink-Server:bootJar --no-daemon -x test

FROM eclipse-temurin:17-jre-jammy
RUN groupadd -g 322 lavalink && \
    useradd -r -u 322 -g lavalink lavalink
WORKDIR /opt/Lavalink
RUN chown -R lavalink:lavalink /opt/Lavalink
USER lavalink
COPY --from=build /app/LavalinkServer/build/libs/Lavalink.jar Lavalink.jar
EXPOSE 2333
ENTRYPOINT ["java", "-jar", "Lavalink.jar"]
