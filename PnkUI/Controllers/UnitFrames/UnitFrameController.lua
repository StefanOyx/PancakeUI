function PnkUI.CreateUnitFrameController(config)
        local controller, settings = PnkUI.CreateController({
                widget_type = "Button",
                model_name  = config.unit_id .. "FrameModel",
                view_name   = config.unit_id .. "FrameView",
                local_name  = config.unit_id .. "FrameController",
                global_name = "$parent_" .. config.unit_id .. "FrameController",
                parent      = config.parent,
                inherits    = "SecureUnitButtonTemplate",
                settings    = PnkUISettings[config.unit_id .. "Frame"],
                events      = {
                        "PLAYER_ENTERING_WORLD",
                        "UNIT_NAME_UPDATE",
                        "UNIT_HEALTH",
                        "UNIT_MAXHEALTH",
                        "UNIT_DISPLAYPOWER",
                        "UNIT_MANA",
                        "UNIT_RAGE",
                        "UNIT_FOCUS",
                        "UNIT_ENERGY",
                        "UNIT_RUNIC_POWER",
                        "UNIT_MAXMANA",
                        "UNIT_MAXRAGE",
                        "UNIT_MAXFOCUS",
                        "UNIT_MAXENERGY",
                        "UNIT_MAXRUNIC_POWER",
                },
        });

        if not controller then
                return controller, settings;
        end

        controller:SetScript("OnEvent", function(self, event, unit_id)
                if not (
                        event   == "PLAYER_ENTERING_WORLD" or
                        unit_id == config.unit_id:lower()
                ) or not self.view:IsShown() then
                        return;
                end

                if event == "PLAYER_ENTERING_WORLD" then
                        local data = self.model:UpdateAll(config.unit_id);
                        self.view:UpdateAll(data);
                elseif event == "UNIT_NAME_UPDATE" then
                        local data = self.model:UpdateName(unit_id);
                        self.view:UpdateName(data);
                elseif event == "UNIT_DISPLAYPOWER" then
                        local data = self.model:UpdatePowerType(unit_id);
                        self.view:UpdatePowerBarColor(data);
                elseif event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" then
                        local data = self.model:UpdateHealth(unit_id);
                        self.view:UpdateHealth(data);
                else
                        local data = self.model:UpdatePower(unit_id);
                        self.view:UpdatePower(data);
                end
        end);

        controller:EnableMouse(true);
        controller:RegisterForClicks("AnyUp");
        controller:SetScript("OnEnter", function(self)
                self.view.NameText:SetWidth(0.6667 * self.view:GetWidth());
                self.view.HealthText:Show();
        end);
        controller:SetScript("OnLeave", function(self)
                self.view.NameText:SetWidth(0.9167 * self.view:GetWidth());
                self.view.HealthText:Hide();
        end);
        controller:SetScript("OnDragStart", function(self)
                self.view:StartMoving();
        end);
        controller:SetScript("OnDragStop", function(self)
                self.view:StopMovingOrSizing();
                self:SetAllPoints(self.view);

                local point, _, relativePoint, offset_x, offset_y = self.view:GetPoint();

                settings.anchors[1] = {
                        point         = point,
                        relativePoint = relativePoint,
                        offset_x      = offset_x,
                        offset_y      = offset_y,
                };
        end);

        local function on_update(self)
                self.HealthBar:SetHeight(0.9167 * self:GetHeight());
                self. PowerBar:SetHeight(0.0833 * self:GetHeight());

                self.HealthText:SetHeight(0.9167 * self:GetHeight());
                self.  NameText:SetHeight(0.9167 * self:GetHeight());

                local data = controller.model:UpdateAll(config.unit_id);
                self:UpdateAll(data);
        end

        local function save(view)
                settings.dimensions.width  = view:GetWidth();
                settings.dimensions.height = view:GetHeight();
                settings.HealthBar.dimensions.height  = view.HealthBar:GetHeight();
                settings.PowerBar.dimensions.height   = view.PowerBar:GetHeight();
                settings.HealthText.dimensions.height = view.HealthText:GetHeight();
                settings.NameText.dimensions.height   = view.NameText:GetHeight();
        end

        PnkUI.CreateSizerFor(controller, "TOPLEFT", on_update, save);
        PnkUI.CreateSizerFor(controller, "TOPRIGHT", on_update, save);
        PnkUI.CreateSizerFor(controller, "BOTTOMRIGHT", on_update, save);
        PnkUI.CreateSizerFor(controller, "BOTTOMLEFT", on_update, save);

        SecureUnitButton_OnLoad(controller, config.unit_id, PnkUI.ToggleMovable);

        return controller, settings;
end
