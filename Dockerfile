# http://docs.neo.org/zh-cn/exchange/v2.9.4.html

FROM debian:9

# req
RUN apt-get update && \
  apt-get install -y unzip wget gnupg apt-transport-https

# dotnet runtime
# https://www.microsoft.com/net/download/linux-package-manager/debian9/runtime-current
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.asc.gpg
RUN wget -q https://packages.microsoft.com/config/debian/9/prod.list -O /etc/apt/sources.list.d/microsoft-prod.list
RUN chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg && chown root:root /etc/apt/sources.list.d/microsoft-prod.list
RUN apt-get update && apt-get install -y aspnetcore-runtime-2.1 libunwind-dev libleveldb-dev sqlite3 libsqlite3-dev

# neo-cli
WORKDIR /root
RUN wget https://github.com/neo-project/neo-cli/releases/download/v2.10.0/neo-cli-linux-x64.zip && \
  wget https://github.com/neo-project/neo-plugins/releases/download/v2.10.0/ApplicationLogs.zip && \
  wget https://github.com/neo-project/neo-plugins/releases/download/v2.10.0/SimplePolicy.zip
RUN unzip neo-cli-linux-x64.zip && unzip -d neo-cli/ ApplicationLogs.zip && unzip -d neo-cli/ SimplePolicy.zip
RUN sed -i 's/127.0.0.1/0.0.0.0/g' neo-cli/config.json
EXPOSE 10332
VOLUME /data

# start
WORKDIR /data
ENTRYPOINT dotnet /root/neo-cli/neo-cli.dll --rpc
