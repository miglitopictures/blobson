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