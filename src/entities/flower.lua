function init_flower()
	flower = {
		x = 0,
		y = 0
	}
	for i=0, 15 do
		for j=0, 15 do
			tile = map_get(i,j)
			if tile == tiles.flower then
				flower.x = i*8
				flower.y = j*8
			end
		end
	end
end