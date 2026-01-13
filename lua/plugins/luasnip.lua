return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
        local ls = require("luasnip")

        ls.config.set_config({
            history = true,
            -- Update snippets as you type (useful for dynamic math)
            updateevents = "TextChanged,TextChangedI",
            -- Enable auto-trigger snippets
            enable_autosnippets = true,
        })

        -- KEYMAPS
        -- Expand or jump forward
        vim.keymap.set({"i", "s"}, "<Tab>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            else
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
            end
        end, {silent = true})

        -- Jump backward
        vim.keymap.set({"i", "s"}, "<S-Tab>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, {silent = true})

        -- Load custom snippets from a specific folder
       require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snippets" })

    end,
}
