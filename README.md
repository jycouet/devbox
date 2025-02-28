# devbox

## Install devbox

```sh
curl -fsSL https://get.jetify.com/devbox | bash
```

## Usual devbox init (node + pnpm)

```sh
devbox init
devbox add nodejs@22.12.0
devbox add pnpm@10.4.0
```

## Add plugins

[jyc_postgresql](./plugins/jyc_postgresql/README.md)

## Tips

```sh
# start devbox shell
devbox shell

# search for a package
devbox search pnpm

# create a devbox shell with a specific node version
alias env-node="mkdir .devbox-tmp && cd .devbox-tmp && devbox init && devbox add nodejs@22.12.0 && cd - && devbox shell --config .devbox-tmp && rm -fr .devbox-tmp"

# utils
devbox init && devbox add nodejs@22 && devbox shell
devbox init && devbox add nodejs@22 && devbox add pnpm@9 && devbox shell
```
