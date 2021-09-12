--[[---------------------------------------------------------------------------
        Locals
--]]---------------------------------------------------------------------------
WowColor = { 0, 0, 0, 1 };

function WowColor.Unpack(self, useAlpha)
        -- Set to true if nothing was passed.
        local useAlpha = useAlpha or useAlpha == nil;
        if useAlpha then
                return self[1], self[2], self[3], self[4];
        else
                return self[1], self[2], self[3];
        end
end

WowColor.__index = WowColor;
WowColor.__call  = WowColor.Unpack;

--[[---------------------------------------------------------------------------
        Hex
--]]---------------------------------------------------------------------------
function WowColor.FromHex(hex)
        if hex:len() == 8 then
                alpha = tonumber(hex:sub(7, 8), 16);
        else
                alpha = 255;
        end

        return setmetatable({
                tonumber(hex:sub(1, 2), 16) / 255,
                tonumber(hex:sub(3, 4), 16) / 255,
                tonumber(hex:sub(5, 6), 16) / 255,
                alpha / 255,
        }, WowColor);
end

--[[---------------------------------------------------------------------------
        RGBA
--]]---------------------------------------------------------------------------
function WowColor.FromRGBA(r, g, b, a)
        local a = a or 255;

        return setmetatable({
                r / 255,
                g / 255,
                b / 255,
                a / 255,
        }, WowColor);
end

function WowColor.Red(self)
        return math.floor(self[1] * 255);
end

function WowColor.Green(self)
        return math.floor(self[2] * 255);
end

function WowColor.Blue(self)
        return math.floor(self[3] * 255);
end

function WowColor.Alpha(self)
        return math.floor(self[4] * 255);
end
