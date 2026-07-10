FROM eclipse-temurin:17-jre-jammy
RUN groupadd -g 322 lavalink && useradd -r -u 322 -g lavalink lavalink
WORKDIR /opt/Lavalink
RUN chown -R lavalink:lavalink /opt/Lavalink
USER lavalink
ADD https://github.com/lavalink-devs/Lavalink/releases/download/4.2.2/Lavalink.jar Lavalink.jar
ADD https://github.com/lavalink-devs/youtube-source/releases/download/1.18.1/youtube-source-1.18.1.jar youtube-source.jar
EXPOSE 2333
ENTRYPOINT ["java", "-jar", "Lavalink.jar"]
