# https://docs.neo.org/zh-cn/exchange/v2.10.2.html

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
RUN wget https://github.com/neo-project/neo-cli/releases/download/v2.10.3/neo-cli-linux-x64.zip && \
  wget https://github.com/neo-project/neo-plugins/releases/download/v2.10.2/ApplicationLogs.zip && \
  wget https://github.com/neo-project/neo-plugins/releases/download/v2.10.2/ImportBlocks.zip && \
  wget https://github.com/neo-project/neo-plugins/releases/download/v2.10.2/RpcWallet.zip && \
  wget https://github.com/neo-project/neo-plugins/releases/download/v2.10.2/RpcSystemAssetTracker.zip && \
  wget https://github.com/neo-project/neo-plugins/releases/download/v2.10.2/CoreMetrics.zip && \
  wget https://github.com/neo-project/neo-plugins/releases/download/v2.10.2/RpcNep5Tracker.zip && \
  wget https://github.com/neo-project/neo-plugins/releases/download/v2.10.2/SimplePolicy.zip
RUN unzip neo-cli-linux-x64.zip && \
  unzip -d neo-cli/ ApplicationLogs.zip && \
  unzip -d neo-cli/ SimplePolicy.zip && \
  unzip -d neo-cli/ ImportBlocks.zip && \
  unzip -d neo-cli/ RpcSystemAssetTracker.zip && \
  unzip -d neo-cli/ CoreMetrics.zip && \
  unzip -d neo-cli/ RpcNep5Tracker.zip && \
  unzip -d neo-cli/ RpcWallet.zip
COPY ./config.json neo-cli/

EXPOSE 10332
VOLUME /data

# start
WORKDIR /data
ENTRYPOINT ["dotnet"]
CMD ["/root/neo-cli/neo-cli.dll", "--rpc"]
