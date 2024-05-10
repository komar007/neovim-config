local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

require("diagnostics")

local utils = require("utils")

utils.autocmd_all({ "BufEnter" }, [[ let &titlestring = "nvim - " . expand("%:t") ]])
vim.opt.title = true

-- look and feel
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.wildmenu = true
vim.opt.wildmode = "longest,list,list,full"
vim.opt.mouse = "a"
vim.opt.mousemodel = "extend"
vim.opt.timeoutlen = 500
vim.opt.updatetime = 500
vim.opt.inccommand = "split"
vim.opt.scrolloff = 8
vim.opt.relativenumber = true

vim.keymap.set('n', '<F2>', function() vim.o.cursorcolumn = not vim.o.cursorcolumn end, { expr = true })
vim.keymap.set('n', '<F3>', ':IBLToggle<cr>')

-- A little bit of emacs can't be too sacrilegious... right?
--
-- These are mainly for telescope/dressing, whic use insert mode for user input.
-- It's kind of hard for my brain to distinguish it from typing in shell, so I need some basic readline shortcuts.
-- Command line is handled by ryvnf/readline.vim.
vim.keymap.set('i', '<C-a>', '<C-o>^')
vim.keymap.set('i', '<C-e>', '<C-o>$')
vim.keymap.set('i', '<C-b>', '<C-o>h')
vim.keymap.set('i', '<C-f>', '<C-o>l')

vim.cmd 'source ~/.config/nvim/legacy.vim'
