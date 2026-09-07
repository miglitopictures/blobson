-- levels --

function change_level(selected_level)
    level_changing = true
    set_event(10,
        function() 
            level = selected_level
            level_changing = false
            _init()
        end
    )
    sfx(10)
end

function to_level_x(x)
	return x + ((level % 4)* 16)
end

function to_level_y(y)
	return y + flr(level/4)*16
end