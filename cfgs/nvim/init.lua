require("config.lazy")

vim.opt.number = true

-- remove bottom bar
vim.opt.laststatus = 0
vim.opt.cmdheight = 0

-- tab space
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.softtabstop = 3
vim.opt.expandtab = true

-- theme
vim.cmd.colorscheme("catppuccin")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

-- for obsidian
vim.opt.conceallevel = 1

-- unbinding command-line window
vim.keymap.set('n', 'q:', ':q<CR>', { noremap = true })
