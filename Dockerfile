FROM debian:latest

ENV TSV=3.0.13.3

RUN DEBIAN_FRONTEND=noninterative \
    apt-get -y update && \
    apt-get -y install bzip2

ADD http://dl.4players.de/ts/releases/${TSV}/teamspeak3-server_linux_amd64-${TSV}.tar.bz2 ./
RUN tar jxf teamspeak3-server_linux_amd64-$TSV.tar.bz2 && \
    mv teamspeak3-server_linux_amd64 /opt/teamspeak && \
    rm teamspeak3-server_linux_amd64-$TSV.tar.bz2

ADD ./scripts/start /start

RUN chmod +x /start

EXPOSE 9987/udp
EXPOSE 38033
EXPOSE 10011

RUN useradd teamspeak && mkdir /data && chown teamspeak:teamspeak /data
VOLUME ["/data"]
USER teamspeak
CMD ["/start"]

