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
    dependencies = { 'milanglacier/minuet-ai.nvim', 'Kaiser-Yang/blink-cmp-avante', 'rafamadriz/friendly-snippets' },

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
        ['<esc>'] = { 'cancel', 'fallback' },
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<A-]>'] = { 'snippet_forward', 'fallback' },
        ['<A-[>'] = { 'snippet_backward', 'fallback' },
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
        default = { 'lsp', 'minuet', 'avante', 'path', 'mkdnflow', 'snippets', 'buffer' },
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
        nerd_font_variant = 'mono',
        -- use_nvim_cmp_as_default = true,
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
