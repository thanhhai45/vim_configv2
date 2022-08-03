local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap , as leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<C-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<c-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to exit insert mode 
keymap("i", "<C-s>", "<ESC>:w<CR>", opts)
keymap("i", "jk", "<ESC>", opts)
keymap("i", "<C-z>", "<ESC>:undo<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Telescope setup
keymap("n", "<C-p>", ":Telescope find_files<CR>", opts)
keymap("n", "<C-f>", ":Telescope live_grep<CR>", opts)
keymap("n", "<S-B>", ":Telescope buffers<CR>", opts)
keymap("n", "<S-H>", ":Telescope help_tags<CR>", opts)

-- Nvim toggle
keymap("n", "<C-b>", ":NvimTreeToggle<CR>", opts)
keymap("i", "<C-b>", ":NvimTreeToggle<CR>", opts)
keymap("v", "<C-b>", ":NvimTreeToggle<CR>", opts)

