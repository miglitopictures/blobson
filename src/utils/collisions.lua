function collide_map(obj,aim,flag)
	--obj = table needs x,y,w,h
	--aim = left,right,up,down
	
	local x=obj.x local y=obj.y
	local w=obj.w local h=obj.h
	
	if aim=="left" then
		x1=x-1 y1=y
		x2=x y2=y+h-1
	
	elseif aim=="right" then
		x1=x+w y1=y
		x2=x+w-1 y2=y+h-1
	
	elseif aim=="up" then
		x1=x+2 y1=y-1
		x2=x+w-3 y2=y
	elseif aim=="down" then
		x1=x+2 y1=y+h
		x2=x+w-3 y2=y+h --
	end
	
	--pixels to tiles
	x1=x1/8 y1=y1/8
	x2=x2/8 y2=y2/8
	
	if fget(map_get(x1,y1), flag)
	or fget(map_get(x1,y2), flag)
	or fget(map_get(x2,y1), flag)
	or fget(map_get(x2,y2), flag) then
		return true
	else
		return false
	end

end

function map_get(x,y)
	return mget(to_level_x(x), y + flr(level/4)*16)
end

function map_set(x,y,tile)
	mset(to_level_x(x), to_level_y(y), tile)
end

function to_level_x(x)
	return x + ((level % 4)* 16)
end

function to_level_y(y)
	return y + flr(level/4)*16
end