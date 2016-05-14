local M = {}

local buttons = {}

local button_template
function M.init()
	button_template = gui.get_node("button_template")
end

function M.set_text(button, text)
	pprint(button.view)
	gui.set_text(button.view.text, text)
end

function M.set_position(button, pos )
	gui.set_position(button.view.button_template, pos)
end

function M.create(on_click)
	local button = {}
	button.view = gui.clone_tree(button_template)
	button.on_click = on_click
	table.insert(buttons,button)
	return button
end
--[[
function M.on_(action_id, action)
	for i,btn in ipairs(buttons) do
		if gui.pick_node(btn.view.button_template, )
	end
end
--]]




return M

