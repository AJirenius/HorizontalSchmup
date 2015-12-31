local M = {}
M.previous_tick = 0
M.tick = 0
M.start_tick = 0
M.end_tick = 20

function M.reset()
	M.tick = 0
	M.previous_tick = 0
end

function M.get_progress()
	return M.tick/M.end_tick
end

function M.set_end_tick(amount)
	M.end_tick = amount
end

function M.increase(amount)
	M.previous_tick = M.tick
	M.tick = M.tick + amount
	if M.tick > M.end_tick then M.tick = M.end_tick end
end

function M.decrease(amount)
	M.previous_tick = M.tick
	M.tick = M.tick - amount
	if M.tick < 0 then M.tick = 0 end
end

function M.set_tick(amount)
	M.previous_tick = amount
	M.tick = amount
	if M.tick > M.end_tick then M.tick = M.end_tick end
	if M.tick < 0 then M.tick = 0 end
end

return M

