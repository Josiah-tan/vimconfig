vim.notify = require("notify")
GlobalsDebugModeOn = true

-- for printing lua tables
P = function(v1, v2)
	local _P = function(v)
		if type(v) == 'table' then
			return vim.inspect(v)
		else
			return v
		end
	end
	if GlobalsDebugModeOn then
		if v2 then
			-- print(_P(v1), _P(v2))
			vim.notify((_P(v2)), "debug", {title = _P(v1)})
			return v2
		else
			vim.notify((_P(v1)), "debug")
			return v1
		end
	end
end


-- re sources luafiles
RELOAD = function(package_reload)
	-- so this reloads the imported package, so any updates that you make in the lua file will be shown
	package.loaded[package_reload] = nil
	-- and this imports the package
	return require(package_reload)
end
