-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
vim.keymap.set("n", "<C-/>", function()
  LazyVim.terminal(nil, { border = "rounded" })
end, { desc = "Term with border" })

-- vim.keymap.set("n", "<leader>r", LazyVim.ui.bufremove, { desc = "Close buffer" })
