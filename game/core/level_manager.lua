local tick_manager = require "game.core.tick_manager"
local spawner = require "game.core.spawner.spawner"
local enemy_factory = require "game.enemies.enemy_factory"

local M = {}

local full_width_px
local full_progress_width
local all_layers 
	

function M.init()
	all_layers = { 
		{ url = msg.url("/level_par_3") }, 
		{ url = msg.url("/level") }, 
		{ url = msg.url("/level_par_1") },
		{ url = msg.url("/level_par_2") },
	} 
	for i,v in ipairs(all_layers) do
		local url = msg.url(v.url)
		url.fragment = "tilemap"
		local x, y, w, h = tilemap.get_bounds(url)
    	v.full_width_px = w * 24
    	v.full_progress_width = v.full_width_px - 400
    end
end

function M.update()
	local progress = tick_manager.get_progress()
	for i,v in ipairs(all_layers) do
		go.set_position(vmath.vector3(-v.full_progress_width*progress,i*2,-i*0.001), v.url)
	end
end



return M

