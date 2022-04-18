o = {}

-- todo: add a screen indication of step repeats. divide the pitch bar into even segments that fill up with each repeat?

function o.screen(as_proxies)
	screen.clear()
	for t=1,2 do
		local mod = ((t-1) * 64)
		for i=1,8 do
			local x = i * 7 + mod
			local line_len = util.linlin(0,127,0,45,as_proxies[t].vals[i])
			-- local line_len = util.linlin(0,127,0,45,params:get('step_'..i+(t-1)*8))
			screen.move(x,48)
			screen.line_width(4)
			screen.level(i <= as_proxies[t].len and 10 or 2)
			screen.line(x,47-line_len)
			screen.stroke()
			if params:get('pos_'..t) == i then
				screen.level(15)
				screen.move(x-2,52)
				screen.line_width(2)
				screen.line_rel(4,0)
				screen.stroke()
			end
		end
		screen.level(16)
		screen.move(mod,61)
		screen.text('/'..math.abs(params:get('division_'..t)))
		screen.move(mod+15,61)
		screen.text('s'..params:get('as_'..t))
		screen.move(mod+30,61)
		if params:get('latch_'..t) == 1 then screen.text('latched') end
	end
	screen.update()
	screen_dirty = false
end

function o.grid(as_proxies)
    g:all(2)
    local level = 0
    for x = 1, 8 do -- for each step
		for t = 1,2 do
			for y = 1,4 do
				-- top half
				if 5-y < as_proxies[t].repeats[x] then level = 5
				elseif 5-y == as_proxies[t].repeats[x] then level = 15
				else level = 0 end
				if level ~= 0 and x > as_proxies[t].len then
					level = 4
				end
				g:led(x+((t-1)*(8)),y,level)

				-- bottom half
				if 5-y < as_proxies[t].trig_modes[x] then level = 5
				elseif 5-y == as_proxies[t].trig_modes[x] then level = 15
				else level = 0 end
				if level ~= 0 and x > as_proxies[t].len then
					level = 4
				end
				g:led(x+(t-1)*8,y+4,level)
			end
		end
    end
	g:led(params:get('pos_1'),1,10)
	g:led(params:get('pos_2')+8,1,10) -- playheads

	local s = params:get('selector')
	if in_range(s,2,3) then
		local mod = s == 2 and 8 or 0
		local t = s - 1
		for x=1,8 do
			for y=1,8 do
				level = params:get('as_'..t) == (util.round_up(x/2) + (util.round_up(y/2)-1) * 4) and 15 or 4
				g:led(x+mod,y,level)
			end
		end
	end	
    
    g:refresh()
end

return o