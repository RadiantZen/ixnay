local keymap = require("mini.keymap")
keymap.setup()

-- Multi-step
local map_multistep = keymap.map_multistep

-- Setup that works well with 'mini.completion' and 'mini.pairs':
map_multistep("i", "<Tab>", { "pmenu_next" })
map_multistep("i", "<S-Tab>", { "pmenu_prev" })
map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
map_multistep("i", "<BS>", { "minipairs_bs" })

-- Combo
local map_combo = keymap.map_combo

-- "Better escape" to Normal mode without having to reach for <Esc> key:
-- Support most common modes. This can also contain 't', but would
-- only mean to press `<Esc>` inside terminal.
local mode = { "i", "c", "x", "s" }
map_combo(mode, "jk", "<BS><BS><Esc>")
-- To not have to worry about the order of keys, also map "kj"
map_combo(mode, "kj", "<BS><BS><Esc>")
-- Escape into Normal mode from Terminal mode
map_combo("t", "jk", "<BS><BS><C-\\><C-n>")
map_combo("t", "kj", "<BS><BS><C-\\><C-n>")

-- Show notification if there is too much movement by repeating same key
-- local notify_many_keys = function(key)
--   local lhs = string.rep(key, 5)
--   local action = function() vim.notify('Too many ' .. key) end
--   require('mini.keymap').map_combo({ 'n', 'x' }, lhs, action)
-- end
-- notify_many_keys('h')
-- notify_many_keys('j')
-- notify_many_keys('k')
-- notify_many_keys('l')
