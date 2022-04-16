mu = require('musicutil')
o = {}

output_options = {
	'midi channel 1'
,	'midi channel 2'
,	'midi channel 3'
,	'midi channel 4'
,	'midi channel 5'
,	'midi channel 6'
,	'midi channel 7'
,	'midi channel 8'
,	'midi channel 9'
,	'midi channel 10'
,	'midi channel 11'
,	'midi channel 12'
,	'midi channel 13'
,	'midi channel 14'
,	'midi channel 15'
,	'midi channel 16'
,	'w/syn voice 1'
,	'w/syn voice 2'
,	'w/syn voice 3'
,	'w/syn voice 4'
,	'w/syn polyphonic'
,	'just friends voice 1'
,	'just friends voice 2'
,	'just friends voice 3'
,	'just friends voice 4'
,	'just friends voice 5'
,	'just friends voice 6'
,	'just friends polyphonic'
,	'crow cv/g 1/2'
,	'crow cv/g 3/4'
,	'transpose sequence 1'
,	'transpose sequence 2'
}

scale_table = {}
for i=1,#mu.SCALES do
	table.insert(scale_table, mu.SCALES[i].name)
end

function o.go()
	params:add_separator('global')
	params:add{
		type	=	'option'
	,	id 		=	'selector'
	,	name	=	'selector pane'
	,	options =	{'off', 'sequence 1', 'sequence 2'}
	,	default	=	1
	}
	params:add{
		type	=	'number'
	,	id		=	'quantize'
	,	name	=	'phrase switch'
	,	min		=	0
	,	max		=	1
	,	default	=	0
	,	formatter = function(v) return (v.value==1 and 'at end' or 'immediately') end
	}
	for i=1,2 do
		params:add_separator('track ' .. i)
		params:add{
			type	=	'number'
		,	id		=	'clock_counter_'..i
		,	name	=	'clock counter'
		,	min		=	1
		,	max		=	8
		,	default	=	1
		}
		params:hide(params.lookup['clock_counter_'..i])
		params:add{
			type	=	'number'
		,	id		=	'step_counter_'..i
		,	name	=	'step counter'
		,	min		=	1
		,	max		=	9
		,	default	=	1
		}
		params:hide(params.lookup['step_counter_'..i])
		params:add{
			type	=	'binary'
		,	id		=	'latch_'..i
		,	name	=	'latch selector'
		,	behavior = 	'toggle'
		}
		params:hide(params.lookup['latch_'..i])
		params:add{
			type	=	'number'
		,	id		=	'qd_'..i
		,	name	=	'queued sequence'
		,	min		=	0
		,	max		=	16
		,	default	=	0
		}
		params:add{
			type 	=	'option'
		,	id		=	'output_'..i
		,	name	=	'output'
		,	options	=	output_options
		,	default	=	i==1 and 29 or 30
		}
		params:add{
			type	=	'number'
		,	id		=	'as_'..i
		,	name 	=	'active sequence'
		,	min		=	1
		,	max		=	16
		,	default	=	(i == 1) and 1 or 16
		}
		params:add{
			type	=	'number'
		,	id		=	'pos_'..i
		,	name	=	'position'
		,	min		=	1
		,	max		=	8
		,	default	=	1
		,	wrap	=	true -- important!
		}
		params:hide(params.lookup['pos_'..i])
		params:add{
			type	=	'number'
		,	id		=	'division_'..i
		,	name 	=	'clock division'
		,	min 	=	-8
		,	max		=	-1
		,	default	=	-i
		,	formatter = function(n) return '/'..math.abs(n.value) end
		}
		params:add{
			type 	=	'number'
		,	id		=	'transpose_'..i
		,	name	=	'transpose'
		,	min		=	-24
		,	max		=	24
		,	default	=	0
		,	formatter = function(n)
				local char = n.value >= 0 and '+' or '-'
				return char..math.abs(n.value)
		end
		}
		params:add{
			type	=	'number'
		,	id		=	'range_'..i
		,	name	=	'fader range'
		,	min		=	1
		,	max		=	127
		,	default	=	48
		,	formatter = function(n)
				return n.value..' semitones'
			end
		}
		params:add{
			type	=	'number'
		,	id		=	'root_'..i
		,	name	=	'root note'
		,	min		=	0
		,	max		=	11
		,	default	=	0
		,	formatter = function(n) 
				local str = mu.note_num_to_name(n.value, true)
				return string.sub(str,1,-3)
			end
		,	
		}
		params:add{
			type	=	'option'
		,	id		=	'scale_'..i
		,	name	=	'scale'
		,	options	=	scale_table
		,	default	=	5
		}
		params:add{
			type	=	'number'
		,	id		=	'gate_len_'..i
		,	name	=	'gate length'
		,	min		=	1
		,	max		=	1000
		,	default	=	5
		,	formatter = function(n) return n.value..' ms' end
		}
	end
end

_menu.rebuild_params()
return o