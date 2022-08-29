function PnkUI.PrettyPrint(value, key, depth)
        local key    = key or "";
        local depth  = depth or 0;
        local indent = string.rep("        ", depth);

        if type(value) == "table" then
                if key ~= "" then
                        print(("%s%s = {"):format(indent, key));
                else
                        print(("%s{"):format(indent));
                end

                for k, v in pairs(value) do
                        PnkUI.PrettyPrint(v, k, depth + 1);
                end

                print(("%s},"):format(indent));
        elseif type(value) == "string" then
                print(("%s%s = \"%s\","):format(indent, key, value));
        elseif type(value) == "number" then
                print(("%s%s = %d,"):format(indent, key, value));
        elseif type(value) == "boolean" then
                print(("%s%s = %s,"):format(indent, key, tostring(value)));
        end
end