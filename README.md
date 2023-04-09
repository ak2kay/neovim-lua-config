# a well constructed neovim config

## pre prerequisites

1. you should install neovim which version >= 0.9.0, you can use scripts in this repo to install the latest stable version of nvim.
   `./scripts/nvim.sh`

## playground

you can try this config without affecting your current neovim configuration.

```bash
# prepare playground and alias nvim with this config to nvp
source ./scripts/playground.sh

# start a neovim instance with configs in this repo. Note: it will automaticly download the plugin manager && the plugins
nvp
```

Note: before you try the lsp related features, you can use the install scripts in scripts folder to install required lint && format tools

## real apply

```bash
# this will replace your current config with this one
./scripts/apply.sh
```
