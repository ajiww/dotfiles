-- ============================================================================
-- SYSTEM & GENERAL OPTIONS
-- Dependencies: Neovim 0.9.5, Neovim 0.11.6
-- ============================================================================

-- Set map for Leader (to Space ' ') and LocalLeader (to backslash '\')
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set built-in colorscheme (Options: habamax, slate, desert)
vim.cmd.colorscheme("desert")

-- Sync Neovim clipboard with system clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable 24-bit RGB colors in terminal
vim.opt.termguicolors = true

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Prevent words from cutting in half at window borders
vim.opt.wrap = true         -- Enable line wrapping
vim.opt.linebreak = true    -- Wrap long lines at word boundaries (don't break words)
vim.opt.breakindent = true  -- Match visual wrap indent with code line indent
vim.opt.showbreak = "↪ "    -- Visual indicator for wrapped lines at beginning

-- Tab and indentation standard
vim.opt.tabstop = 4         -- Number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 4     -- Number of spaces that a <Tab> counts for while editing
vim.opt.shiftwidth = 4      -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true    -- Convert tabs to spaces

-- Use 2 spaces for web-related files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "css", "json", "yaml" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

-- Move up & down naturally across visually wrapped lines
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Move down by visual line" })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move up by visual line" })

-- Global TeX concealment rule (accents, bold, math symbols, Greek letters)
vim.g.tex_conceal = "abdmg"

-- ============================================================================
-- 1. BOOTSTRAP LAZY.NVIM (Plugin Manager)
-- Dependencies: git
-- ============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

--if not vim.loop.fs_stat(lazypath) then -- Comment this is for Neovim 0.9.5
if not (vim.uv or vim.loop).fs_stat(lazypath) then -- Comment this is for Neovim 0.11.6
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- 2. PLUGIN CONFIGURATIONS
-- Dependencies: Neovim 0.9.5, Neovim 0.11.6, lazy.nvim, latexmk, evince
-- ============================================================================
require("lazy").setup({

    -- Tree-sitter syntax highlighting & parser management for Neovim 0.11.6
    {
        "nvim-treesitter/nvim-treesitter",
        tag = "v0.10.0", -- Last major tagged before 0.12 requirements
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                -- Automatically install missing parsers when entering buffer
                auto_install = true,
                ensure_installed = { "lua", "vim", "vimdoc", "markdown" },
                highlight = {
                    enable = true,
                },
            })
        end,
    },

    -- Telescope, find file with fuzzy search
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local telescope = require("telescope")
            
            -- Simple default setup - no custom preview handlers
            telescope.setup({
                defaults = {
                    previewer = true,
                },
            })
        end,
    },

    -- Telescope media file extension (handles image preview)
    {
        "nvim-telescope/telescope-media-files.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("telescope").load_extension("media_files")
        end,
    },

    -- Color Code Highlighting (#HEX, rgb, hsl)
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({
            render = "background",
            enable_hex = true,	-- Highlights #fffaaa, #f001ee
            enable_short_hex = true,-- Highlights #fff, #f00
            enable_rgb = true,	-- Highlights rgb(255, 0, 255)
            enable_hsl = true,	-- Highlights hsl(0, 100%, 50%)
            enable_var = true,	-- Highlights var(--main-color)
            enable_tailwind = true,	-- Highlights bg-red-500, text-blue-400
        })

        vim.cmd("HighlightColors On")
        end,
    },

    -- VimTeX Setup
    {
        "lervag/vimtex",
        version = "v2.15", -- Pin to last release supporting Neovim < 0.10
        lazy = false, -- Load on startup for filetype detection
        init = function()

            -- Set latexmk as the default compilation engine
            vim.g.vimtex_compiler_method = "latexmk"

            -- Configure latexmk options
            vim.g.vimtex_compiler_latexmk = {
                build_dir = "",
                callback = 1,
                continuous = 1,
                executable = "latexmk",
                hooks = {},
                options = {
                    "-verbose",
                    "-file-line-error",
                    "-synctex=1",
                    "-interaction=nonstopmode",
                },
            }

            -- PDF viewer configuration
            vim.g.vimtex_view_method = "general"
            vim.g.vimtex_view_general_viewer = "evince"
            vim.g.vimtex_view_general_options = "@pdf"

        end,

        --|--------------------------------------|
        --| Default VimTeX Local keymap          |
        --|--------------------------------------|
        --| Key   | Action                       |
        --|-------|------------------------------|
        --| `\ll` | Start/stop compilation       |
        --| `\lv` | View PDF                     |
        --| `\lc` | Clean auxiliary files        |
        --| `\lo` | Show compiler output         |
        --| `\lk` | Stop compilation             |
        --| `\lt` | Toggle table of contents     |
        --| `\li` | Show commands used by VimTeX |
        --|--------------------------------------|
    },

})

-- ============================================================================
-- 2.5 TELESCOPE KEYBINDINGS
-- ============================================================================

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", {
    desc = "Find Files",
})
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", {
    desc = "Live Grep",
})
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", {
    desc = "Find Buffers",
})
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", {
    desc = "Help Tags",
})

-- ============================================================================
-- 3. LATEX SETTING
-- Dependencies: lervag/vimtex
-- ============================================================================

-- Do something when VimtexEventInitPost is detected
vim.api.nvim_create_autocmd("User", {
    pattern = "VimtexEventInitPost",
    callback = function()
	    -- Auto detect main.tex as root
	    if vim.fn.filereadable("main.tex") == 1 then
		    vim.b.vimtex_main = "main.tex"
      	end
    end,
})

-- LaTeX custom styling
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "tex", "latex" },
	callback = function()
		-- Enable conceallevel ONLY for TeX files
		vim.opt.conceallevel = 2
	end,
})

-- ============================================================================
-- 4. MARKDOWN SETTING
-- Dependencies: latexmk, pandoc
-- ============================================================================

-- Compile markdown file into PDF presentation
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()

        local opts = { buffer = true, silent = true, noremap = true }

        -- Press <leader>tp in a .md file to compile to presentation PDF
        vim.keymap.set("n", "<leader>tp", function()
            local file = vim.api.nvim_buf_get_name(0)
            local pdf = file:gsub("%.md$", ".pdf")

            -- Save buffer
            vim.cmd("write")
            print("Compiling " .. vim.fn.expand("%:t") .. " to Beamer PDF...")

            -- Run Pandoc with Beamer output
            vim.fn.jobstart({ "pandoc", file, "-t", "beamer", "-o", pdf, "--pdf-engine=latexmk" }, {
                on_exit = function(_, code)
                if code == 0 then
                    print("Successfully generated presentation: " .. vim.fn.expand("%:t:r") .. ".pdf")
                else
                    print("Beamer compilation failed. Check LaTeX installation.")
                end
            end,
        })
        end, opts)

    end,
})
