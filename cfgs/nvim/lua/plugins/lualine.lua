-- https://github.com/nvim-lualine/lualine.nvim
return {
   'nvim-lualine/lualine.nvim',
   dependencies = { 'nvim-tree/nvim-web-devicons' },
   config = function()
      local lualine = require("lualine")
      lualine.setup({
         options = {
-- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
            theme = 'everforest',
         },
      })
   end,
}
