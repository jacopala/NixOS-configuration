local status, obsiain = pcall(require, "obsidian")
if not status then
    return
end

obsidian.setup({
    workspaces = {
        {
            name = "obsidian vault",
            path = "~/Obsidian/",
        },
    },
    completion = {
        nvim_cmp = true,
        min_chars = 2,
    },
})
