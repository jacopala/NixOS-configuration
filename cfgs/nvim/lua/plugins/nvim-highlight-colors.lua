-- https://github.com/brenoprata10/nvim-highlight-colors
return {
   'brenoprata10/nvim-highlight-colors',

   config = function()
      local nvimhlcolors= require("nvim-highlight-colors")
      nvimhlcolors.setup({
         render = 'background'
      })
   end,
}
