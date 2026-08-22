-- yazi.nvim — the yazi terminal file manager in a floating window inside nvim.
-- Browse folders + files, create/rename/move/delete, fuzzy-jump to dirs (fd/fzf),
-- and open files straight into the editor. Requires the `yazi` binary (installed).
return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = { "folke/snacks.nvim" }, -- floating window (already in LazyVim)
  keys = {
    { "<leader>y", "<cmd>Yazi<cr>", desc = "Yazi (current file's dir)" },
    { "<leader>Y", "<cmd>Yazi cwd<cr>", desc = "Yazi (project cwd)" },
    { "<c-up>", "<cmd>Yazi toggle<cr>", desc = "Resume last Yazi session" },
  },
  opts = {
    open_for_directories = false, -- keep Snacks explorer as the default for `nvim .`
    keymaps = {
      show_help = "<f1>",
    },
  },
}
