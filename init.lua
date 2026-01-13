--require("core.lsp")

require("config.vim-options")
require("core.lazy")
require("config.key-maps")
vim.filetype.add({
    extension = {
        tex = "tex",
    },
})


