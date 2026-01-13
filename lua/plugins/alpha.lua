return {
    "goolord/alpha-nvim",
    lazy = false, -- Load immediately so it can claim the empty buffer
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- 1. Header (Your custom ASCII art)
        -- Added more padding at the top to center it vertically
        --
        vim.api.nvim_set_hl(0, "AlphaKanagawaGreen", { fg = "#98BB6C", bold = true })
        vim.api.nvim_set_hl(0, "AlphaKanagawaBlue",  { fg = "#7E9CD8" })
        vim.api.nvim_set_hl(0, "AlphaKanagawaOrange", { fg = "#FF9E3B" }) 
dashboard.section.header.type = "group"
dashboard.section.header.val = {
  {
    type = "text",
    val = {
      "     ##### #     ##                       ##### /    ##   ###                              ",
      "  ######  /#    #### /                 ######  /  #####    ###     #                       ",
      " /#   /  / ##    ###/                 /#   /  /     #####   ###   ###                      ",
      "/    /  /  ##    # #                 /    /  ##     # ##      ##   #                       ",
      "    /  /    ##   #                       /  ###     #         ##                           ",
      "   ## ##    ##   #    /##       /###    ##   ##     #         ## ###    ######    ######   ",
      "   ## ##     ##  #   / ###     / ###  / ##   ##     #         ##  ###  /#######  /#######  ",
      "   ## ##     ##  #  /   ###   /   ###/  ##   ##     #         ##   ## /      ## /      ##  ",
      "   ## ##      ## # ##    ### ##    ##   ##   ##     #         ##   ##        /         /   ",
      "   ## ##      ## # ########  ##    ##   ##   ##     #         ##   ##       /         /    ",
      "   #  ##       ### #######   ##    ##    ##  ##     #         ##   ##      ###       ###   ",
      "      /        ### ##        ##    ##     ## #      #         /    ##       ###       ###  ",
      "  /##/          ## ####    / ##    ##      ###      /##      /     ##        ###       ### ",
      " /  #####           ######/   ######        #######/ #######/      ### /      ##        ## ",
      "/     ##             #####     ####           ####     ####         ##/       ##        ## ",
      "#                                                                             /         /  ",
      " ##                                                                          /         /   ",
      "                                                                            /         /    ",
      "                                                                           /         /     ",
    },
    opts = {
      hl = "AlphaKanagawaOrange",
      position = "center",
    },
  },
  {
    type = "text",
    val = {
      "         @@@@@@@@@@@@@                                                       ",
      "       @@+----==-::::-%@                  @%%%%%%%%%%%%                      ",
      "       @@#####*+===---===@              %%-====+++++++*%%%%                  ",
      "       %@@@@@@#**++=--::=%%             %%::::--===-=-*%%%%%                 ",
      "              @@%*+=-----:-%%@         @%%-----:::::-=--=--=%%%%%            ",
      "              @@%*++++---:-**#@@@@@    #**--. ......:::::-=-=-==+%%%%@       ",
      "              #%#++*++===--==*%#*++%@  #**--. .........::-------=**#%%        ",
      "            %%%***++++++=----=**--*%#  #**--..      . ...:::::---==#%%%%%%%  ",
      "          @%*+*#*=+++=-----**+---=-::: ***::         . .....::::-+*#%#===-=%%",
      "        @*+++*++*##*#####**=---=::+@@@ **+::.     ..     ...::=*++*%%#**+**%%",
      "       @@*+++++++****+=+=+=-----+**@@  **+...       . . .  .::++**+#%#+*+**%%",
      "       @%*++++++++++++--------::%@%    ++*... .   . .  .  . ::=+++*#%%+*++*%%",
      "         @@%*+*++++=-----:-#@%**       *++:..  .     .  . . ::=++*+#%%+++**%%",
      "          %%%%%%%%%%%%%%%##--:  ***    **+...   . . . .  . .::+++**#%#**++*%%",
      "          @%%%%%%#####*****-:.  ===    *++:: .. .  .  . .  .::=++**#%#++*+*%%",
      "         @@%#*++=:::..       :=+       ***:::... . . . . .  ::+++*+#%%+++**%%",
      "       @@+==**%@@@@@@%==-..     +=+  **-  *++++-:.::..   . ..:=*++*#%#*+++*%%",
      "     @%==+**====+#*+==***##:.   ==+**-:-=-**.  -++++:..:.. .-:+**++#%%+*#%%  ",
      "    @@%==***+====**+=+**###--.  ===+=-----++.  -++++----:   --+++*+#%%**#%%  ",
      "    @@%==********=-+**++-::#@+..+=.  =*=..::-++===--+++++---:-+*++*%%%%%%    ",
      "    -====+****+==***++-----::=@@****+-.-****:. .:-++++++*%%%%%%%%%%***%%%    ",
      "    =-=-=========****+----------%%%%%##*:-  -==...-:=+*%#**********#%%@      ",
      "  #%*============***++===-----:-#######*--  -*+:. ::--+##**********#%%       ",
      "@%#****==-==-====***+*@@#----------::::-@@--=**-----...:-#%%++%%%%%          ",
      "@%#*+==**+===-+*#++*+*@@#*+=----------:-@@**=--::...++++*%%%                 ",
      "@%+++++**==-==+***+++*#####+==---------=%@--=*+=--=-*####%%                  ",
      "@#==+****=====+***++*+++#@%*++---------=@@  @%%*+*%@%%%%%                    ",
      "  ***#******==+*#@@#++++++*%@@@@@@#+*%@@                                     ",
    },
    opts = {
      hl = "AlphaKanagawaGreen",
      position = "center",
    },
  },
}
               dashboard.section.buttons.val = {
            dashboard.button("f", "󰈞  Find File", ":Telescope find_files<CR>"),
            dashboard.button("r", "󰄉  Recent Files", ":Telescope oldfiles<CR>"),
            dashboard.button("g", "󰱽  Find Text", ":Telescope live_grep<CR>"),
            dashboard.button("c", "󰒓  Config", ":e $MYVIMRC<CR>"),
            dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
        }


        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaKanagawaBlue"
        end
        -- 3. Footer (Auto-detect Neovim version)
        local v = vim.version()
        dashboard.section.footer.val = string.format("󰚀  NVIM v%d.%d.%d", v.major, v.minor, v.patch)
        dashboard.section.footer.opts.hl = "Type"
        -- 4. Styling
        --dashboard.section.header.opts.hl = "String"
        --dashboard.section.footer.opts.hl = "Type"

        -- Use the dashboard opts
        alpha.setup(dashboard.opts)
    end,
}
