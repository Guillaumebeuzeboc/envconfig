-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Define :SudoW command to save the file using pkexec and force reload
vim.api.nvim_create_user_command('SudoW', function()
    vim.cmd('silent! w !pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY tee % >/dev/null') -- Save file using pkexec
    vim.cmd('edit!')  -- Force reload the file
end, {})

-- Define :SudoWq command to save the file using pkexec and quit
vim.api.nvim_create_user_command('SudoWq', function()
    vim.cmd('silent! w !pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY tee % >/dev/null')  -- Save file using pkexec
    vim.cmd('edit!')  -- Force reload the file
    vim.cmd('q!')  -- Force quit
end, {})

-- Map 'w!!' to save the file using pkexec
vim.api.nvim_set_keymap('c', 'w!!', "<esc>:SudoW<CR>", { silent = true, noremap = true })

-- Map 'wq!!' to save and quit using pkexec
vim.api.nvim_set_keymap('c', 'wq!!', "<esc>:SudoWq<CR>", { silent = true, noremap = true })
