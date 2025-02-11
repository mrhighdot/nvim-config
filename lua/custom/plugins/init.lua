-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
local comments = require 'custom.plugins.ts_comments.ts_comment'
local todo = require 'custom.plugins.todo.todo'
local noice = require 'custom.plugins.noice.noice'
local pairs = require 'custom.plugins.pairs.autopairs'
local dashboard = require 'custom.plugins.dashboard.dashboard'
local copilot = require 'custom.plugins.github.copilot'
local theme = require 'custom.plugins.theme.theme'
-- local theme = require 'custom.plugins.theme.ac-theme'
local coc = require 'custom.plugins.coc.coc'
-- local avante = require 'custom.plugins.avante.avante'
-- local vscode = require 'custom.plugins.theme.vscode'
-- local test_theme = require 'custom.plugins.theme.ac-theme-new'
-- local formatter = require 'custom.plugins.formatter.formatter'

return {
  comments,
  todo,
  pairs,
  dashboard,
  copilot,
  coc,
  theme,
  -- avante,
}
