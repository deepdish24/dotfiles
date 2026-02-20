-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Copy current file path to system clipboard
vim.keymap.set("n", "<leader>cp", function()
  local root = LazyVim.root()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", vim.fn.fnamemodify(path, ":." .. root))
end, { desc = "Copy file path (repo-relative)" })

vim.keymap.set("n", "<leader>cP", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy file path (absolute)" })

vim.keymap.set("v", "<leader>y", function()
  -- Yank visual selection to system clipboard
  vim.cmd('normal! "+y')
end, { desc = "Copy selection to clipboard" })

vim.keymap.set("n", "<leader>cn", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative line numbers" })
