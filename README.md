# a well constructed neovim config

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
