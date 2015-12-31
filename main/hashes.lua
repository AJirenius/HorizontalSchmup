--[[
	All hashes being frequently used as message hashes ingame.
--]]

local M = {}



-- groups
M.group_player = hash("player")
M.group_player_bullets = hash("player_bullets")
M.group_enemies = hash("enemies")
M.group_enemy_bullets = hash("enemy_bullets")
M.group_static_bg = hash("static_bg")

-- general
M.decrease_health = hash("decrease_health")
M.kill_by_destruction = hash("kill_by_destruction")

-- fx
M.basic_explosion = hash("basic_explosion")

return M