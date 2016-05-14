local M = {}

local PEAK_RESET_TIME = 2
local FPS_RESETED = false
local max_fps = 0
local min_fps = 9999
local peak_max_fps = 0 
local peak_min_fps = 9999 
local peak_timer = 0


function M.update(dt)
	local current_fps = 1/dt
	if current_fps > max_fps then max_fps = current_fps end	
	if current_fps < min_fps then min_fps = current_fps end	
	if current_fps > peak_max_fps then 
		peak_max_fps = current_fps 
		peak_timer = 0
	end	
	if current_fps < peak_min_fps then 
		peak_min_fps = current_fps 
		peak_timer = 0
	end	
	peak_timer = peak_timer + dt
	if peak_timer >  PEAK_RESET_TIME then 
		peak_timer = 0
		peak_max_fps = 0
		peak_min_fps = 9999
		if FPS_RESETED == false then
			FPS_RESETED = true
			max_fps = 0
			min_fps = 9999
		end
	end
	local str = " FPS: "..math.floor(current_fps)..
	" PeakMax: "..math.floor(peak_max_fps)..
	" PeakMin: "..math.floor(peak_min_fps)..
	" Max: "..math.floor(max_fps)..
	" Min: "..math.floor(min_fps)
	msg.post("@render:", "draw_text", { text = str, position = vmath.vector3(0, 600, 0), color = vmath.vector3(1,0,1,1) } )
end

return M

