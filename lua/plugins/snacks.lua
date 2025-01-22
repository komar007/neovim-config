return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    styles = {
      float = {
        wo = {
          winblend = 15,
        },
      },
      input = {
        relative = "cursor",
        row = 1,
        title_pos = "left",
      },
    },
    input = {
    },
    scroll = {
      animate = {
        duration = { step = 20, total = 200 },
        easing = "inOutExpo",
      },
    },
    picker = {
      win = {
        input = {
          keys = {
            ["<c-b>"] = { "" },
            ["<c-f>"] = { "" },
            ["<c-a>"] = { "" },
            ["<c-e>"] = { "" },
            ["<c-d>"] = { "" },
            ["<c-u>"] = { "" },
          },
        },
      },
      layout = function()
        return {
          cycle = true,
          fullscreen = true,
          preset = vim.o.lines >= 70 and "vertical" or "default",
        }
      end,
    },
  },
  keys = {
    { "<C-p>",         ":lua Snacks.picker.buffers()<CR>" },
    { "<Leader><C-p>", ":lua Snacks.picker.files()<CR>" },
    { "<Leader>*",     ":lua Snacks.picker.grep_word()<CR>" },
    { "<Leader>/",     ":lua Snacks.picker.grep()<CR>" },
  }
}
