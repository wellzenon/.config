return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {
    provider = 'gemini',
    providers = {
      gemini = {
        model = 'gemini-2.5-flash-preview-04-17',
        timeout = 30000, -- timeout in milliseconds
        temperature = 0, -- adjust if needed
        max_tokens = 1048576,
      },
      ['gemini 2.5 PP'] = {
        __inherited_from = 'gemini',
        model = 'gemini-2.5-pro-exp-03-25',
        max_tokens = 1048576,
      },
      ['gemini 2.0 F'] = {
        model = 'gemini-2.0-flash',
        __inherited_from = 'gemini',
        max_tokens = 1048576,
      },
      ['gemini 2.0 FT'] = {
        __inherited_from = 'gemini',
        model = 'gemini-2.0-flash-thinking-exp-01-21',
        max_tokens = 1048576,
      },
      mistral = {
        __inherited_from = 'openai',
        api_key_name = 'MISTRAL_API_KEY',
        endpoint = 'https://api.mistral.ai/v1/',
        model = 'mistral-large-latest',
        max_tokens = 4096, -- to avoid using max_completion_tokens
      },
      groq = {
        __inherited_from = 'openai',
        api_key_name = 'GROQ_API_KEY',
        endpoint = 'https://api.groq.com/openai/v1/',
        model = 'llama-3.3-70b-versatile',
        extra_request_body = {
          max_completion_tokens = 32768,
        },
      },
    },
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
      enable_cursor_planning_mode = true,
      mappings = {
        sidebar = {
          close_from_input = { normal = '<Esc>' },
        },
      },
    },
    windows = {
      width = 40,
      sidebar_header = {
        -- enabled = false,
        rounded = false,
        align = 'center',
      },
    },
  },
  build = 'make', -- if you want to build from source then do make BUILD_FROM_SOURCE=true
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'echasnovski/mini.nvim', -- autocompletion for avante commands and mentions
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          verbose = false,
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
