return {
  "R-nvim/R.nvim",
  lazy = false,
  config = function()
    require("r").setup({
      R_args = { "--quiet", "--no-save" },
      hook = {
        on_filetype = function()
          vim.keymap.set("n", "<Enter>", "<Plug>RDSendLine", { buffer = true })
          vim.keymap.set("v", "<Enter>", "<Plug>RSendSelection", { buffer = true })
        end,
      },
    })
  end,
}
