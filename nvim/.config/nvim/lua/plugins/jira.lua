local function jira_key_from_branch()
  local result = vim.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }, { text = true }):wait()
  if result.code ~= 0 then
    return nil
  end
  local branch = vim.trim(result.stdout)
  return branch:match("^(%u+-%d+)")
end

return {
  "letieu/jira.nvim",
  opts = {
    -- Your setup options...
    jira = {
      api_version = "3",                          -- API version: "2" or "3" (default: "3")
      limit = 200,                                -- Global limit of tasks per view (default: 200)
      logging = false,                            -- Enable HTTP request/response logging (default: false)
    },

    active_sprint_query = "project = '%s' AND sprint in openSprints() ORDER BY Rank ASC",

    -- Saved JQL queries for the JQL tab
    -- Use %s as a placeholder for the project key
    queries = {
      ["Next sprint"] = "project = '%s' AND sprint in futureSprints() ORDER BY Rank ASC",
      ["Backlog"] = "project = '%s' AND (issuetype IN standardIssueTypes() OR issuetype = Sub-task) AND (sprint IS EMPTY OR sprint NOT IN openSprints()) AND statusCategory != Done ORDER BY Rank ASC",
      ["My Tasks"] = "assignee = currentUser() AND statusCategory != Done ORDER BY updated DESC",
    },

    -- Project-specific overrides
    -- Still think about this config, maybe not good enough
    projects = {
      ["DEV"] = {
        story_point_field = "customfield_10035",      -- Custom field ID for story points
        custom_fields = { -- Custom field to display in markdown view
          { key = "customfield_10016", label = "Acceptance Criteria" }
        },
      }
    }
  },
  keys = {
    {
      "<leader>ji",
      function()
        vim.ui.input({ prompt = "Jira Issue Key: " }, function(issue_key)
          if issue_key and issue_key ~= "" then
            vim.cmd("Jira info " .. issue_key)
          end
        end)
      end,
      desc = "Jira Issue Info",
    },
    {
      "<leader>jt",
      function()
        local key = jira_key_from_branch()
        if not key then
          vim.notify("Could not find a Jira issue key in the current branch name", vim.log.levels.WARN)
          return
        end
        vim.cmd("Jira info " .. key)
      end,
      desc = "Jira Info (current branch)",
    },
  }
}
