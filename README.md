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

## Using pre-built docker image

Using automated build image from <https://hub.docker.com/r/mixhq/neo/>:

```
docker run --rm -it --name ineo -p 10332:10332 -v `pwd`/data:/data mixhq/neo
```
