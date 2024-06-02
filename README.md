# About
This plugins adds only one command `:Gitblame`.
This command shows git blame info about currently focused line

# Screenshot

# Installation
Lazy:
```lua
{
    "ring0-rootkit/gitblame.nvim",
    opts = {},
}
```
Also I've added simple remap to use it:
```lua
vim.keymap.set("n", "<leader>b", ":Gitblame<CR>")
```
You can install it using other plugin managers, but I'm too lazy to add instructions for them (you'll figure it out)"


# Dependencies
`git`
