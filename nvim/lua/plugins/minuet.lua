return {
  {
    'milanglacier/minuet-ai.nvim',
    event = 'VimEnter',
    config = function()
      local minuet = require 'minuet'
      minuet.setup {
        -- provider = 'codestral',
        provider = 'gemini',
        -- Your configuration options here
        provider_options = {
          codestral = {
            optional = {
              max_tokens = 256,
              stop = { '\n\n' },
            },
          },
          gemini = {
            model = 'gemini-2.0-flash-thinking-exp-01-21',
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
        cmp = {
          enable_auto_complete = false,
        },
        blink = {
          enable_auto_complete = false,
        },
        virtualtext = {
          enabled = false,
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
        completion = { trigger = { prefetch_on_insert = false } },
      }
    end,
  },
  { 'nvim-lua/plenary.nvim' },
}
