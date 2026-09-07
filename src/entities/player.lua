function init_player()
	p = {
		alive=true,
		lives=3,
		mortal=true,
		sp=1,
		x=59,
		y=59,
		w=8,
		h=8,
		flp=false, --flip sprite
		dx=0, --change in x
		dy=0, --change in y
		max_dx=3,
		max_dy=3,
		acc=0.5,
		boost=4,
		anim=0,
		running=false,
		jumping=false,
		falling=false,
		sliding=false,
		landed=false
	}

	for i=0, 15 do
		for j=0, 15 do
			tile = map_get(i,j)
			if tile == tiles.player then
				map_set(i,j,tiles.empty)
				p.x = i*8
				p.y = j*8
			end
		end
	end

	-- debug info
	---------test----------
	collide_l="no"
	collide_r="no"
	collide_u="no"
	collide_d="no"
	-----------------------
end

function update_player()
	--physics
	p.dy=p.dy+gravity
	p.dx=p.dx*friction
	
	if p.alive then
		--controls
		if btn(⬅️) then
			p.dx=p.dx-p.acc
			p.running=true
			p.flp=true
		end
		
		if btn(➡️) then
			p.dx=p.dx+p.acc
			p.running=true
			p.flp=false
		end
		
		--slide
		if p.running
		--and not (btn(⬅️) or btn(➡️))
		and not btn(⬅️)
		and not btn(➡️)
		and not p.falling
		and not p.jumping then
			p.running=false
			p.sliding=true
		end
		
		--jump
		if (btnp(❎) or btnp(⬆️))
		and p.landed then
			--sfx(5)
			p.dy=p.dy-p.boost
			p.landed=false
		end
		
		--check collision ⬆️ and ⬇️
		if p.dy>0 then
			p.falling=true
			p.landed=false
			p.jumping=false
			
			p.dy=limit(p.dy,p.max_dy)
		
			if collide_map(p,"down",flag.solid_down) then
				p.landed=true
				p.falling=false
				p.dy=0
				-- snap to tile
				p.y=p.y-(((p.y+p.h+1)%8)-1)
			
				--------test----------
				collide_d="yes"
				else collide_d="no"
			----------------------
			
			end
			
			if collide_map(p,"down",flag.spike) and p.mortal then
				p.lives-=1
				p.mortal=false
				set_event(10, function() p.mortal = true end)
				p.dy=p.dy-p.boost
				p.dx=p.dx+p.boost
				p.landed=false
				sfx(00)
				
			end

			if collide_map(p,"down",flag.flower) and not level_changing then
				change_level(level + 1)
			end
		
		elseif p.dy<0 then
			p.jumping=true
			p.running = false
			p.landed=false
			if collide_map(p,"up",flag.solid_up) then
				p.dy=0
				--------test----------
				collide_u="yes"
			else collide_u="no"
			----------------------
			end
		end
		
		--check collision ⬅️ and ➡️
		if p.dx<0 then
		
			p.dx=limit(p.dx,p.max_dx)
			
			if collide_map(p,"left",flag.solid_up) then
				p.dx=0
				--------test----------
				collide_l="yes"
				----------------------
			end
			collide_r="no"
			if collide_map(p,"left", flag.spike) and p.mortal then
				p.lives-=1
				p.mortal=false
				set_event(10, function() p.mortal = true end)
				p.dy=p.dy-p.boost
				p.dx=p.dx+p.boost
				p.landed=false
				sfx(00)
			end
		
		elseif p.dx>0 then
		
			p.dx=limit(p.dx,p.max_dx)
			
			if collide_map(p,"right",flag.solid_up) then
				p.dx=0
				--------test----------
				collide_r="yes"
				----------------------
			end

			collide_l="no"
			
			if collide_map(p,"right", flag.spike) and p.mortal then
				p.lives-=1
				p.mortal=false
				set_event(10, function() p.mortal = true end)
				p.dy=p.dy-p.boost
				p.dx=p.dx-p.boost
				p.landed=false
				
				sfx(00)
			end
		end
		
		--stop sliding
		if p.sliding then
			if abs(p.dx)<.2
			or p.running then
				p.dx=0
				p.sliding=false
			end
		end
		
		for b in all(blobs) do
			-- check if player and blob boxes overlap
			-- using a small margin (2 pixels) to make it feel fair
			if p.mortal and
			p.x < b.x + b.w - 2 and
			p.x + p.w - 2 > b.x and
			p.y < b.y + b.h - 2 and
			p.y + p.h - 2 > b.y then

				if p.dy > 0 and p.y < b.y + 2 then
					-- stomp logic
					p.dy = -p.boost
					b.sp=49
					b.dx=0
					set_event(5,function() del(blobs, b) end)
					
					sfx(7)
				else
					-- damage logic
					p.lives -= 1
					p.mortal = false
					set_event(30, function() p.mortal = true end)
					p.dy = -p.boost
					p.dx = (p.x < b.x) and -2 or 2 -- knockback
					sfx(0)
				end
			end
		end
	
		for b in all(bullets) do
			-- check if player and blob boxes overlap
			-- using a small margin (2 pixels) to make it feel fair
			if p.mortal and
			p.x < b.x + 4 - 2 and
			p.x + p.w - 2 > b.x and
			p.y < b.y + 4 - 2 and
			p.y + p.h - 2 > b.y then
				-- damage logic
				p.lives -= 1
				p.mortal = false
				set_event(10, function() p.mortal = true end)
				p.dy = -p.boost
				p.dx =  b.dx *2
				del(bullets,b)
				sfx(0)
			end
		end
					
		
		if p.lives <= 0 then
			p.alive = false
			music(1)
			sfx(8)
		end
		
	end
	
	--move player
	p.x=p.x+p.dx
	p.y=p.y+p.dy
	
	--limit player to the map
	if p.x<map_start then
		p.x=map_start
	end
	if p.x>map_end-p.w then
		p.x=map_end-p.w
	end
	
end

function animate_player()
	if not p.alive then
		p.sp=10
	elseif p.jumping then
		p.sp=7
	
	elseif p.falling then
		p.sp=8
	
	elseif p.sliding then
		p.sp=9
	
	elseif p.running then
		if time()-p.anim>.1 then
			p.anim=time()
			p.sp=p.sp+1
			if p.sp>6 then
				p.sp=3
			end
		end
		
	else --player idle
		if time()-p.anim>.3 then
			p.anim=time()
			p.sp=p.sp+1
			if p.sp>2 then
				p.sp=1
			end
		end
	end
end

function draw_player()
	-- player sprite
	spr(p.sp, p.x, p.y, 1, 1, p.flp)

	-- player lives
	for i=1, p.lives do
		-- spr(15,i*10+p.x,p.y,1,1)
		circfill(p.x-1+i*2+(3-p.lives),p.y-4,0,11)
	end
end