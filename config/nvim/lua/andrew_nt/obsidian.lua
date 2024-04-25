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
  },
  new_notes_location = "current_dir",
  templates = {
    subdir = "Templates",
    substitutions = {
      ["date:YYYY-MM-DD"] = function()
        return os.date("%Y-%m-%d", os.time())
      end
    }
  },
  note_id_func = function(title)
    return title
  end,
  disable_frontmatter = true,
  daily_notes = {
    folder = "Daily",
    date_format = "%Y-%m-%d %a",
    template = "Templates/Daily notes.md"
  }
})

local ObsidianCustomAu = vim.api.nvim_create_augroup('ObsidianCustomAu', {})
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile', 'VimEnter' }, {
  group = ObsidianCustomAu,
  pattern = '*.md',
  callback = function ()
    local file_path = vim.api.nvim_buf_get_name(0)
    if string.match(file_path, ".*/obsidian/.*") ~= nil then
      vim.opt_local.textwidth = 0
      vim.opt_local.conceallevel = 2
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2

      -- Set keymaps
      vim.api.nvim_buf_set_keymap(0, 'n',
        '<leader>o',
        '<CMD>ObsidianOpen<CR>', { noremap = true })
    end
  end
})
