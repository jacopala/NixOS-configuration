return {
   'saghen/blink.cmp',
   dependencies = { 'saghen/blink.lib', },
   build = function()
      require('blink.cmp').build():pwait()
   end,

   ---@module 'blink.cmp'
   ---@type blink.cmp.Config
   opts = {
      -- default, super-tab, enter, none
      keymap = { preset = 'default' },
      -- C-space: menu/docs
      -- C-n/C-p & Up/Down
      -- C-e: Hide
      -- C-k: Signature help toggle
      -- :h blink-cmp-config-keymap for customization

      completion = { 
         documentation = { auto_show = true },
         menu = {
            auto_show = true,
            auto_show_delay_ms = 500,
         }
      },
      sources = { default = { 'lsp', 'path'  } },
      fuzzy = { implementation = "rust" }
   },
}
