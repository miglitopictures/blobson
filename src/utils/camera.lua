--simple camera

function init_camera()
    cam_x = 0
end

function update_camera(target)
    -- target needs x and w

	cam_x = target.x - 64 + target.w/2
	
	if cam_x < map_start then
		cam_x = map_start
	end
	if cam_x > map_end-128 then
		cam_x = map_end-128
	end
	camera(cam_x,0)
end