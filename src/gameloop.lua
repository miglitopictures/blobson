function _init()
	reload(0x2000, 0x2000, 0x1000) -- reloads map data from the rom to ram
    dbg="start"
    init_timers()

    player_init()
    
    gravity=0.3
    friction=0.9
    
    --init enemies
    init_blobs()
    init_shooters()
    
    --simple camera
    cam_x=0
    
    --map limits
    map_start=0
    map_end=1024
    
    ---------test----------
    x1r=0 x2r=0 y1r=0 y2r=0
    collide_l="no"
    collide_r="no"
    collide_u="no"
    collide_d="no"
    -----------------------
    music(0)
 

 
end

function _update()
	player_update()
	player_animate()
	update_blobs()
	animate_blob()
	update_shooters()
	
	--simple camera
	-- cam_x=p.x-64+p.w/2
	
	-- if cam_x<map_start then
	-- 	cam_x=map_start
	-- end
	-- if cam_x>map_end-128 then
	-- 	cam_x=map_end-128
	-- end
	-- camera(cam_x,0)
	
	--timers
	update_timers()
end

function _draw()
	cls(0)
	map(0,0)
	spr(p. sp,     -- sprite
					p.x, p.y, -- player pos
					1 ,1, -- size in tiles
					p.flp)    -- flip-x
	
	
	draw_blobs()
	draw_shooters()
	
	for i=1, p.lives do
-- 	spr(15,
-- 					i*10+p.x,p.y,
-- 					1,1)
 	circfill(p.x-1+i*2+(3-p.lives)
 									,p.y-4,0,11)
 end
 
 
 if not p.alive then
 	print("press ❎ to restart",cam_x+28, 30,7)
 	if btnp(❎) then
 		_init()
 	end
 
 end
	
print(#blobs,cam_x+3,50)
	-------test----------
	rect(x1r,y1r,x2r,y2r,7)
	print("⬅️= "..collide_l,p.x,p.y-10)
	print("➡️= "..collide_r,p.x,p.y-16)
	print("⬆️= "..collide_u,p.x,p.y-22)
	print("⬇️= "..collide_d,p.x,p.y-28)
	---------------------
	
	-- print(dbg,cam_x+5,8)
end