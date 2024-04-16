local M = {}

-- from https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#changing-filename-color-based-on--modified-status (modified)

M.colored_filename = require('lualine.components.filename'):extend()
local highlight = require('lualine.highlight')

function M.colored_filename:init(options)
  M.colored_filename.super.init(self, options)
  self.status_colors = {
    saved = highlight.create_component_highlight_group(
      {}, 'filename_status_saved', self.options),
    modified = highlight.create_component_highlight_group(
      { fg = '#d75f5f' }, 'filename_status_modified', self.options),
    readonly = highlight.create_component_highlight_group(
      { fg = 'black', bg = '#a76f6f' }, 'filename_status_readonly', self.options),
  }
  if self.options.color == nil then self.options.color = '' end
end

function M.colored_filename:update_status()
  local data = M.colored_filename.super.update_status(self)
  data = highlight.component_format_highlight(vim.bo.modified
    and self.status_colors.modified
    or (vim.bo.readonly and self.status_colors.readonly or self.status_colors.saved)) .. data
  return data
end

return M
