local tick_manager = require "game.core.tick_manager"
local spawner = require "game.core.spawner.spawner"
local enemy_factory = require "game.enemies.enemy_factory"

local M = {}
local last_index = 1

local active_queue = {}


function M.delete_enemy_by_id(enemy_id)
	active_queue[enemy_id] = nil
	-- is also handled by death.script before calling this function. Could this be a problem?
	go.delete(enemy_id) 
end

function M.update()
	local tick = tick_manager.tick
	
	-- get new enemies that should spawn and place them in active queue
	local objs, last_index = spawner.get_starters_between_times(tick_manager.previous_tick, tick, last_index)
	if objs and #objs > 0 then
		for i,v in ipairs(objs) do
			v.enemy = enemy_factory.create(v.enemy_type)
			active_queue[v.enemy] = v
		end
	end
	
	-- update all active enemies
	for k,v in pairs(active_queue) do
		local progress = (tick - v.start_time)/v.length
		if progress > 1 or progress < 0 then
			M.delete_enemy_by_id(k)
		else
			local pos = v.path.get_pos(progress, v.path.points)
			if v.path_offset then
				pos = pos + v.path_offset
			end
			go.set_position(pos, v.enemy)
		end
	end
	
end



return M

