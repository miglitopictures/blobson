--shooters

function init_shooters()
	bullets = {}
	shooters = {}
	--check map for shooters
	for i=level*16, (level*16) + 15 do
		for j=0, 15 do
			tile = mget(i,j)
			if tile == tiles.shooter_right then
				add(shooters, {
					sp = tiles.shooter_right,
					dir=1,
					flp=false,
					x = i*8,
					y = j*8,
				})
			end
			if tile == tiles.shooter_left then
				add(shooters, {
					sp = tiles.shooter_right, -- flipped sprite
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
		if b.life <= 0 or not (t == tiles.empty or t == tiles.shooter_right or t == tiles.shooter_left) then
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