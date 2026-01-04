# Cheaty.nvim

**Cheaty.nvim** allows you to create a configurable pop-up cheatsheet!

## Installation

### vim.pack

```lua
vim.pack.add({
    "https://github.com/stikypiston/cheaty.nvim"
})
```

## Configuration

You can write your cheatsheet in **Markdown**, to have some nice formatting.

This is the default config, tweak it to your liking:

```lua
require("cheaty").setup({
    width  = 0.6,
    height = 0.6,
    cheatsheet = {
        "# This is a sample cheatsheet!",
        "Tailor it to your liking in the config!"
    }
})
```

To invoke the cheatsheet, just run `:Cheaty`
