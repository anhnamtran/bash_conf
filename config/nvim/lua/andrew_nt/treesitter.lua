-- Setup for nvim-treesitter (main branch)
-- nvim-treesitter (main branch)
-- Pattern: install parsers once at startup, enable highlighting per-filetype
-- using vim.treesitter.language.add() as a guard (no install() in FileType).

local ensure_installed = {
  'bash',
  'c',
  'comment',
  'cpp',
  'css',
  'diff',
  'dockerfile',
  'git_config',
  'git_rebase',
  'gitattributes',
  'gitcommit',
  'gitignore',
  'go',
  'html',
  'http',
  'javascript',
  'jq',
  'json',
  'json5',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'ninja',
  'nix',
  'objdump',
  'printf',
  'python',
  'regex',
  'requirements',
  'rust',
  'scheme',
  'ssh_config',
  'starlark',
  'strace',
  'toml',
  'tsv',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
  'yang',
}

-- Install missing parsers. vim.schedule() defers this out of the startup
-- critical path. install() is a no-op for already-installed parsers.
vim.schedule(function()
  local ok, ts = pcall(require, 'nvim-treesitter')
  if not ok then return end
  local installed = ts.get_installed()
  local to_install = vim.tbl_filter(function(p)
    return not vim.tbl_contains(installed, p)
  end, ensure_installed)
  if #to_install > 0 then
    ts.install(to_install)
  end
end)
-- Enable treesitter features per-filetype.
-- Uses vim.treesitter.language.add() as a guard: returns false if the parser
-- is not installed, so we never call start() for unsupported filetypes.
-- No install() call here — it's async and the parser won't be ready in time.
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function(ev)
    local buf  = ev.buf
    local ft   = ev.match
    local lang = vim.treesitter.language.get_lang(ft) or ft

    -- add() returns false if the parser is not installed; bail out silently.
    if not vim.treesitter.language.add(lang) then return end

    -- Parser is installed and loaded — safe to start highlighting.
    vim.treesitter.start(buf, lang)

    -- Treesitter-based indentation (nvim-treesitter main provides indentexpr)
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

    -- Treesitter-based folding (built-in Neovim core API)
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr   = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldenable = false
  end,
})

-- Register custom filetype → language mappings (Neovim core API, unchanged)
vim.treesitter.language.register('starlark', 'bazel')

-- NOTE: nvim-treesitter/playground is deprecated.
-- Use :InspectTree  (replaces TSPlaygroundToggle)
-- Use :Inspect      (shows highlight groups under cursor)
-- Use :EditQuery    (replaces the query editor)

