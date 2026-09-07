debug=false
-- simple_camera=false

map_start = 0
map_end = 1024

level = 0

-- look-up tables
flag = {
    solid_down = 0,
    solid_up = 1,
    spike = 7
}
tiles = {
    empty = 0,
    player = 1,
    blob = 48,
    flower = 79,
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

    -- init flower
    init_flower()
    
    --init entities
    init_player()
    init_blobs()
    init_shooters()
    
    -- init camera // not used in one-room
    -- init_camera()

    music(0)
end

function _update()
    -- toggle debug mode
    if btnp(🅾️) then
        debug = not debug
    end

    -- update all set timers
    update_timers()
    
    if not level_changing then
        -- update and animate entites
        update_blobs()
        update_player()
        animate_player()
        animate_blob()
        update_shooters()
    end

    -- update camera  // not used in one-room
	-- if simple_camera then
    --     update_camera(p)
    -- end
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
        print("press ❎ to restart",28, 30,7)
        if btnp(❎) then
            _init()
        end
    end
	
    color(7)
    print('level 0' ..level+1, 2, 2)
    -- draw debug info
    if debug then
        print('blobs = ' ..#blobs)
        -------test----------
        print("⬅️= "..collide_l,p.x,p.y-10)
        print("➡️= "..collide_r,p.x,p.y-16)
        print("⬆️= "..collide_u,p.x,p.y-22)
        print("⬇️= "..collide_d,p.x,p.y-28)
        ---------------------
    end

end