local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})

vim.keymap.set('n', '<F4>', ':nohlsearch<CR>', {})
vim.keymap.set('n', '<C-t>', ':tabnew<CR>', {})

vim.keymap.set('n', 'ff', ':NvimTreeToggle<CR>', {})

vim.keymap.set('n', '<Space>', '@q', {})
vim.keymap.set('n', '<M-l>', '@a', {})

vim.keymap.set('v', '>', '>gv', {})
vim.keymap.set('v', '<', '<gv', {})

vim.keymap.set('x', 'p', '"_dP', { noremap = true })
vim.keymap.set('x', 'P', '"_dP', { noremap = true })
vim.keymap.set('x', 'd', '"_d', { noremap = true })
