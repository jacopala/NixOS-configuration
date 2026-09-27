return {
    '2kabhishek/nerdy.nvim',
    dependencies = {
        'folke/snacks.nvim',
    },
    cmd = 'Nerdy',
    opts = {
        max_recents = 10,
        copy_to_clipboard = false,
        copy_register = '+', -- Register to use for copying (if `copy_to_clipboard` is true)
    },
    keys = {
        { '<leader>in', '<cmd>Nerdy list<CR>', desc = "Browse nerd icons" },
        { '<leader>iN', '<cmd>Nerdy recents<CR>', desc = "Browse recent nerd icons" },
    },
}
