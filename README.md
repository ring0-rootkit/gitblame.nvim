# About
This plugins adds only one command `:Gitblame`.
This command shows git blame info about currently focused line

# Screenshot
![image](https://github.com/ring0-rootkit/gitblame.nvim/assets/111735837/2cd8d6c6-4a9e-4df4-adf3-3a197af159d4)

# Installation
Lazy:
```lua
{
    "ring0-rootkit/gitblame.nvim",
    opts = {},
}
```
Also, you can add simple remap to use it:
```lua
vim.keymap.set("n", "<leader>b", ":Gitblame<CR>")
```
You can install it using other plugin managers, but I'm too lazy to add instructions for them (you'll figure it out)


# Dependencies
`git`
