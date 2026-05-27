return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/Personal",
			},
		},
		templates = {
			folder = "Templates",
		},

		daily_notes = {
			folder = "Daily Notes",
			date_format = "%Y/%m/%Y-%m-%d",
			workdays_only = false,
			template = "Templates/Daily Note",
		},

		completion = {
			nvim_cmp = false, -- Changed to false to prevent the secondary menu
			min_chars = 2,
		},

		frontmatter = {
			enabled = false,
			-- func = function(note)
			-- 	local out = {}
			-- 	if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
			-- 		for k, v in pairs(note.metadata) do
			-- 			out[k] = v
			-- 		end
			-- 	end
			-- 	return out
			-- end,
		},
	},
	keys = {
		{ "<leader>of", "<cmd>Obsidian follow_link vsplit<CR>", "[O]bsidian [F]ollow Link" },
		{ "<leader>oi", "<cmd>Obsidian template<CR>", "[O]bsidian [I]nsert Template" },
		{ "<leader>ot", "<cmd>Obsidian today<CR>", "[O]bsidian [t]oday" },
		{ "<leader>oc", "<cmd>Obsidian template<CR>", "[O]bsidian Template [C]heckbox" },
	},
}
