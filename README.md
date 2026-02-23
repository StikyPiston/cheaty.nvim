# Cheaty.nvim

**Cheaty.nvim** allows you to create a configurable pop-up cheatsheet!

---

## Installation

### vim.pack

```lua
vim.pack.add({
    "https://github.com/stikypiston/cheaty.nvim"
})
```

### lazy.nvim

```lua
{
    "stikypiston/cheaty.nvim",
    opts = {},
}
```

---

## Configuration

You can write your cheatsheet in **Markdown**, to have some nice formatting.

This is the default config, tweak it to your liking:

```lua
require("cheaty").setup({
    width  = 0.6,
    height = 0.6,
    save_file = vim.fs.joinpath(vim.fn.stdpath("data"), "cheaty.md"),
    cheatsheet = {
        "# This is a sample cheatsheet!",
        "Customise it by editing *this buffer* (just press `i`)",
        "Or in the `cheatsheet` section of the config!"
    }
})
```

To invoke the cheatsheet, just run `:Cheaty`.
