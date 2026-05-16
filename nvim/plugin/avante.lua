vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/HakonHarnes/img-clip.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

vim.pack.add({
  { src = "https://github.com/yetone/avante.nvim", build = "make" },
})

require("img-clip").setup({
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
})

require("avante").setup({
  provider = "gemini-cli",
  providers = {
    gemini = {
      model = "gemini-2.5-flash-lite",
      timeout = 30000, -- timeout in milliseconds
      temperature = 0, -- adjust if needed
      max_tokens = 1048576,
    },
    ["gemini 2.5 Pro"] = {
      __inherited_from = "gemini",
      model = "gemini-2.5-pro",
      max_tokens = 1048576,
    },
    ["gemini 2.5 Flash"] = {
      model = "gemini-2.5-flash",
      __inherited_from = "gemini",
      max_tokens = 1048576,
    },
    ["gemini 2.5 Live"] = {
      __inherited_from = "gemini",
      model = "gemini-live-2.5-flash-preview",
      max_tokens = 1048576,
    },
    mistral = {
      __inherited_from = "openai",
      api_key_name = "MISTRAL_API_KEY",
      endpoint = "https://api.mistral.ai/v1/",
      model = "mistral-large-latest",
      extra_request_body = {
        max_tokens = 4096, -- to avoid using max_completion_tokens
      },
    },
    groq = {
      __inherited_from = "openai",
      api_key_name = "GROQ_API_KEY",
      endpoint = "https://api.groq.com/openai/v1/",
      model = "llama-3.3-70b-versatile",
      extra_request_body = {
        max_completion_tokens = 32768,
      },
    },
    morph = {
      model = "morph-v3-large",
    },
  },
  acp_providers = {
    ["gemini-cli"] = {
      command = "gemini",
      args = {
        "--acp",
        "-m gemini-2.5-flash-lite",
      },
      env = {
        NODE_NO_WARNINGS = "1",
        GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
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
    enable_fastapply = true, -- Enable Fast Apply feature
    mappings = {
      sidebar = {
        close_from_input = { normal = "<Esc>" },
      },
    },
  },
  windows = {
    width = 40,
    sidebar_header = {
      enabled = true,
      rounded = false,
      align = "center",
    },
    edit = {
      border = "rounded",
    },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "avante", "AvanteInput" },
  callback = function()
    vim.schedule(function()
      vim.api.nvim_set_hl(0, "AvanteSidebarWinSeparator", { link = "WinSeparator" })
      vim.api.nvim_set_hl(0, "AvanteSidebarHorizontalWinSeparator", { link = "WinSeparator" })
    end)
  end,
})
