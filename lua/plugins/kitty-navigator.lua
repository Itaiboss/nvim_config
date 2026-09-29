return {
  "knubie/vim-kitty-navigator",
  lazy = false,
  build = "cp ./*.py ~/.config/kitty/",
  init = function()
    vim.g.kitty_navigator_no_mappings = 1
    vim.g.kitty_navigator_listening_on = "unix:/tmp/mykitty"
  end,
  keys = {
    { "<c-`>h", "<cmd>KittyNavigateLeft<cr>", silent = true },
    { "<c-`>j", "<cmd>KittyNavigateDown<cr>", silent = true },
    { "<c-`>k", "<cmd>KittyNavigateUp<cr>", silent = true },
    { "<c-`>l", "<cmd>KittyNavigateRight<cr>", silent = true },
  },
}
