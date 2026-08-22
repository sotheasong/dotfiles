-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Explorer rooted like VSCode: the current file's git/project root, or its own
-- folder if there's no project — never the whole of ~ (LazyVim's cwd fallback).
vim.keymap.set("n", "<leader>e", function()
  local file = vim.api.nvim_buf_get_name(0)
  local dir = (file ~= "") and vim.fs.dirname(file) or (vim.uv or vim.loop).cwd()
  local root = vim.fs.root(dir, {
    ".git", ".hg", "package.json", "pyproject.toml", "Cargo.toml", "go.mod", "Makefile",
  }) or dir
  Snacks.explorer({ cwd = root })
end, { desc = "Explorer (project / file dir)" })
