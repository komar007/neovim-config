return {
  'komar007/indent-blankline.nvim',
  branch = 'yescombine',
  keys = {
    { "<F3>", ":IBLToggle<CR>" },
  },
  lazy = false,
  config = function()
    -- FIXME: Setting this (and other nvim_set_hl calls below) breaks some highlighting.
    -- For example, when CursorLine has gui=underline, the underline is interrupted where
    -- indentations are marked. Not sure whose fault it is yet.
    vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#1a1a1a' })

    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }
    local hooks = require "ibl.hooks"
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    vim.g.rainbow_delimiters = { highlight = highlight }

    require("ibl").setup {
      indent = { char = '│' },
      scope = {
        char = '│',
        show_start = false,
        show_end = false,
        highlight = highlight,
      },
    }

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end
}
