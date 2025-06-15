-- Custom highlight group colors, colorshceme, and syntax highlights
vim.opt.background = 'dark'
vim.cmd.colorscheme("onedark")

-- additional scheme and highlighting changes
-- these need to be after 'colorscheme' incase that clears highlight groups
vim.opt.pumblend = 15

local custom_hl_groups = {
  -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
  ObsidianTodo = { bold = true, fg = "#5C6370" },
  ObsidianDone = { bold = true, fg = "#98C379" },
  ObsidianRightArrow = { bold = true, fg = "#D19A66" },
  ObsidianTilde = { bold = true, fg = "#FF5370" },
  ObsidianBullet = { bold = true, fg = "#5C6370" },
  ObsidianRefText = { underline = true, fg = "#61AFEF" },
  ObsidianExtLinkIcon = { fg = "#61AFEF" },
  ObsidianTag = { italic = true, fg = "#C678DD" },
  ObsidianBlockID = { italic = true, fg = "#C678DD" },
  ObsidianHighlightText = { bg = "#E5C07B" },

  PmenuSel = { fg = "#282C34", bg = "#C678DD" },

  CocHighlightText = { fg = "#56B6C2", bg = "#3B3F4C" },
  CocMenuSel = { link = "PmenuSel" },
}
for hl_group, opts in pairs(custom_hl_groups) do
  vim.api.nvim_set_hl(0, hl_group, opts)
end
