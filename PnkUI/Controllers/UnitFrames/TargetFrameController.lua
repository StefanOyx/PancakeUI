local controller = PnkUI.CreateUnitFrameController({
        unit_id = "Target",
        parent  = PnkUI,
});

if not controller then
        return;
end

local OldHandler = controller:GetScript("OnEvent");

controller.view:Hide();
controller:RegisterEvent("PLAYER_TARGET_CHANGED");
controller:SetScript("OnEvent", function(self, event, ...)
        if event == "PLAYER_TARGET_CHANGED" then
                if UnitExists("Target") then
                        self.view:Show();
                        OldHandler(self, "PLAYER_ENTERING_WORLD");
                else
                        self.view:Hide();
                end
        else
                OldHandler(self, event, ...);
        end
end);

