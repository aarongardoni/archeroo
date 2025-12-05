return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = {},
      },

      -- Document existing key chains
      spec = {
        { '<leader>f', group = '[F]ind' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>l', group = '[L]azy' },
        { '<leader>b', group = '[B]uffer' },
      },
    },
  },
}
