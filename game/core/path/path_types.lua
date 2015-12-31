local M = {}

local function strict_path(progress, points)
	local np = 1/(#points - 1)				-- 4 points (0, .33, .66, 1)  , each part .33
	local pindex = math.ceil(progress/np)	-- if progress = 0.56, pindex = ceil(0.56/0.33) = 2 
	-- found first point. check progress between points
	local pprogress = (progress%np)/np		-- 0.56%0.33/0.33 = 0.23 / 0.33 = 0.69 (69% progress between the 2 points)
	--print(pprogress,points[pindex], points[pindex+1])
	local pos = vmath.lerp(pprogress, points[pindex], points[pindex+1])
	return pos
end

local types = {
	strict_path = strict_path
}

function M.get(type)
	return types[type]
end

return M