local M = {}

local function get_progress_between_sub_points(progress, points)
	local np = 1/(#points - 1)				-- 4 points (0, .33, .66, 1)  , each part .33
	local pindex = math.ceil(progress/np)	-- if progress = 0.56, pindex = ceil(0.56/0.33) = 2 
	-- found first point. check progress between points
	local t = (progress%np)/np		-- 0.56%0.33/0.33 = 0.23 / 0.33 = 0.69 (69% progress between the 2 points)
	local b = points[pindex]
	local b2 = points[pindex+1]
	return t, b, b2-b, b2
--  return t, b, c, b2
end

--[[
	t = progress
	b = start value
	c = change in value
	d = duration ( 1 )
--]]

local function strict(progress, points) 
	local t,b,c,b2 = get_progress_between_sub_points(progress, points)
	return vmath.lerp(t,b,b2)
end

local function sin_in_out(progress, points)
	local t, b, c  = get_progress_between_sub_points(progress, points)
	return vmath.vector3(
		-c.x/2 * (math.cos(math.pi*t/1) - 1) + b.x, 
		-c.y/2 * (math.cos(math.pi*t/1) - 1) + b.y,0)
end

local function sin_in_out_vertical(progress, points)
	local t, b, c, b2  = get_progress_between_sub_points(progress, points)
	return vmath.vector3(
		vmath.lerp(t,b.x,b2.x), 
		-c.y/2 * (math.cos(math.pi*t/1) - 1) + b.y,0)
end

local types = {
	strict = strict,
	sin_in_out = sin_in_out,
	sin_in_out_vertical = sin_in_out_vertical,
}

function M.get(type)
	return types[type]
end

return M