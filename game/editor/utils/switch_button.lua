local simple_button = require "game.editor.utils.simple_button"

local M = {}

function M.init(self)
	simple_button.init()
end

local function on_click(button)
	button.active_index = button.active_index + 1
	if button.active_index > #button.states then button.active_index = 1 end
	M.switch_to(button)
end

function M.switch_to(button, index)
	if index == nil then index = button.active_index end
	if index > #button.states or index < 1 then 
		print("ERROR: Button cannot switch to state:",index," Nr of states:",#button.states)
		return
	end
	button.active_index = index
	simple_button.set_text(button, button.states[index])
end

function M.create(definition, pos)
	local button = simple_button.create(on_click)
	button.states = definition.states
	button.active_index = 1
	M.switch_to(button)
	simple_button.set_position(button, vmath.vector3(150,100,0))
	return button
end




return M

