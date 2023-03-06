-- Setup for coc.nvim
vim.opt.tagfunc = 'CocTagFunc'

vim.g.coc_global_extension = {
  'coc-yaml',
  'coc-vimlsp',
  'coc-tsserver',
  'coc-sh',
  'coc-pyright',
  'coc-json',
  'coc-jedi',
  'coc-html',
  'coc-css',
  'coc-clangd',
  'coc-fish',
  'coc-spell-checker',
  'coc-rust-analyzer',
  'coc-sumneko-lua',
}

local CocCustomAu = vim.api.nvim_create_augroup('CocCustomAu', {})
vim.api.nvim_create_autocmd({ 'BufRead,BufNewFile' }, {
  group = CocCustomAu,
  pattern = '*',
  callback = function ()
    local excluded_filetypes = { 'log', 'qt' }
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
    for index, value in ipairs(excluded_filetypes) do
      if value == filetype then
        vim.b.coc_enabled = false
      else
        vim.b.coc_enabled = true
      end
    end
  end
})
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained' }, {
  group = CocCustomAu,
  pattern = '*',
  callback = function ()
    vim.fn.CocActionAsync("ensureDocument")
    vim.fn.CocActionAsync("refreshSource")
  end
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = CocCustomAu,
  pattern = {
    'cpp',
    'javascript',
    'json',
    'python',
    'rust',
    'typescript',
    'tacc',
    'vim',
  },
  callback = function ()
    vim.opt_local.formatexpr = "CocAction('formatSelected')"
  end
})
vim.api.nvim_create_autocmd({ 'CursorHold' }, {
  group = CocCustomAu,
  pattern = '*',
  callback = function ()
    vim.fn.CocActionAsync('highlight')
  end
})

local function register_mappings(mappings, default_options)
	for mode, mode_mappings in pairs(mappings) do
		for _, mapping in pairs(mode_mappings) do
			local options = #mapping == 3 and table.remove(mapping) or default_options
			local prefix, cmd = unpack(mapping)
			pcall(vim.api.nvim_set_keymap, mode, prefix, cmd, options)
		end
	end
end

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.cmd('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.cmd('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

local mappings = {
	i = { -- Insert mode
        {"<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', { expr = true }},
        {"<S-TAB>", 'coc#pum#visible() ? coc#pum#prev(1) : "<S-TAB>"', { expr = true }},
        {"<C-SPACE>", 'coc#refresh()', { expr = true }},
        {'<C-F>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<Right>"', { expr = true, silent = true, nowait = true }},
        {'<C-B>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<Left>"', { expr = true, silent = true, nowait = true }},
        {'<CR>',  'coc#pum#visible() && coc#pum#info()["index"] != -1 ? coc#pum#confirm() : "<C-g>u<CR>"', {expr = true, noremap = true}},
	},
	n = { -- Normal mode
        {"K", '<CMD>lua _G.show_docs()<CR>', { silent = true }},

        {'[g', '<Plug>(coc-diagnostic-prev)', { noremap = false }},
        {']g', '<Plug>(coc-diagnostic-next)', { noremap = false }},
        {'<leader>ca', '<Plug>(coc-codeaction-cursor)', { noremap = false }},

        {'<leader>gd', '<CMD>call CocActionAsync("jumpDefinition")<CR>', { noremap = true }},
        {'<leader>gy', '<CMD>call CocActionAsync("jumpTypeDefinition")<CR>', { noremap = true }},
        {'<leader>gi', '<CMD>call CocActionAsync("jumpImplementation")<CR>', { noremap = true }},
        {'<leader>gr', '<CMD>call CocActionAsync("jumpReferences")<CR>', { noremap = true }},

        {'<leader>rn', '<CMD>call CocActionAsync("rename")<CR>', { noremap = true }},

        {'<leader>zg', '<CMD>CocCommand cSpell.addWordToUserDictionary<CR>', { noremap = true }},
        {'<leader>zi', '<CMD>CocCommand cSpell.addIgnoreWordToUser<CR>', { noremap = true }},

        {'<C-F>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-F>"', { expr = true, silent = true, nowait = true }},
        {'<C-B>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-B>"', { expr = true, silent = true, nowait = true }},

	},
}

register_mappings(mappings, { silent = true, noremap = true })
