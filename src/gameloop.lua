debug=true
simple_camera=false

map_start = 0
map_end = 1024

level = 5

-- look-up tables
flag = {
    solid_down = 0,
    solid_up = 1,
    flower = 6,
    spike = 7
}
tiles = {
    empty = 0,
    blob = 48,
    shooter_right = 112,
    shooter_left = 113
}

function _init()
    -- contants
    gravity=0.3
    friction=0.9
    
    -- reload map to initial state in memory
	reload(0x2000, 0x2000, 0x1000) 
    
    -- init timers table
    init_timers()
    
    --init entities
    init_player()
    init_blobs()
    init_shooters()
    
    -- init camera
    init_camera()

    music(0)
end

function _update()
    -- toggle debug mode
    if btnp(🅾️) then
        debug = not debug
    end

    -- update all set timers
	update_timers()

    -- update and animate entites
	update_blobs()
	update_player()
	animate_player()
	animate_blob()
	update_shooters()

    -- update camera
	if simple_camera then
        update_camera(p)
    end
end

function _draw()
	cls(0)
	map(to_level_x(0), to_level_y(0))

    -- draw entities
	draw_player()
	draw_blobs()
	draw_shooters()
 
    -- draw restart UI
    if not p.alive then
        print("press ❎ to restart",cam_x+28, 30,7)
        if btnp(❎) then
            _init()
        end
    end
	
    -- draw debug info
    if debug then
        color(7)
        print('blobs = ' ..#blobs,cam_x+3,3)
        print('level = ' ..level, cam_x+3)
        -------test----------
        print("⬅️= "..collide_l,p.x,p.y-10)
        print("➡️= "..collide_r,p.x,p.y-16)
        print("⬆️= "..collide_u,p.x,p.y-22)
        print("⬇️= "..collide_d,p.x,p.y-28)
        ---------------------
    end
end