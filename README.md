Dockerized pukiwiki 1.5.1

# Quick Start
The quickest way to get started is using docker-compose.

```
$ wget https://raw.githubusercontent.com/skyblue3350/alpine-pukiwiki/master/docker-compose.yml
```

edit envriontment
&
start it

```
$ docker-compose up -d
```

access it

# Available Configuration Parameters

| Parameter | Description |
|-----------|-------------|
| WIKI_PAGE_TITLE | title |
| WIKI_PUKIWIKI_URL | url |
| WIKI_MODIFIER | admin name |
| WIKI_MODIFIER_LINK | admin home page url |
| ADMINPASS | admin password sample is plane|
