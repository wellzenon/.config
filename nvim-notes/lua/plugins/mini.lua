return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Save sessions
      require('mini.sessions').setup { autoread = true, autowrite = true }
      require('mini.icons').setup {}

      -- Git info
      -- require('mini.git').setup {}

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup {
        use_icons = vim.g.have_nerd_font,
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 1200 }
            local git = MiniStatusline.section_git { trunc_width = 40 }
            local diff = MiniStatusline.section_diff { trunc_width = 75 }
            local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
            local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
            local filename = MiniStatusline.section_filename { trunc_width = 150 }
            -- local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location = MiniStatusline.section_location { trunc_width = 75 }
            local search = MiniStatusline.section_searchcount { trunc_width = 75 }

            return MiniStatusline.combine_groups {
              { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineFilename', strings = { git, diff, diagnostics, lsp } },
              -- { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl, strings = { search, location } },
            }
          end,
        },
      }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_filename = function()
        local full_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':~:.')
        local filename = vim.fn.fnamemodify(full_path, ':t')
        local dir = vim.fn.fnamemodify(full_path, ':h')

        local ok, mini_icons = pcall(require, 'mini.icons')
        local file_icon = ok and mini_icons and mini_icons.get('file', full_path) or ''
        local folder_icon = ok and mini_icons and mini_icons.get('directory', dir) or ''

        local navic_location = ''
        local ok_navic, navic = pcall(require, 'nvim-navic')
        if ok_navic and navic.is_available() then
          navic_location = ' ' .. navic.get_location()
        end

        if dir and dir ~= '.' then
          return '%#NavicIconsFolder#'
            .. folder_icon
            .. ' '
            .. '%#Conceal#'
            .. '%<'
            .. dir
            .. '%>'
            .. '/ '
            .. '%#NavicIconsFile#'
            .. file_icon
            .. ' '
            .. '%#MiniTestEmphasis#'
            .. filename
            .. '%*'
            .. navic_location
        else
          return '%#NavicIconsFile#' .. file_icon .. ' ' .. '%#MiniTestEmphasis#' .. filename .. '%*' .. navic_location
        end
      end
      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        local current_line = vim.api.nvim_win_get_cursor(0)[1]
        local total_lines = vim.api.nvim_buf_line_count(0)

        if current_line == 1 then
          return 'TOP'
        elseif current_line == total_lines then
          return 'BOT'
        else
          local percent = math.floor((current_line / total_lines) * 100)
          return string.format('%02d%%', percent) .. '%'
        end
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
