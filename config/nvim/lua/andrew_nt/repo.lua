-- Setup for multi repo work with telescope and vim-fugitive
if vim.g.loaded_fugitive ~= 1 then
  vim.notify( "vim-fugitive is not loaded", vim.log.levels.ERROR )
  return
end
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local previewers = require('telescope.previewers')
local conf = require("telescope.config").values

local repo = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Package",
    finder = finders.new_oneshot_job(
      { "repo", "list", "-n", "-r", "^(?!GitarBandMutDb)" },
      opts
    ),
    previewer = previewers.new_termopen_previewer({
      title = "Lastest Commit",
      get_command = function(entry)
        return { "git", "-C", "/src/" .. entry.value, "status" }
      end
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local tempB = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_call(tempB, function()
          vim.cmd("lcd" .. "/src/" .. selection.value)
          vim.cmd([[G]])
        end)
        vim.cmd([[wincmd 99 k]])
      end)
      return true
    end
  }):find()
end

vim.api.nvim_create_user_command("Repo",
  function ()
    repo({ layout_strategy = 'vertical' })
  end,
  {}
)
