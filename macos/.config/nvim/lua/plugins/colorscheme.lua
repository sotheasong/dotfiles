-- Ayu Dark — matches the Ghostty ayu-dark theme
return {
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000, -- load before other UI plugins
    main = "ayu", -- module is `ayu`, not `neovim-ayu` (fixes "Lua module not found")
    opts = {
      mirage = false, -- false = ayu-dark (bg #0b0e14), true = ayu-mirage
      overrides = {}, -- solid background (Ghostty stays transparent; nvim does not)
    },
  },
  -- Tell LazyVim to use it as the active colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ayu-dark",
    },
  },
}
