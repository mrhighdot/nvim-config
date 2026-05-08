return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require 'lualine'

    local colors = {
      red = '#e4572e',
      teal = '#17bebb',
      yellow = '#ffc914',
      dark = '#2e282a',
      green = '#76b041',
      fg = '#ffffff',
      bg = 'NONE',
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand '%:t') ~= 1
      end,
      screen_width = function(min_w)
        return function()
          return vim.o.columns > min_w
        end
      end,
    }

    local config = {
      options = {
        component_separators = '',
        section_separators = '',
        globalstatus = true,
        theme = {
          normal = { c = { fg = colors.fg, bg = 'NONE' } },
          inactive = { c = { fg = colors.fg, bg = 'NONE' } },
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    local function insert_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function insert_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    local function gap()
      return {
        function()
          return ''
        end,
        color = { bg = 'NONE', fg = 'NONE' },
        padding = { left = 1, right = 1 },
      }
    end

    local mode_map = {
      n = { icon = '󰋜 NORMAL', color = colors.teal },
      i = { icon = ' INSERT', color = colors.green },
      v = { icon = '󰈈 VISUAL', color = colors.yellow },
      V = { icon = '󰈈 V-LINE', color = colors.yellow },
      [''] = { icon = '󰈈 V-BLOCK', color = colors.yellow },
      c = { icon = ' COMMAND', color = colors.red },
      R = { icon = '󰏫 REPLACE', color = colors.red },
      Rv = { icon = '󰏫 V-REPLACE', color = colors.red },
      t = { icon = ' TERMINAL', color = colors.green },
      ['!'] = { icon = ' SHELL', color = colors.red },
      s = { icon = '󰒅 SELECT', color = colors.yellow },
      S = { icon = '󰒅 S-LINE', color = colors.yellow },
      [''] = { icon = '󰒅 S-BLOCK', color = colors.yellow },
    }

    -- LEFT SIDE

    -- Mode
    insert_left {
      function()
        local mode = vim.fn.mode()
        return (mode_map[mode] and mode_map[mode].icon) or '󰋜 NORMAL'
      end,
      color = function()
        local mode = vim.fn.mode()
        return {
          fg = (mode_map[mode] and mode_map[mode].color) or colors.teal,
          bg = 'NONE',
          gui = 'bold',
        }
      end,
      padding = { left = 1, right = 1 },
    }

    insert_left(gap())

    -- Branch
    insert_left {
      'branch',
      icon = '',
      color = { fg = colors.teal, bg = 'NONE', gui = 'bold' },
      padding = { left = 1, right = 1 },
    }

    insert_left(gap())

    -- Diff
    insert_left {
      'diff',
      symbols = { added = ' ', modified = ' ', removed = ' ' },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.yellow },
        removed = { fg = colors.red },
      },
      cond = conditions.screen_width(80),
      padding = { left = 1, right = 1 },
    }

    insert_left(gap())

    -- Diagnostics
    insert_left {
      'diagnostics',
      sources = { 'nvim_diagnostic', 'nvim_lsp' },
      sections = { 'error', 'warn', 'info', 'hint' },
      symbols = { error = ' ', warn = ' ', info = ' ' },
      colored = true,
      update_in_insert = false,
      always_visible = false,
      diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.teal },
        hint = { fg = colors.green },
      },
      padding = { left = 1, right = 1 },
    }

    -- Mid spacer
    insert_left {
      function()
        return '%='
      end,
      color = { bg = 'NONE' },
    }

    -- File name
    insert_left {
      'filename',
      path = 1,
      symbols = {
        modified = '󰷥 ',
        readonly = '󰌾 ',
        unnamed = '󰡯 No File',
        newfile = '󰝒 New File',
      },
      color = { fg = colors.fg, bg = 'NONE', gui = 'bold' },
      padding = { left = 1, right = 1 },
    }

    -- LSP
    -- insert_left {
    --   function()
    --     local clients = vim.lsp.get_clients { bufnr = 0 }
    --     if next(clients) == nil then
    --       return '󰅖 No LSP'
    --     end
    --     local devicons = require 'nvim-web-devicons'
    --     local ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
    --     local icon = devicons.get_icon_by_filetype(ft, { default = true })
    --     return (icon or '') .. ' ' .. clients[1].name
    --   end,
    --   color = { fg = colors.teal, bg = 'NONE', gui = 'bold' },
    --   padding = { left = 1, right = 1 },
    -- }
    --
    -- RIGHT SIDE

    -- Location
    insert_right {
      'location',
      icon = '⍜',
      color = { fg = colors.yellow, bg = 'NONE' },
      cond = conditions.buffer_not_empty,
      padding = { left = 1, right = 1 },
    }

    insert_right(gap())

    -- Progress
    insert_right {
      'progress',
      icon = '󰦨 ',
      color = { fg = colors.red, bg = 'NONE', gui = 'bold' },
      padding = { left = 1, right = 1 },
    }

    insert_right(gap())

    -- Encoding
    insert_right {
      'encoding',
      fmt = string.upper,
      icon = '⌘',
      color = { fg = colors.fg, bg = 'NONE' },
      cond = conditions.screen_width(80),
      padding = { left = 1, right = 1 },
    }

    insert_right(gap())

    -- Filetype
    insert_right {
      'filetype',
      colored = true,
      icon_only = false,
      color = { fg = colors.green, bg = 'NONE' },
      padding = { left = 1, right = 1 },
    }

    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE', ctermbg = 'NONE' })
        vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE', ctermbg = 'NONE' })
      end,
    })
    vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE', ctermbg = 'NONE' })
    vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE', ctermbg = 'NONE' })

    lualine.setup(config)
  end,
}
