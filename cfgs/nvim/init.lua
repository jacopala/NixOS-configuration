require("config.lazy")

vim.lsp.enable({"lua_ls", "ts_ls", "rust_analyzer"})

vim.opt.number = true
-- tab space
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.softtabstop = 3
vim.opt.scrolloff = 3
vim.opt.expandtab = true
vim.opt.linebreak = true

-- theme
vim.cmd.colorscheme("everforest")
-- no background color
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

-- for obsidian
vim.opt.conceallevel = 1

-- unbinding command-line window
vim.keymap.set('n', 'q:', ':q<CR>', { noremap = true })
