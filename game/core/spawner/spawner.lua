local M = {}

--[[
SPAWNER:
{
	id				number					unique id of spawner (not view instance), will be added at spawner.add()
	start_time		number
	end_time		number					omitted if using path default time
	length			number					if used, end_time will be calculated when added
	path			ref to path
	path_offset		vector3				
	enemy_type		string
	enemy			enemy_id
}
If none of end_time or length is provided, spawner will default to default time length

--]]

local queue = {}
local id_count = 0

function M.add(definition, will_sort)
	id_count = id_count + 1
	definition.id = id_count
	if definition.length == nil and definition.end_time == nil then definition.length = path.default_time end
	if definition.length then 
		definition.end_time = definition.start_time + definition.length 
	elseif definition.end_time then
		definition.length = definition.end_time - definition.start_time
	end
	if will_sort == true then
		for i,v in ipairs(queue) do
			if v.start_time > definition.start_time then
				table.insert(queue,i,definition)
				return
			end
		end
	end
	table.insert(queue,definition)
end

-- ix = index to start with to speeden up the search for active ones
function M.get_starters_between_times(start_t,end_t, ix)
	ix = ix or 1
	local sp = {} -- table of spawners that fit into timeframe
	
	-- TODO: optimize later on!
	for i = ix,#queue do
		ix = i
		
		local v = queue[i]
		
		if v.start_time > end_t then break end
		if v.start_time > start_t then 
			table.insert(sp, v) 
		end
	end
	return sp,ix	
end

function M.get_actives_between_times(start_t, end_t)
	local sp = {} -- table of spawners that fit into timeframe
	for i = 1,#queue do
		ix = i		
		local v = queue[i]
		if v.start_time > end_t then break end
	
		if start_t < v.end_time  and end_t > v.start_time then 
			
			table.insert(sp, v) 
		end
	end
	return sp
end



return M