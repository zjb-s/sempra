o = {}

function o.as(n)
	return sequences[active_sequence[util.clamp(n,1,2)]] 
end -- "active sequence" getter sugar

function o.in_range(n, min, max) 
	if n >= min and n <= max then 
		return true 
	else
		return false
	end
end

return o