g = grid.connect()
param_initalizer = include('lib/params')
render = include('lib/render')
_16n = include("lib/_16n")
function g.add() grid_dirty = true end

grid_dirty = true
screen_dirty = true
shift = false
tracks = {}
sequences = {}
faders = {}


function init()
	param_initalizer.go()
        _16n.init(faderbank_event)

    for i=1,16 do
		table.insert(sequences, {
			vals = {64,64,64,64,64,64,64,64}
		,	trig_modes = {2,2,2,2,2,2,2,2}
		,	repeats = {1,1,1,1,1,1,1,1}
		,	len = 1
		})
	end
    clock.run(stepper)
    clock.run(redraw_timer)
end

function as(n)
	return sequences[params:get('as_'..util.clamp(n,1,2))]
end -- "active sequence" getter sugar

function in_range(n, min, max)
	if n >= min and n <= max then
		return true
	else
		return false
	end
end

function play_note(note,out,trigmode,len)
	note = note / 12
	local velocity = 10
	if 		out <= 16 then -- midi out
		-- todo implement midi out
	elseif	in_range(out,17,20) then 				-- wsyn mono
		crow.ii.wsyn.vox(out-16,note,velocity)
	elseif 	out == 21 then 							-- wsyn poly
		crow.ii.wsyn.note(note,velocity)
	elseif	in_range(out,22,27) then				-- jf mono
		crow.ii.jf.vox(out-21,note,velocity)
	elseif	out == 28 then							-- jf poly
		crow.ii.jf.note(note,velocity)
	elseif	in_range(out,29,30) then				-- crow cv/gate
		-- print('crow out')
		local cv_channel = out==29 and 1 or 3
		crow.output[cv_channel].volts = note
		crow.output[cv_channel+1].volts = 10
		clock.sleep(len/1000)
		if (trigmode ~= 4) then crow.output[cv_channel+1].volts = 0 end
	end
end

function redraw_timer()
    clock.sleep(0.5)
    while true do
        clock.sleep(1/30)
        if grid_dirty then render.grid({as(1),as(2)},tracks); grid_dirty = false end
		if screen_dirty then redraw() end
    end
end

function redraw() render.screen({as(1),as(2)},tracks) end
-- redraw() namespace is treated specially by norns, this makes it pause when the menu is open etc

function stepper()
    clock.sleep(0.5)
    while true do
        clock.sync(1/4) -- 16ths
        grid_dirty = true
		screen_dirty = true
		for t=1,2 do
			if math.abs(params:get('division_'..t)) > params:get('clock_counter_'..t) then
				params:delta('clock_counter_'..t,1)
			else
				params:set('clock_counter_'..t,1)
				params:delta('step_counter_'..t,1)
				if params:get('step_counter_'..t) > as(t).repeats[params:get('pos_'..t)] then
					params:set('step_counter_'..t,1)
					params:delta('pos_'..t,1)
				end
				if (params:get('pos_'..t) > as(t).len) then params:set('pos_'..t,1) end
				if	(as(t).trig_modes[params:get('pos_'..t)] ~= 1 and	params:get('step_counter_'..t) == 1)
				or	(as(t).trig_modes[params:get('pos_'..t)] == 3 and	params:get('step_counter_'..t) > 1)
				then
					local note = as(t).vals[params:get('pos_'..t)]
					note = note + params:get('transpose_'..t)
					note = util.linlin(0, 127, 0, params:get('range_'..t), note)
					note = mu.snap_note_to_array(note,mu.generate_scale(params:get('root_'..t),params:get('scale_'..t),10))

					local out = params:get('output_'..t)
					local trigmode = as(t).trig_modes[params:get('pos_'..t)]
					local len = params:get('gate_len_'..t)
					clock.run(play_note,note,out,trigmode,len)
				end
			end
		end
    end
end

function faderbank_event(d)
	screen_dirty = true
    local slider_id = _16n.cc_2_slider_id(d.cc)
	local seqnum; local mod
	if slider_id <= 8 then
          seqnum = 1; mod = 0
	else
          seqnum = 2; mod = -8
	end
        as(seqnum).vals[slider_id+mod] = d.val
end

function enc(n,d)
	screen_dirty = true
	grid_dirty = true
	local t = n-1
	if		n == 1 then
		params:delta('gate_len_'..(shift and 1 or 2), d)
	elseif	in_range(n,2,3) then
		if shift then
			params:delta('division_'..t,d)
		else
			as(t).len = util.clamp(as(t).len + d,1,8)
		end
	elseif	n == 4 then
		params:delta('gate_len_2')
	end
end

function key(n,d)
	screen_dirty = true
	grid_dirty = true
	if n == 1 then
		shift = d == 1
	elseif in_range(n,2,3) and d == 1 then
		params:set('selector', params:get('selector')==n and 1 or n)
		for t=1,2 do
			if params:get('selector') ~= t+1 then params:set('latch_'..t, 0) end
		end
	end
end

function g.key(x,y,z)
	if params:get('selector') == 1 then
		for i=1,2 do params:set('latch_'..i,0) end
	end
    grid_dirty = true
	screen_dirty = true
    if z == 1 then
		local t = x <= 8 and 1 or 2
		local mod = t == 2 and -8 or 0
		local selector = params:get('selector')
		local selx = 0; local sely = 0
		if 	selector == 1
		or	(selector == 2 and t == 1)
		or 	(selector == 3 and t == 2)
		then
			--as(t).repeats[x+mod] = 5 - y
			if y <= 4 then
				as(t).repeats[x+mod] = 5 - y
			elseif y >= 5 then
				as(t).trig_modes[x+mod] = 9 - y
			end
		elseif (selector == 2 and x >= 9) or (selector == 3 and x <= 8) then
			selx = util.round_up(x/2)
			if selector == 2 then selx = selx - 4 end
			sely = util.round_up(y/2)
			t = t == 1 and 2 or 1
			print('selected sequence '..selx+(sely-1)*4 .. ' on track ' .. t)
			params:set('as_'..t, selx+(sely-1)*4)
			if shift and params:get('selector') ~= 1 then params:set('latch_'..t,1) end
			if params:get('latch_'..t) == 0 then params:set('selector',1) end
		end
    end
end
