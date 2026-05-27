return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		-- Optionally configure and load the colorscheme
		-- directly inside the plugin declaration.
		vim.g.gruvbox_material_enable_italic = true
		vim.g.gruvbox_material_background = "soft"
		vim.g.gruvbox_material_transparent_background = 2

		vim.cmd.colorscheme("gruvbox-material")

		-- Ensure floating windows and terminal windows are also transparent
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
		vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

		-- Snacks overrides for transparency
		local snacks_hls = {
			"SnacksPickerTitle",
			"SnacksPickerSubtitle",
			"SnacksPickerHeader",
			"SnacksPickerPrompt",
		}
		for _, hl in ipairs(snacks_hls) do
			vim.api.nvim_set_hl(0, hl, { bg = "none" })
		end
	end,
}

