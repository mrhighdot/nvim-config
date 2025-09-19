local comments = require 'custom.plugins.ts_comments.ts_comment'
local todo = require 'custom.plugins.todo.todo'
local noice = require 'custom.plugins.noice.noice'
local pairs = require 'custom.plugins.pairs.autopairs'
-- local dashboard = require 'custom.plugins.dashboard.dashboard'
local copilot = require 'custom.plugins.github.copilot'
local coc = require 'custom.plugins.coc.coc'
local avante = require 'custom.plugins.avante.avante'
local vscode = require 'custom.plugins.theme.hybrid'
local formatter = require 'custom.plugins.formatter.formatter'
local blade = require 'custom.plugins.blade.blade'
local lg = require 'custom.plugins.lazygit.lazygit'
local tabby = require 'custom.plugins.tabby.tabby'

return {
  comments,
  todo,
  pairs,
  copilot,
  coc,
  blade,
  vscode,
  avante,
  formatter,
  lg,
  tabby,
  noice,
}
