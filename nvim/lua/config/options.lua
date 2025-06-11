-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

vim.g.lazyvim_check_order = false
vim.opt.cursorline = false
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff5f87", bold = true })
