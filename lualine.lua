local colors = {
  black    = '#111111',
  bg_outer = '#3a3430',
  bg_mid   = '#2a2420',
  bg_inner = '#1d2021',
  fg       = '#bbc2cf',
  darkfg   = '#6b727f',
  green    = '#98be65',
  green_i  = '#587e45',
  orange   = '#fe8019',
  violet   = '#8981c1',
  marine   = '#318fcf',
  red      = '#fb4934',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local theme = {
  normal = {
    a = { fg = colors.fg, bg = colors.bg_outer },
    b = { fg = colors.fg, bg = colors.bg_mid },
    c = { fg = colors.darkfg, bg = colors.bg_inner },
    x = { fg = colors.darkfg, bg = colors.bg_inner },
    y = { fg = colors.darkfg, bg = colors.bg_mid },
    z = { fg = colors.darkfg, bg = colors.bg_outer },
  },
  insert = { c = { fg = colors.black, bg = colors.green_i } },
  visual = { c = { fg = colors.black, bg = colors.marine } },
  replace = { c = { fg = colors.black, bg = colors.violet } },
}

local function search_result()
  if vim.v.hlsearch == 0 then
    return ''
  end
  local last_search = vim.fn.getreg('/')
  if not last_search or last_search == '' then
    return ''
  end
  local searchcount = vim.fn.searchcount { maxcount = 9999 }
  return ' ' .. last_search .. ' (' .. searchcount.current .. '/' .. searchcount.total .. ')'
end

-- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#changing-filename-color-based-on--modified-status (modified)
local colored_filename = require('lualine.components.filename'):extend()
local highlight = require'lualine.highlight'
local default_status_colors = { modified = '#d75f5f' }

function colored_filename:init(options)
  colored_filename.super.init(self, options)
  self.status_colors = {
    saved = highlight.create_component_highlight_group(
      {}, 'filename_status_saved', self.options),
    modified = highlight.create_component_highlight_group(
      {fg = default_status_colors.modified}, 'filename_status_modified', self.options),
  }
  if self.options.color == nil then self.options.color = '' end
end

function colored_filename:update_status()
  local data = colored_filename.super.update_status(self)
  data = highlight.component_format_highlight(vim.bo.modified
                                              and self.status_colors.modified
                                              or self.status_colors.saved) .. data
  return data
end
-- // https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#changing-filename-color-based-on--modified-status

require('lualine').setup {
  options = {
    theme = theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      {
        'branch',
        icon = '⎇',
      },
      {
        'diff',
        symbols = { added = ' ', modified = '󱗜 ', removed = ' ' },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
        on_click = function(n, but, mod)
          if but == 'l' then
            vim.api.nvim_command('GitGutterNextHunk')
          elseif but == 'r' then
            vim.api.nvim_command('GitGutterPrevHunk')
          end
        end,
      },
    },
    lualine_b = {
      {
        colored_filename,
        file_status = true,
        path = 1,
      },
      {
        '%w',
        cond = function()
          return vim.wo.previewwindow
        end,
      },
      {
        '%q',
        cond = function()
          return vim.bo.buftype == 'quickfix'
        end,
      },
    },
    lualine_c = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = '󰧞 ', warn = '󰧞 ', info = '󰧞 ', hint='󰧞 ' },
        diagnostics_color = {
          -- TODO: extract the colors below, they should be the same as those used in respective diagnostics
          error = { fg = '#d75f5f' },
          warn = { fg = '#ca8462' },
          info = { fg = '#83a598' },
        },
        on_click = function(n, but, mod)
          if but == 'l' then
            vim.diagnostic.goto_next();
          elseif but == 'r' then
            vim.diagnostic.goto_prev();
          end
        end,
      },
    },
    lualine_x = {
      {
        search_result,
      },
    },
    lualine_y = {
      {
        'filetype',
      },
      {
        'o:encoding',
        cond = conditions.hide_in_width,
        padding = 0,
      },
      {
        'fileformat',
        icons_enabled = true,
        cond = conditions.hide_in_width,
        padding = 1,
      },
    },
    lualine_z = {
      {
        '%p%%/%L',
      },
      {
        '%l:%c',
        color = { fg = colors.fg },
      }
    },
  },
  inactive_sections = {
  },
}
