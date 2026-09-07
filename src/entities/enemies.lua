function init_blobs()
	blobs = {}
	--check map for blobs
	for i=0,15 do
		for j=0, 15 do
			tile = mget(i,j)
			if tile == 48 then
				mset(i,j,0)
				add(blobs, {
					sp = 48,
					x = i*8,
					y = j*8,
					dx = 1,
					dy = 0,
					w=8,
					h=8,
					flp=false,
					landed=true,
					falling=false,
				})
			end
		end
	end

end

function update_blobs()

 

	for b in all(blobs) do
		b.dy=b.dy+gravity
		
		if collide_map(b,"right",0) or collide_map(b,"left",0)  then
			b.dx*=-1
		end
		
		if	collide_map(b,"down",0)  then
			b.landed=true
			b.falling=false
			b.dy=0
			-- snap to tile
			b.y=b.y-(((b.y+b.h+1)%8)-1)
		end
		
		b.y+=b.dy
		b.x+=b.dx
	end
end

function animate_blob()
	for b in all(blobs) do
		if b.dx > 0 then
			b.flp=false
		else
			b.flp=true
		end
	end
end

function draw_blobs()
	for b in all(blobs) do
		spr(b.sp, b.x,b.y, 1,1,b.flp)
	end
end


--shooters

function init_shooters()
	bullets = {}
	shooters = {}
	--check map for blobs
	for i=0,15 do
		for j=0, 15 do
			tile = mget(i,j)
			if tile == 112 then
			--mset(i,j,0)
				add(shooters, {
					sp = 112,
					dir=1,
					flp=false,
					x = i*8,
					y = j*8,
				})
			end
			if tile == 113 then
			--mset(i,j,0)
				add(shooters, {
					sp = 112,
					dir=-1,
					flp=true,
					x = i*8,
					y = j*8,
				})
			end
		end
	end

end

ct = 0
function update_shooters()
	for s in all(shooters) do
		if ct > 30 then
			add(bullets, {
				x=s.x+4,
				y=s.y+4,
				dx=s.dir*4,
				life=160,
			})
			ct=0
		end
		ct+=1
	end
	
	for b in all(bullets) do
		b.x+=b.dx
		b.life-=1
		t = mget(b.x/8,b.y/8)
		if b.life <= 0 or not (t==0 or t==112 or t==113) then
			del(bullets, b)
		end
	end
	
end

function animate_shooters()

end

function draw_shooters()

	for s in all(shooters) do
		spr(s.sp, s.x,s.y, 1,1,s.flp)
	end
	
	for b in all(bullets) do
		circfill(b.x,b.y,1,8)
	end
end