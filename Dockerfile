FROM eclipse-temurin:17-jre-jammy
RUN groupadd -g 322 lavalink && useradd -r -u 322 -g lavalink lavalink
WORKDIR /opt/Lavalink
ADD https://github.com/lavalink-devs/Lavalink/releases/download/4.2.2/Lavalink.jar Lavalink.jar
RUN mkdir -p plugins
ADD https://github.com/lavalink-devs/youtube-source/releases/download/1.18.1/youtube-plugin-1.18.1.jar plugins/
COPY application.yml .
RUN chown -R lavalink:lavalink /opt/Lavalink
USER lavalink
EXPOSE 2333
ENTRYPOINT ["java", "-jar", "Lavalink.jar"]
