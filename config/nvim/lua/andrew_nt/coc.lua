-- Setup for coc.nvim
vim.cmd([[
function! s:disable_coc_for_type()
  let l:filesuffix_denylist = ['log', 'qt']
	if index(l:filesuffix_denylist, expand('%:e')) != -1
	  let b:coc_enabled = 0
	endif
endfunction
augroup CocCustomAu
  au!
  autocmd! BufRead,BufNewFile * call s:disable_coc_for_type()
  autocmd! BufEnter,FocusGained * silent call CocActionAsync("ensureDocument")
  autocmd! BufEnter,FocusGained * silent call CocActionAsync("refreshSource")
  autocmd! FileType json,cpp,vim,tacc,python setl formatexpr=CocAction('formatSelected')
augroup END

autocmd CursorHold * silent call CocActionAsync('highlight')

set tagfunc=CocTagFunc

" remap all Coc's <Plug> mappings to use CocActionAsync
nnoremap <Plug>(coc-definition) :CocActionAsync('jumpDefinition')
nnoremap <Plug>(coc-type-definition) :CocActionAsync('jumpTypeDefinition')
nnoremap <Plug>(coc-implementation) :CocActionAsync('jumpImplementation')
nnoremap <Plug>(coc-references) :CocActionAsync('jumpReferences')
nnoremap <Plug>(coc-rename) :CocActionAsync('rename')
nnoremap <Plug>(coc-codeaction) :CocActionAsync('codeAction', '')
nnoremap <Plug>(coc-codeaction-cursor) :CocActionAsync('codeAction', 'cursor')
]])

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
    if fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.cmd('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.cmd('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

local mappings = {
	i = { -- Insert mode
        { "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', { expr = true } },
        { "<S-TAB>", 'coc#pum#visible() ? coc#pum#prev(1) : "<S-TAB>"', { expr = true } },
        { "<C-SPACE>", 'coc#refresh()', { expr = true } },
        {'<C-F>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<Right>"', { expr = true, silent = true, nowait = true }},
        {'<C-B>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<Left>"', { expr = true, silent = true, nowait = true }},
        {'<CR>',  'coc#pum#visible() && coc#pum#info()["index"] != -1 ? coc#pum#confirm() : "<C-g>u<CR>"', {expr = true, noremap = true}}
	},
	n = { -- Normal mode
        { "K", '<CMD>lua _G.show_docs()<CR>', { silent = true } },
        {'[g', '<Plug>(coc-diagnostic-prev)', { noremap = false }},
        {']g', '<Plug>(coc-diagnostic-next)', { noremap = false }},
        {'gb', '<Plug>(coc-cursors-word)', { noremap = false }},
        {'gd', '<Plug>(coc-definition)', { noremap = false }},
        {'gy', '<Plug>(coc-type-definition)', { noremap = false }},
        {'gi', '<Plug>(coc-implementation)', { noremap = false }},
        {'gr', '<Plug>(coc-references)', { noremap = false }},

        {'<C-F>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-F>"', { expr = true, silent = true, nowait = true }},
        {'<C-B>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-B>"', { expr = true, silent = true, nowait = true }},

	},
}

register_mappings(mappings, { silent = true, noremap = true })
