# docker-ankisyncd
> container setup for [anki-sync-server](https://github.com/tsudoko/anki-sync-server)

## Running

```bash
docker run -d -v ankisyncd-data:/home/ankisyncd/data -p 27701:27701 --name ankisyncd ankisyncd
```

## Account Creation

```bash
docker run --rm -it -v ankisyncd-data:/home/ankisyncd/data ankisyncd ankisyncctl.py adduser 'user'
```
