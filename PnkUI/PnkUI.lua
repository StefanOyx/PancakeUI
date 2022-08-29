local event_listener = CreateFrame("Frame");
local add_on_name    = ...;

event_listener:RegisterEvent("ADDON_LOADED");
event_listener:SetScript("OnEvent", function(self, event, add_on)
        if add_on ~= add_on_name then
                return;
        end

        UpdateAddOnMemoryUsage();

        for i = 1, GetNumAddOns() do
                local name = GetAddOnInfo(i);
                local memory = GetAddOnMemoryUsage(i);

                if memory > 0 then
                        if memory > 1000 then
                                memory = ("%.2f MB"):format(memory / 1000);
                        else
                                memory = ("%.2f KB"):format(memory);
                        end
                        print(name, memory);
                end
        end
end)

function PnkUI.ToggleMovable(self, ...)
        if self.view:IsMovable() then
                self:RegisterForDrag();
                self.view:SetMovable(false);
                self.view:SetResizable(false);

                for _, sizer in pairs(self.sizers) do
                        sizer:RegisterForDrag();
                end
        else
                self:RegisterForDrag("LeftButton");
                self.view:SetMovable(true);
                self.view:SetResizable(true);

                for _, sizer in pairs(self.sizers) do
                        sizer:RegisterForDrag("LeftButton");
                end
        end
end

function PnkUI.UnitClassOrAllegianceColor(unit_id)
        if not UnitExists(unit_id) then
                return PnkUISettings.colors.TRANSPARENT;
        elseif UnitIsPlayer(unit_id) then
                return PnkUI.UnitClassColor(unit_id);
        else
                return PnkUI.UnitAllegianceColor(unit_id);
        end
end

function PnkUI.UnitClassColor(unit_id)
        local _, class = UnitClass(unit_id);
        return PnkUISettings.colors.class[class];
end

function PnkUI.UnitAllegianceColor(unit_id)
        if not UnitReaction("Player", unit_id) then
                return PnkUISettings.colors.DARK_GRAY;
        elseif UnitReaction("player", unit_id) <= 2 then
                return PnkUISettings.colors.allegiance.HOSTILE;
        elseif UnitReaction("player", unit_id) == 4 then
                return PnkUISettings.colors.allegiance.NEUTRAL;
        else
                return PnkUISettings.colors.allegiance.FRIENDLY;
        end
end