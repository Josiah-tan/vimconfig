-- init.lua
M = {}

-- just an idea for writing new logs (and have them save without having to look into temp)
-- defined in org.lua
local folder = '~/org/cap/'
M.tmuxSplit = function()
	-- vim.cmd([[!tmux split-window -v -p 20 "nvim -c 'lua require("user.org").customLog()' .; $SHELL"]])  -- I wish this one works
	-- vim.cmd([[!tmux split-window -v -p 20 "nvim -c 'vsplit'; $SHELL"]]) -- this one works but not what I want
	vim.fn.system([[tmux split-window -v -p 20 "nvim .; $SHELL"]])  -- finally something that actually works
end

M.captionSplit = function()
	-- vim.fn.system([[tmux split-window -v -p 20 "nvim -c 'call CustomLog()' -c 'set laststatus=0' .; $SHELL"]])  -- finally something that actually works
	if vim.fn.isdirectory(vim.fn.expand(folder)) == 1 then
		if vim.fn.getenv("TMUX") ~= vim.NIL then
			local not_marked = vim.fn.system("tmux display -p -t '~' '#D'") == "no marked target\n"
			if not_marked then
				vim.fn.system([[tmux split-window -v -p 20 "tmux select-pane -m && nvim -c 'call CustomLog()' -c 'set laststatus=0' ."]])  -- finally something that actually works
			else
				local tried = vim.fn.system([[tmux join-pane -p 20 && tmux select-pane -m]])
				if tried == "can't join a pane to its own window\n" then
					vim.fn.system([[tmux select-pane -t '~']])
				end
			end
		else
			vim.cmd("belowright 10 split")
			require("user.org").customLog()
		end
	else
		print("clone or stow (todo) your org files first man")
	end
end

M.goToProgram = function()
	vim.fn.system([[tmux select-pane -t '~' && tmux select-pane -l]])
end

M.customLog = function()
		local time = vim.fn.strftime("%Y/%b/%d")
		-- print(time)
		-- print("edit "..folder..time..".org")
		vim.cmd("edit "..folder..time..".org")
		vim.cmd("silent !mkdir -p %:h")
end

return M
