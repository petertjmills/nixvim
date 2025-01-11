{
  config = {
    extraConfigLuaPre =
      # lua
      ''
        vim.fn.sign_define("diagnosticsignerror", { text = " ", texthl = "diagnosticerror", linehl = "", numhl = "" })
        vim.fn.sign_define("diagnosticsignwarn", { text = " ", texthl = "diagnosticwarn", linehl = "", numhl = "" })
        vim.fn.sign_define("diagnosticsignhint", { text = "󰌵", texthl = "diagnostichint", linehl = "", numhl = "" })
        vim.fn.sign_define("diagnosticsigninfo", { text = " ", texthl = "diagnosticinfo", linehl = "", numhl = "" }
        -- clipboard overrides is needed as Alacritty does not support runtime OSC 52 detection.
        -- We need to customize the clipboard depending on whether in tmux, in SSH_TTY or not.
        --  In Tmux, there are 2 clipboard providers
        --  1. Tmux
        --  2. OSC52 should also work by default.
        --  In SSH_TTY, OSC 52 should work, but needs to be overridden as I use Alacritty.
        --  In local (not SSH session), LazyVim default clipboard providers can be used.
        --   Sample references -
        --   https://github.com/folke/which-key.nvim/issues/584 - Has references to when clipboard is modified
        --   Some more info here - https://www.reddit.com/r/neovim/comments/17rbbec/neovim_nightly_now_you_can_copy_via_ssh_with/
        --
        --
        --  You can test OSC 52 in terminal by using following in your terminal -
        --  printf $'\e]52;c;%s\a' "$(base64 <<<'hello world')"
        local is_tmux_session = vim.env.TERM_PROGRAM == "tmux" -- Tmux is its own clipboard provider which directly works.
        -- TMUX documentation about its clipboard - https://github.com/tmux/tmux/wiki/Clipboard#the-clipboard
        if vim.env.SSH_TTY and not is_tmux_session then
           local function paste()
             return { vim.fn.split(vim.fn.getreg(""), "\n"),       vim.fn.getregtype("") }
           end
           local osc52 = require("vim.ui.clipboard.osc52")
           vim.g.clipboard = {
             name = "OSC 52",
             copy = {
              ["+"] = osc52.copy("+"),
              ["*"] = osc52.copy("*"),
            },
            paste = {
              ["+"] = paste,
              ["*"] = paste,
            },
           }
         end
      '';

    # clipboard = {
    # providers.wl-copy.enable = true;
    # };

    opts = {
      # Show line numbers
      number = true;

      # Show relative line numbers
      relativenumber = true;

      # Use the system clipboard
      # clipboard = "unnamedplus";

      # Number of spaces that represent a <TAB>
      tabstop = 2;
      softtabstop = 2;

      # Show tabline always
      showtabline = 2;

      # Use spaces instead of tabs
      expandtab = true;

      # Enable smart indentation
      smartindent = true;

      # Number of spaces to use for each step of (auto)indent
      shiftwidth = 2;

      # Enable break indent
      breakindent = true;

      # Highlight the screen line of the cursor
      cursorline = true;

      # Minimum number of screen lines to keep above and below the cursor
      scrolloff = 8;

      # Enable mouse support
      mouse = "a";

      # Set folding method to manual
      foldmethod = "manual";

      # Disable folding by default
      foldenable = false;

      # Wrap long lines at a character in 'breakat'
      linebreak = true;

      # Disable spell checking
      spell = false;

      # Disable swap file creation
      swapfile = false;

      # Time in milliseconds to wait for a mapped sequence to complete
      timeoutlen = 300;

      # Enable 24-bit RGB color in the TUI
      termguicolors = true;

      # Don't show mode in the command line
      showmode = false;

      # Open new split below the current window
      splitbelow = true;

      # Keep the screen when splitting
      splitkeep = "screen";

      # Open new split to the right of the current window
      splitright = true;

      # Hide command line unless needed
      cmdheight = 0;

      # Remove EOB
      fillchars = {
        eob = " ";
      };
    };
  };
}
