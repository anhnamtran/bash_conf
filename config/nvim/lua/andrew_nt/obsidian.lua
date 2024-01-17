-- Configuration for obsidian.nvim
require('obsidian').setup({
  workspaces = {
    {
      name = "Primary",
      path = "~/obsidian/Primary"
    }
  },
  completion = {
    -- If using nvim-cmp, set to true
    nvim_cmp = false,
    new_notes_location = "current_dir",
    prepend_note_path = true
  },
  templates = {
    subdir = "Templates",
    substitutions = {
      ["date:YYYY-MM-DD"] = function()
        return os.date("%Y-%m-%d", os.time())
      end
    }
  },
  open_app_foreground = true,
  disable_frontmatter = true,
})

local ObsidianCustomAu = vim.api.nvim_create_augroup('ObsidianCustomAu', {})
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile', 'VimEnter' }, {
  group = ObsidianCustomAu,
  pattern = '*.md',
  callback = function ()
    local file_path = vim.api.nvim_buf_get_name(0)
    if string.match(file_path, ".*/obsidian/.*") ~= nil then
      vim.b.coc_diagnostic_disable = true
      vim.opt_local.textwidth = 0
      vim.opt_local.spell = true
      vim.opt_local.spelllang = 'en_ca'
      vim.opt_local.conceallevel = 2
    end
  end
})
