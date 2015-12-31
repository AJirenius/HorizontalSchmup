local path_types = require "game.core.path.path_types"
local M = {}

--[[
PATHS:
{
	get_pos			function				bezier, simple, exact route, bounding boxes,
	points			table with vector3 		z could be used as time
	default_time	number					time to go through whole path
}
--]]

local paths = {}

function M.add(definition)
	table.insert(paths, definition)
	return #paths
end 

function M.get_path(index)
	return paths[index]
end


return M