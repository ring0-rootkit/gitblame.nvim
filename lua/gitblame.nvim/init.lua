local M = {}

M.win_opts = {
	title = "Blame",
	relative = "cursor",
	width = 80,
	height = 4,
	row = 0,
	col = 0,
	border = "rounded",
	style = "minimal",
}
function M.setup()
	vim.api.nvim_create_user_command("Gitblame", function(input)
		-- get data we need from neovim
		local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
		local filename = string.gsub(vim.api.nvim_buf_get_name(0), vim.loop.cwd(), "")

		-- prepare and run comand to get git blame data
		local cmd = "git blame .%s -L %d,%d -l"
		local get_commit_hash = string.format(cmd, filename, row, row)
		local blame_data = vim.fn.system(get_commit_hash)

		-- get hash from git blame output and run git show to get commit info
		local commit_hash = blame_data:match("(%w+)")
		local get_commit_info = string.format("git show --no-patch %s", commit_hash)
		local commit_info = vim.fn.system(get_commit_info)

		-- check for error
		if string.starts_with(commit_info, "fatal") then
			print("This file or line is not tracked by git")
			return
		end

		-- parse commit info to put it in buffer
		local info_table = {}
		for s in commit_info:gmatch("[^\n]+") do
			table.insert(info_table, s)
		end

		-- create buffer with commit info
		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(buf, 0, -1, true, info_table)
		vim.api.nvim_buf_add_highlight(buf, -1, "Keyword", 0, 0, -1)

		-- create floating window with previously created buffer
		local win = vim.api.nvim_open_win(buf, false, M.win_opts)
		vim.api.nvim_win_set_hl_ns(win, 0)
		-- create autocmd to close buffer on cursor movement
		vim.api.nvim_create_autocmd({ "CursorMoved" }, {
			-- make this autocmd work only in current buffer
			-- so you can press <C-w> w, to put cursor in created buffer
			buffer = 0,
			once = true,
			callback = function()
				vim.api.nvim_win_close(win, true)
			end,
		})
	end, { bang = true, desc = "Show git blame for line under the cursor" })
end

function string.starts_with(String, Start)
	return string.sub(String, 1, string.len(Start)) == Start
end

return M
