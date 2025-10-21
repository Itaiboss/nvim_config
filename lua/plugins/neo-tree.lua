return {
  "nvim-tree/nvim-tree.lua",
  version = "*", -- optional, can pin to latest stable
  lazy = false,  -- load on startup (set true to lazy-load)
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- for icons
  config = function()
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 30,
        side = "left",
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
    })

    -- optional keybinds
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
  end,
}
