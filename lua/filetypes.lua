vim.api.nvim_create_augroup("FileTypeSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.o.textwidth = 100
    vim.o.wrap = false
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_create_user_command(bufnr, "Fmt", function()
      local current_line = vim.fn.line('.')
      vim.cmd [[ %!pandoc -t gfm --columns 100 ]]
      vim.fn.cursor(current_line, 1)
      -- workaround: some plugin (likely render-markdown) sets conceallevel=2 all the time...
      vim.o.conceallevel = 0
    end, {})
  end,
  group = "FileTypeSettings",
})