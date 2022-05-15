require "plugins.load"

require'nvim-treesitter.configs'.setup {

  ensure_installed = { "norg", --[[ other parsers you would wish to have ]] },
  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  ident = { enable = true },
}

require('lualine').setup {
  options = {
    theme = 'palenight',
    globalstatus = true,
  },
  sections = {
    lualine_c = { require'tabline'.tabline_buffers },
    lualine_x = {
      {
        'filename',
        file_status = true,      -- Displays file status (readonly status, modified status)
        path = 1,                -- 0: Just the filename
      }                          -- 1: Relative path
    },                            -- 2: Absolute path
  }
}

require'tabline'.setup {enable = false}

-- indent highlighting
require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
   show_current_context_start = true,
}

-- Notify
require 'notify'.setup {
   stages = 'fade'
}

-- colorscheme
require('onedark').setup {
  style = 'deep',
  transparent = true,  -- Show/hide background
  term_colors = true,
}
require('onedark').load()

require('nvim-autopairs').setup{}

require('neorg').setup {
   load = {
      ["core.defaults"] = {},
      ["core.norg.dirman"] = { -- This module is be responsible for managing directories full of .norg files.
         config = {
            workspaces = {
               work = "~/notes/work",
               home = "~/notes/home",
            }
         }
      },
      ["core.norg.qol.toc"] = {}, -- Generates a Table of Content from the Neorg file.
      ["core.norg.journal"]={}, -- Easily create files for a journal.
      ["core.gtd.base"]={}, -- Manages your tasks with Neorg using the Getting Things Done methodology.
      ["core.norg.concealer"]={}, -- Enhances the basic Neorg experience by using icons instead of text.
      ["core.norg.completion"]={}, -- A wrapper to interface with several different completion engines.
      ["core.export"]={}, -- Exports Neorg documents into any other supported filetype.
      ["core.presenter"]={}, -- Neorg module to create gorgeous presentation slides.
      ["core.norg.manoeuvre"]={} -- A Neorg module for moving around different elements up and down.
   }
}

--require'bufferline'.setup {
   --   options = {
      --      offsets = { { filetype = "NvimTree_1", text = "File Explorer", padding = 1} }, -- offsets tabline when neovim-tree opens
      --   }
      --}

--require 'tokyonight' -- tokynight config
--vim.cmd([[ colorscheme night-owl]])

-- Load custom tree-sitter grammar for org filetype
--require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
--require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
--  highlight = {
--    enable = true,
--    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
--    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
--  },
--  ensure_installed = {'org'}, -- Or run :TSUpdate org
--}

--require('orgmode').setup({
--  org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
--  org_default_notes_file = '~/Dropbox/org/refile.org',
--})
