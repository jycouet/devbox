# jyc_postgresql

1. Add in your `devbox.json`

```json
{
  //...
  "include": ["github:jycouet/devbox?dir=plugins/jyc_postgresql"]
}
```

2. starting postgresql in the background

```sh
devbox services up -b
```

3. create your database

```sh
# This will run the `tools/devbox/db-init.sh` script
# inside you will find the name of the database you want to create
devbox run db:init
```

---

## speed run

```
wget https://raw.githubusercontent.com/jycouet/devbox/refs/heads/main/plugins/jyc_postgresql/devbox.json
```
