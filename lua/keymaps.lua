-- Shorten function name
vim.g.mapleader = ','

local wk = require("which-key") 

local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap
-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)
keymap("n", "J", ":m '>+2<CR>gv=gv", opts)
keymap("n", "K", ":m '>-1<CR>gv=gv", opts)

-- Save When visual mode
keymap("i", "<C-s>", "<ESC>:w<CR>", opts)

wk.register({
  ["<leader>"] = {
    c = { "<cmd>nohl<CR>", "Clear Highlight" },
    s = { "<cmd>w<CR>", "Save"},
    ["q"] = { "<cmd>q<CR>", "Quit"},
    ["vs"] = { "<cmd>vs<CR>", "Vertical Split"},

    -- f for Files (Telescope)
    f = {
      name = "+file",
      f = { "<cmd>Telescope find_files<CR>", "Find File" },
      r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
      g = { "<cmd>Telescope live_grep<CR>", "Live Grep" }
    },

    -- t for Tree (NvimTree)
    b = { ':NvimTreeToggle<CR>', "Toggle NvimTree" }, 
    t = {
      name = "+tree",
      f = { ':NvimTreeFindFile<CR>', "NvimTree Find File" },
      r = { ':NvimTreeRefresh<CR>', "NvimTree Refresh" }
    },
  },

  -- Navigate
  ['<C-h>'] = { '<C-w>h', 'Move to h' },
  ['<C-j>'] = { '<C-w>j', 'Move to j' },
  ['<C-l>'] = { '<C-w>l', 'Move to l' },
  ['<C-k>'] = { '<C-w>k', 'Move to k' },

  -- Resize
  ['<C-Up>'] = { '<cmd>resize -2<CR>', "Resize Up" },
  ['<C-Down>'] = { '<cmd>resize +2<CR>', "Resize Down" },
  ['<C-Left>'] = { '<cmd>vertical resize -2<CR>', "Resize Left" },
  ['<C-Right>'] = { '<cmd>vertical resize +2<CR>', "Resize Right" },

  -- Navigate buffers
  ['<S-l>'] = { '<cmd>bnext<CR>', "Move next buffer" },
  ['<S-h>'] = { '<cmd>bprevious<CR>', "Move previous buffer" },
  
  -- Move text up and down
  ['<C-j>'] = { '<cmd>m .+1<CR>==gi', "Move text to down" },
  ['<C-k>'] = { '<cmd>m .-2<CR>==gi', "Move text to up" },


})
