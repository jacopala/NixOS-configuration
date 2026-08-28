require("config.lazy")

vim.opt.number = true
-- tab space
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.softtabstop = 3
vim.opt.expandtab = true

-- theme
vim.cmd.colorscheme("everforest")
--- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

-- for obsidian
vim.opt.conceallevel = 1

-- unbinding command-line window
vim.keymap.set('n', 'q:', ':q<CR>', { noremap = true })
