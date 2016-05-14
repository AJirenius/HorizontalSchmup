local M = {}

--[[
	

	PATHS:
{
	get_pos			function				bezier, simple, exact route, bounding boxes,
	points			table with vector3 		z could be used as time
	default_time	number					time to go through whole path
}

	POINT:
	{
		position	vector3
		view		node
	}
	
--]]

local active_path
local active_point

local is_mouse_down = false


local function inactivate_point()
	gui.set_color(active_point.view.path_point, vmath.vector4(1,1,1,0.3))
	active_point = nil
end

local function activate_point(point)
	if active_point ~= nil then inactivate_point() end
	active_point = point
	gui.set_color(active_point.view.path_point, vmath.vector4(0,0,1,0.8))
end



local function create_new_path()
	active_path = {
		points = {},
		default_time = 3,
	}
end

local function update_active_point_position(self, position)
	if active_point == nil then return end
	active_point.position = position
	gui.set_position(active_point.view.path_point, active_point.position * 2)
end
	
local function create_point(self, position)
	if active_path == nil then create_new_path() end
	local point = {
		view = gui.clone_tree(self.path_point_template),
	}
	activate_point(point)
	update_active_point_position(self, position)
	table.insert(active_path.points, point)
end
	
local function check_for_point_hit(self, x, y)
	if active_path == nil then return end
	for i,point in ipairs(active_path.points) do
		if gui.pick_node(point.view.path_point, x, y) == true then return point end
	end
end



local function delete_point(point)
	if active_path == nil then print("Error: No path is active") return end
	for i,v in ipairs(active_path.points) do
		if v == point then
			table.remove(active_path.points, i)
			gui.delete_node(point.view.path_point)
			gui.delete_node(point.view.point_text)
			break
		end
	end
end

function M.init(self)
	self.path_point_template = gui.get_node("path_point")
end

function M.update(self, dt)
	if active_path ~= nil then
		for i = 1, #active_path.points-1 do
			msg.post("@render:", "draw_line", { start_point = active_path.points[i].position, end_point = active_path.points[i+1].position, color = vmath.vector4(0.4, 1, 0.4, 1) } )
		end
		for i,v in ipairs(active_path.points) do
			gui.set_text(v.view.point_text, tostring(i))
		end
	end
end

function M.on_input(self, action_id, action)
	if action_id == hash("mouse_1") then
		if action.pressed == true then 
			is_mouse_down = true
			-- check first if node has been hit
			
			local p = check_for_point_hit(self, action.screen_x, action.screen_y)
			if p ~= nil then 
				activate_point(p)
			else
				-- otherwise create a node
				create_point(self, vmath.vector3(action.screen_x * 0.5,action.screen_y * 0.5, 0))
			end
		elseif action.released == true then
			is_mouse_down = false
		else
			if is_mouse_down == true then
				update_active_point_position(self, vmath.vector3(action.screen_x * 0.5,action.screen_y * 0.5, 0))
			end
		end
	end
	if action_id == hash("delete") and action.pressed == true then
		if active_point ~= nil then 
			local p = active_point
			inactivate_point(p)
			delete_point(p)
		end
	end
end

	

return M
