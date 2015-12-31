local M = {}


function M.create(type)
	local url = msg.url("/enemy_factory")
	url.fragment = type
	print("url:",url)
	local view = factory.create(url, nil, nil, {}, 1)
	return view
end

return M