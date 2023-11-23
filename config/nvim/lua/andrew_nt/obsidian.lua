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
