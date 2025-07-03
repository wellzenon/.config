return {
  'jakewvincent/mkdnflow.nvim',
  ft = 'markdown',
  config = function()
    require('mkdnflow').setup {
      links = {
        style = 'wiki',
      },
      mappings = {
        MkdnEnter = { { 'i', 'n', 'v' }, '<CR>' }, -- This monolithic command has the aforementioned
        -- insert-mode-specific behavior and also will trigger row jumping in tables. Outside
        -- of lists and tables, it behaves as <CR> normally does.
        -- MkdnNewListItem = {'i', '<CR>'} -- Use this command instead if you only want <CR> in
        -- insert mode to add a new list item (and behave as usual outside of lists).
      },
      foldtext = {
        title_transformer = function()
          local function my_title_transformer(text)
            local updated_title = text:gsub('%b{}', '')
            updated_title = updated_title:gsub('^%s*', '')
            updated_title = updated_title:gsub('%s*$', '')
            updated_title = updated_title:gsub('^######', '')
            updated_title = updated_title:gsub('^#####', '')
            updated_title = updated_title:gsub('^####', '')
            updated_title = updated_title:gsub('^###', '')
            updated_title = updated_title:gsub('^##', '')
            updated_title = updated_title:gsub('^#', '')
            return updated_title
          end
          return my_title_transformer
        end,
        object_count_icon_set = 'nerdfont',
        object_count_opts = function()
          local opts = {
            link = false,
            blockquote = {
              icon = ' ',
              count_method = {
                pattern = { '^>.+$' },
                tally = 'blocks',
              },
            },
            todo = {
              icon = '󰄷 ',
              count_method = {
                pattern = { '^%s*[%-%+%*]?%s*%[%s%]' },
                tally = 'line_matches',
              },
            },
            fncblk = {
              icon = ' ',
            },
          }
          return opts
        end,
        line_count = true,
        word_count = false,
        fill_chars = {
          left_edge = '⢾',
          right_edge = '⡷',
          left_inside = ' ⣹',
          right_inside = '⣏ ',
          middle = '⣿',
        },
      },
    }
  end,
}
