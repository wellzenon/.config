local source_icons = {
  minuet = '󱗻',
  orgmode = '',
  otter = '󰼁',
  nvim_lsp = '',
  lsp = '',
  buffer = '',
  luasnip = '',
  snippets = '',
  path = '',
  git = '',
  tags = '',
  cmdline = '󰘳',
  latex_symbols = '',
  cmp_nvim_r = '󰟔',
  codeium = '󰩂',
  -- FALLBACK
  fallback = '󰜚',
}

local kind_icons = {
  -- LLM Provider icons
  claude = '󰋦',
  openai = '󱢆',
  codestral = '󱎥',
  gemini = '',
  Groq = '',
  Openrouter = '󱂇',
  Ollama = '󰳆',
  ['Llama.cpp'] = '󰳆',
  Deepseek = '',
}

return {
  {
    'milanglacier/minuet-ai.nvim',
    event = 'VimEnter',
    config = function()
      require('minuet').setup {
        provider = 'codestral',
        -- provider = 'gemini',
        -- Your configuration options here
        provider_options = {
          codestral = {
            optional = {
              max_tokens = 256,
              stop = { '\n\n' },
            },
          },
          gemini = {
            optional = {
              generationConfig = {
                maxOutputTokens = 256,
                topP = 0.9,
              },
              safetySettings = {
                {
                  category = 'HARM_CATEGORY_DANGEROUS_CONTENT',
                  threshold = 'BLOCK_NONE',
                },
                {
                  category = 'HARM_CATEGORY_HATE_SPEECH',
                  threshold = 'BLOCK_NONE',
                },
                {
                  category = 'HARM_CATEGORY_HARASSMENT',
                  threshold = 'BLOCK_NONE',
                },
                {
                  category = 'HARM_CATEGORY_SEXUALLY_EXPLICIT',
                  threshold = 'BLOCK_NONE',
                },
              },
            },
          },
        },
        blink = {
          enable_auto_complete = true,
        },
        virtualtext = {
          enabled = true,
          auto_trigger_ft = {},
          keymap = {
            -- accept whole completion
            accept = '<A-A>',
            -- accept one line
            accept_line = '<A-a>',
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            accept_n_lines = '<A-z>',
            -- Cycle to prev completion item, or manually invoke completion
            prev = '<A-[>',
            -- Cycle to next completion item, or manually invoke completion
            next = '<A-]>',
            dismiss = '<A-e>',
          },
        },
      }
    end,
  },
  { 'nvim-lua/plenary.nvim' },
  -- optional, if you are using virtual-text frontend, blink is not required.
  {
    'saghen/blink.compat',
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = '*',
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'Kaiser-Yang/blink-cmp-avante', 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = 'super-tab',
        ['<C-j>'] = { 'select_next' },
        ['<C-k>'] = { 'select_prev' },
        ['<C-e>'] = { 'cancel', 'fallback' },
        ['<C-space>'] = {
          function(cmp)
            cmp.show { providers = { 'minuet' } }
          end,
        },
      },

      completion = {
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        documentation = {
          window = {
            border = 'rounded',
          },
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = true,
          show_with_menu = true,
        },
        menu = {
          draw = {
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind' },
              { 'source_icon' },
            },
            components = {
              source_icon = {
                -- don't truncate source_icon
                ellipsis = false,
                text = function(ctx)
                  return source_icons[ctx.source_name:lower()] or source_icons.fallback
                end,
                highlight = 'BlinkCmpSource',
              },
            },
          },
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'mkdnflow', 'minuet', 'avante', 'path', 'snippets', 'buffer' },
        providers = {
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
            opts = {
              command = {
                get_kind_name = function(_)
                  return 'AvanteCmd'
                end,
              },
              mention = {
                get_kind_name = function(_)
                  return 'AvanteMention'
                end,
              },
              kind_icons = {
                AvanteCmd = '',
                AvanteMention = '',
              },
            },
          },
          minuet = {
            name = 'minuet',
            module = 'minuet.blink',
            score_offset = 50,
            async = true,
            timeout_ms = 3000,
          },
          mkdnflow = {
            module = 'blink.compat.source',
          },
        },
      },
      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'normal',
        use_nvim_cmp_as_default = true,
        kind_icons = kind_icons,
      },
      term = { enabled = false },
      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
}
