return {
  "obsidian-nvim/obsidian.nvim", version = "*",
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
  },
}
