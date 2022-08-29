local TEXTURE_PATH = "Interface\\AddOns\\PnkUI\\Textures\\";
local default      = {
        BG_PATH   = TEXTURE_PATH .. "Background\\",
        EDGE_PATH = TEXTURE_PATH .. "Edge\\",
        ICON_PATH = TEXTURE_PATH .. "Icons\\",

        colors = {
                UI_FOREGROUND = { r = 0.00, g = 0.00, b = 0.00, a = 0.75, },
                UI_BACKGROUND = { r = 0.19, g = 0.19, b = 0.19, a = 0.75, },

                TRANSPARENT = { r = 1, g = 1, b = 1, a = 0, },
                BLACK       = { r = 0, g = 0, b = 0, },
                WHITE	    = { r = 1, g = 1, b = 1, },
                DARK_GRAY   = { r = 0.35, g = 0.35, b = 0.35, },
                DARK_GREY   = { r = 0.35, g = 0.35, b = 0.35, },

                class = {
                        DEATHKNIGHT = { r = 0.7686, g = 0.1176, b = 0.2275, },
                        DRUID       = { r = 1.0000, g = 0.4863, b = 0.0392, },
                        HUNTER      = { r = 0.6667, g = 0.8275, b = 0.4471, },
                        MAGE        = { r = 0.2471, g = 0.7804, b = 0.9216, },
                        PALADIN     = { r = 0.9569, g = 0.5490, b = 0.7294, },
                        PRIEST      = { r = 1.0000, g = 1.0000, b = 1.0000, },
                        ROGUE       = { r = 1.0000, g = 0.9569, b = 0.4078, },
                        SHAMAN      = { r = 0.0000, g = 0.4392, b = 0.8667, },
                        WARLOCK     = { r = 0.5294, g = 0.5333, b = 0.9333, },
                        WARRIOR     = { r = 0.7765, g = 0.6078, b = 0.4275, },
                },
                power = {
                        MANA        = { r = 0.00, g = 0.00, b = 1.00, },
                        RAGE        = { r = 1.00, g = 0.00, b = 0.00, },
                        FOCUS       = { r = 1.00, g = 0.50, b = 0.25, },
                        ENERGY      = { r = 1.00, g = 1.00, b = 0.00, },
                        RUNIC_POWER = { r = 0.00, g = 0.82, b = 1.00, },
                },
                allegiance = {
                        FRIENDLY  = { r = 0.07, g = 0.50, b = 0.00, },
                        NEUTRAL   = { r = 0.75, g = 0.73, b = 0.07, },
                        CONTESTED = { r = 1.00, g = 0.84, b = 0.65, },
                        HOSTILE   = { r = 0.70, g = 0.00, b = 0.07, },
                        SANCTUARY = { r = 0.61, g = 0.96, b = 1.00, },
                },
        },
};

local add_on_name    = ...;
local event_listener = CreateFrame("Frame");
event_listener:RegisterEvent("ADDON_LOADED");
event_listener:SetScript("OnEvent", function(self, event, add_on)
        if add_on ~= add_on_name then
                return;
        end

        PnkUISettings = PnkUISettings or default;
end);
