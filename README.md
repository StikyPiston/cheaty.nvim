# Cheaty.nvim

**Cheaty.nvim** is a Neovim plugin that allows you to create a configurable pop-up cheatsheet!

## Installation

### vim.pack

```lua
vim.pack.add({
    "https://github.com/stikypiston/cheaty.nvim"
})
```

## Configuration

You can write your cheatsheet in **markdown**, to have some nice formatting.

This is the default config, tweak it to your liking:

```lua
require("cheaty").setup({
    keymap = "<leader>cs",
    width  = 0.6,
    height = 0.6,
    cheatsheet = {
        "# This is a sample cheatsheet!",
        "Tailor it to your liking in the config!"
    }
})
```
