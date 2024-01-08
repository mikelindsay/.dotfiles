    require("auto-session").setup {
      log_level = "error",
    }
local harpoon = require("harpoon")
harpoon:setup({})

vim.keymap.set( "n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set( "n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set( "n", "<M-6>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set( "n", "<M-0>", function() harpoon:list():select(1) end)
vim.keymap.set( "n", "<M-9>", function() harpoon:list():select(2) end)
vim.keymap.set( "n", "<M-8>", function() harpoon:list():select(3) end)
vim.keymap.set( "n", "<M-7>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set( "n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set( "n", "<C-S-N>", function() harpoon:list():next() end)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
require("mason").setup()


require("mason-lspconfig").setup {
    ensure_installed = {"lua_ls", "powershell_es"}
}

require("lualine").setup(
    {
        options = {
            icons_enabled = false,
            theme = "onedark"
        }
    }
)

local lspconfig = require("lspconfig")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Set up nvim-cmp.
local cmp = require "cmp"
local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup(
    {
        experimental = {ghost_text = false},
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
        },
        mapping = cmp.mapping.preset.insert(
            {
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                --          ["<CR>"] = vim.schedule_wrap(function(fallback)
                --      if cmp.visible() and has_words_before() then
                --        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                --      else
                --        fallback()
                --      end
                --    end),
            }
        ),
        sources = cmp.config.sources(
            {
 --               {name = "copilot"},
                {name = "nvim_lsp"},
                {name = "vsnip"} -- For vsnip users.
                -- { name = 'luasnip' }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
            },
            {
                {name = "buffer"}
            }
        )
    }
)

-- Set configuration for specific filetype.
cmp.setup.filetype(
    "gitcommit",
    {
        sources = cmp.config.sources(
            {
                {name = "git"} -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            },
            {
                {name = "buffer"}
            }
        )
    }
)

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    {"/", "?"},
    {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            {name = "buffer"}
        }
    }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    ":",
    {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
            {
                {name = "path"}
            },
            {
                {name = "cmdline"}
            }
        )
    }
)

-- Set up lspconfig.
lspconfig.lua_ls.setup(
    {
        capabilities = lsp_capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = {"vim"}
                }
            }
        }
    }
)

lspconfig.powershell_es.setup(
    {
        capabilities = lsp_capabilities
    }
)

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        -- delay update diagnostics
        update_in_insert = true
    }
)

