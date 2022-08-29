function PnkUI.CopyTable(object, seen)
        seen = seen or {};

	if type(object) ~= 'table' then return object;       end
	if seen[object]            then return seen[object]; end

	local result = {};
	seen[object] = result;

	for k, v in next, object do
                result[PnkUI.CopyTable(k, seen)] = PnkUI.CopyTable(v, seen);
        end

	return setmetatable(result, getmetatable(object));
end