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
  open_app_foreground = false,
  use_advanced_uri = true,
  daily_notes = {
    folder = "Daily",
    date_format = "%Y-%m-%d %a",
    template = "Templates/Daily notes.md"
  },
  bullets = { char = "•", hl_group = "ObsidianBullet" },
  external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
  -- Replace the above with this if you don't have a patched font:
  -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
  reference_text = { hl_group = "ObsidianRefText" },
  highlight_text = { hl_group = "ObsidianHighlightText" },
  block_ids = { hl_group = "ObsidianBlockID" },
})

local ObsidianCustomAu = vim.api.nvim_create_augroup('ObsidianCustomAu', {})
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile', 'VimEnter', 'BufEnter' }, {
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
vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
  group = ObsidianCustomAu,
  pattern = '*.md',
  callback = function ()
    local file_path = vim.api.nvim_buf_get_name(0)
    if string.match(file_path, ".*/obsidian/.*") ~= nil then
      if vim.g.obsidian_follow_buf ~= nil and vim.g.obsidian_follow_buf then
        vim.cmd("ObsidianOpen")
      end
    end
  end
})

-- set to true to always call ObsidianOpen when buffer changes
vim.g.obsidian_follow_buf = true
vim.api.nvim_create_user_command("ObsidianFollow", function (args)
  vim.g.obsidian_follow_buf = not args.bang
end, { nargs = 0, bang = true })
