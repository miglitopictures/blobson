function init_timers()
	timers = {}
end

function update_timers()
	// check all timers
	for timer in all(timers) do
		// decrease timers
		timer.t-=1
		
		if timer.t <= 0 then
			timer.action()
			del(timers, timer)
		end
	
	end

end


function set_event(frames, callback)
	add(timers, {
		t = frames,
		action = callback
	})
end