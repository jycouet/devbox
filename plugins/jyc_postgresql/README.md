# jyc_postgresql

1. Add in your `devbox.json`

```json
{
  //...
  "include": ["github:jycouet/devbox?dir=plugins/jyc_postgresql"]
}
```

2. start postgresql in the background

```sh
devbox services up -b
```

3. create your database

```sh
# create an empty database. (to tune name, login, ... check `tools/devbox/db-init.sh`)
devbox run db:init
```

---

## speed run

```
wget https://raw.githubusercontent.com/jycouet/devbox/refs/heads/main/plugins/jyc_postgresql/devbox.json
```
