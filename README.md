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
# wallet file: /data/wallet.json
```

## Fast sync
See <https://docs.neo.org/docs/zh-cn/node/syncblocks.html>

## Using pre-built docker image

Using automated build image from <https://hub.docker.com/r/mixhq/neo/>:

```
docker run --rm -it --name ineo -p 10332:10332 -v `pwd`/data:/data mixhq/neo
```

## Ref
- <https://docs.neo.org/docs/zh-cn/exchange/2.10.3/deploynode.html>
- [config.json](https://github.com/neo-project/neo-cli/raw/master/neo-cli/config.json)
