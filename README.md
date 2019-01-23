# neo-docker
Docker builds of neo chain

## Build

```
docker build -t neo .
```

## Run

```
mkdir data
docker run --rm -it --name ineo -p 10332:10332 -v $PWD/data:/data neo

# first time
> create wallet /data/wallet.db3
# later
> open wallet /data/wallet.db3
```

## Persist data

By using [CWSpear/local-persist](https://github.com/CWSpear/local-persist):

```
curl -fsSL https://raw.githubusercontent.com/CWSpear/local-persist/master/scripts/install.sh | sudo bash
docker volume create -d local-persist -o mountpoint=/data/neo --name=neo-data
```

## Using pre-built docker image

Using automated build image from <https://hub.docker.com/r/mixhq/neo/>:

```
docker run --rm -it --name ineo -p 10332:10332 -v neo-data:/data mixhq/neo
```
