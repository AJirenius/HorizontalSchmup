--[[ 

PATHS:
{
	type			number					bezier, simple, exact route, bounding boxes,
	points			table with vector3 		z could be used as time
	default_time	number					time to go through whole path
}

PATH_TYPE
{
	get_position(progress, points)	function	returns raw position as vector3
}




SPAWNER:
{
	start_time		number
	end_time		number					omitted if using path default time
	path			path_id
	path_offset		vector3				
	enemy			enemy_id
}



--]]