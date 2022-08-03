-- Global options
local g = vim.g

g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_respect_buf_cwd = 1
g.nvim_tree_width_allow_resize  = 1
g.nvim_tree_icons = { default = "" }
g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
}

local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
  print(nvim_tree)
  return
end
require('nvim-tree').setup({
  hijack_netrw = true,
  hijack_cursor = true,
  nvim_tree_respect_buf_cwd = false,
  update_cwd = false,
  actions = {
    open_file = {
      quit_on_open = true,
    },
    change_dir = {
      enable = false,
      global = false,
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  }
})
