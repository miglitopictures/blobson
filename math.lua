function limit(value,maximum)
	return mid(-maximum,value,maximum)
end


function dist(x1, y1, x2, y2)
  local dx = x1 - x2
  local dy = y1 - y2
  return sqrt(dx*dx + dy*dy)
end