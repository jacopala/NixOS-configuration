return {
   "obsidian-nvim/obsidian.nvim", version = "*",
   lazy = true,
   ft = "markdown",
   dependencies = {
      "nvim-lua/plenary.nvim",
   },
   ---@module 'obsidian'
   ---@type obsidian.config
   --picker = { name = "telescope.nvim" },
   opts = {
      legacy_commands = false, -- remove in 4.0.0
      workspaces = {
         {
            name = "local-vault",
            path = "/home/jacob/Obsidian",
         },
      },
      
      daily_notes = {
         folder = "daily",
         date_format = "%m-%d-%Y",
         default_tags = { "daily" },
         template = { "templates/Daily" },
      },
      completion = {
         min_chars = 2,
      },

      templates = {
         folder = "templates",
         date_format = "%m-%d-%Y",
         time_format = "%H:%M",
      },
      frontmatter = {
         enabled = false,
      },
   },
}
