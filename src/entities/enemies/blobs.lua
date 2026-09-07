function init_blobs()
	blobs = {}
	--check map for blobs
	for i=level*16, (level*16) + 15 do
		for j=level*16, (level*16) + 15 do
			tile = mget(i,j)
			if tile == tiles.blob then
				mset(i,j,0)
				add(blobs, {
					sp = tiles.blob,
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
		
		if collide_map(b,"right",flag.solid_down) or collide_map(b,"left",flag.solid_down)  then
			b.dx*=-1
		end
		
		if	collide_map(b,"down",flag.solid_down)  then
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