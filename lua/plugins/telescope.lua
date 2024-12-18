return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build =
      'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
    }
  },
  keys = {
    { "<C-p>",         ":lua Telescope_buffers()<CR>" },
    { "<Leader><C-p>", ":lua Telescope_findfiles()<CR>" },
    { "<Leader>*",     ":lua Telescope_grep_string()<CR>" },
    { "<Leader>/",     ":lua Telescope_live_grep()<CR>" },
  },
  config = function()
    local telescope = require('telescope')
    local themes = require('telescope.themes')

    telescope.setup {
      defaults = {
        path_display = { "truncate" },
        mappings = {
          n = {
            ['<c-d>'] = require('telescope.actions').delete_buffer
          },
          i = {
            ['<c-d>'] = require('telescope.actions').delete_buffer
          },
        },
      },
      extensions = {
      }
    }

    telescope.load_extension('fzf')

    require('dressing').setup({
      input = {
        prompt_align = "left",
        override = function(conf)
          conf.anchor = "NW";
          return conf
        end,
      },
      select = {
        telescope = themes.get_cursor(),
      },
    })

    local function fullscreen_theme()
      return themes.get_ivy({
        layout_config = {
          height = 10000,
          width = 10000,
        },
      })
    end

    local function fullscreen_horizontal_theme()
      return themes.get_ivy({
        layout_config = {
          height = 10000,
          width = 10000,
        },
        layout_strategy = 'vertical',
      })
    end

    Telescope_findfiles = function()
      require('telescope.builtin').find_files(fullscreen_theme())
    end
    Telescope_buffers = function()
      local theme = fullscreen_theme()
      theme.sort_mru = true
      require('telescope.builtin').buffers(theme)
    end
    Telescope_references = function()
      require('telescope.builtin').lsp_references(fullscreen_horizontal_theme())
    end
    Telescope_implementations = function()
      require('telescope.builtin').lsp_implementations(fullscreen_horizontal_theme())
    end
    Telescope_grep_string = function()
      require('telescope.builtin').grep_string(fullscreen_horizontal_theme())
    end
    Telescope_live_grep = function()
      require('telescope.builtin').live_grep(fullscreen_horizontal_theme())
    end
    Telescope_definitions = function()
      require('telescope.builtin').lsp_definitions(fullscreen_horizontal_theme())
    end
    Telescope_type_definitions = function()
      require('telescope.builtin').lsp_type_definitions(fullscreen_horizontal_theme())
    end
  end,
}
