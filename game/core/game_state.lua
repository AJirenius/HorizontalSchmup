local M = {}
	
	
M.STATE_PAUSED = 1	
M.STATE_PLAYING_LEVEL = 2	


local current_state = 2

function M.get_state()
	return current_state
end	

function M.set_state(state)
	if state == current_state then return end
	current_state = state
	
	if state == STATE_PAUSED then 
	
	elseif state == STATE_PLAYING_LEVEL then

	end
end


return M
