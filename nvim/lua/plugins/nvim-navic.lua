vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    local statusline_hl = vim.api.nvim_get_hl(0, { name = 'Delimiter', link = false })
    local statusline_bg = vim.api.nvim_get_hl(0, { name = 'Normal', link = false }).bg

    local navic_highlight_groups = {
      'NavicIconsFile',
      'NavicIconsModule',
      'NavicIconsNamespace',
      'NavicIconsPackage',
      'NavicIconsClass',
      'NavicIconsMethod',
      'NavicIconsProperty',
      'NavicIconsField',
      'NavicIconsConstructor',
      'NavicIconsEnum',
      'NavicIconsInterface',
      'NavicIconsFunction',
      'NavicIconsVariable',
      'NavicIconsConstant',
      'NavicIconsString',
      'NavicIconsNumber',
      'NavicIconsBoolean',
      'NavicIconsArray',
      'NavicIconsObject',
      'NavicIconsKey',
      'NavicIconsNull',
      'NavicIconsEnumMember',
      'NavicIconsStruct',
      'NavicIconsEvent',
      'NavicIconsOperator',
      'NavicIconsTypeParameter',
      'NavicIconsColor',
      'NavicIconsSnippet',
      'NavicIconsFolder',
      'NavicIconsReference',
      'NavicIconsText',
      'NavicIconsValue',
      'NavicIconsUnit',
      'NavicIconsKeyword',
      'NavicText',
      'NavicSeparator',
    }

    for _, group in ipairs(navic_highlight_groups) do
      local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
      vim.api.nvim_set_hl(0, group, {
        fg = hl.fg,
        bg = statusline_bg,
      })
    end

    vim.api.nvim_set_hl(0, 'NavicText', {
      fg = statusline_hl.fg,
      bg = statusline_bg,
    })
    vim.api.nvim_set_hl(0, 'Statusline', {
      fg = statusline_hl.fg,
      bg = statusline_bg,
    })
  end,
})

return {
  'SmiteshP/nvim-navic',
  lazy = true,
  color_correction = 'static',
  padding = {
    left = 1,
    right = 0,
  },
  opts = {
    separator = ' ',
    highlight = true,
    depth_limit = 5,
    -- icons = LazyVim.config.icons.kinds,
    lazy_update_context = true,
    lsp = { auto_attach = true },
    safe_output = true,
    click = true,
  },
}
