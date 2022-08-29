local power_type_color_map = {
        [0] = PnkUISettings.colors.power.MANA,
        [1] = PnkUISettings.colors.power.RAGE,
        [2] = PnkUISettings.colors.power.FOCUS,
        [3] = PnkUISettings.colors.power.ENERGY,
        [6] = PnkUISettings.colors.power.RUNIC_POWER
};

function PnkUI.CreateUnitFrameView(config)
        local view, settings = PnkUI.CreateView({
                widget_type = config.widget_type or "Frame",
                global_name = "$parent_" .. config.unit_id .. "FrameView",
                local_name  = config.unit_id .. "FrameView",
                parent      = config.parent,
                settings    = PnkUISettings[config.unit_id .. "Frame"],
        });

        if not view then
                return view;
        end

        do -- Health bar
                local settings = settings.HealthBar;

                view.HealthBar = view:CreateTexture(
                        "$parent_HealthBar",
                        "ARTWORK"
                );

                for _, anchor in ipairs(settings.anchors) do
                        view.HealthBar:SetPoint(
                                anchor.point,
                                view.HealthBar:GetParent(),
                                anchor.relativePoint,
                                anchor.offset_x,
                                anchor.offset_y
                        );
                end

                view.HealthBar:SetSize(
                        settings.dimensions.width,
                        settings.dimensions.height
                );
                view.HealthBar:SetTexture(
                        settings.color.r,
                        settings.color.g,
                        settings.color.b,
                        settings.color.a
                );
        end

        do -- Health text
                local settings = settings.HealthText;

                view.HealthText = view:CreateFontString(
                        "$parent_HealthText",
                        "OVERLAY",
                        "GameTooltipText"
                );

                for _, anchor in ipairs(settings.anchors) do
                        view.HealthText:SetPoint(
                                anchor.point,
                                view,
                                anchor.relativePoint,
                                anchor.offset_x,
                                anchor.offset_y
                        );
                end

                view.HealthText:SetHeight(view.HealthBar:GetHeight());
                view.HealthText:SetFont(
                        settings.font.face,
                        settings.font.size,
                        settings.font.style
                );
                view.HealthText:SetTextColor(
                        settings.font.color.r,
                        settings.font.color.g,
                        settings.font.color.b,
                        settings.font.color.a
                );

                view.HealthText:Hide();
        end

        do -- Name text
                local settings = settings.NameText;

                view.NameText = view:CreateFontString(
                        "$parent_NameText",
                        "OVERLAY",
                        "GameTooltipText"
                );

                for _, anchor in ipairs(settings.anchors) do
                        view.NameText:SetPoint(
                                anchor.point,
                                view,
                                anchor.relativePoint,
                                anchor.offset_x,
                                anchor.offset_y
                        );
                end

                view.NameText:SetSize(
                        0.9167 * view:GetWidth(),
                        0.9167 * view:GetHeight()
                );
                view.NameText:SetFont(
                        settings.font.face,
                        settings.font.size,
                        settings.font.style
                );
                view.NameText:SetTextColor(
                        settings.font.color.r,
                        settings.font.color.g,
                        settings.font.color.b,
                        settings.font.color.a
                );

                view.NameText:SetWordWrap(false);
                view.NameText:SetNonSpaceWrap(false);
        end

        do -- Power bar
                local settings = settings.PowerBar;

                view.PowerBar = view:CreateTexture(
                        "$parent_PowerBar",
                        "ARTWORK"
                );

                for _, anchor in ipairs(settings.anchors) do
                        view.PowerBar:SetPoint(
                                anchor.point,
                                view.PowerBar:GetParent(),
                                anchor.relativePoint,
                                anchor.offset_x,
                                anchor.offset_y
                        );
                end
                view.PowerBar:SetSize(
                        settings.dimensions.width,
                        settings.dimensions.height
                );
                view.PowerBar:SetTexture(
                        settings.color.r,
                        settings.color.g,
                        settings.color.b,
                        settings.color.a
                );
        end

        if settings.colors_display_style == 1 then
                function view.UpdateName(self, data)
                        local c = PnkUI.UnitClassOrAllegianceColor(config.unit_id);
                        self.NameText:SetText(data.name);
                        self.NameText:SetTextColor(c.r, c.g, c.b, c.a);
                end
        elseif settings.colors_display_style == 3 then
                function view.UpdateName(self, data)
                        local c = PnkUI.UnitAllegianceColor(config.unit_id);
                        self.NameText:SetText(data.name);
                        self.NameText:SetTextColor(c.r, c.g, c.b, c.a);
                end
        else
                function view.UpdateName(self, data)
                        self.NameText:SetText(data.name);
                end
        end

        if settings.colors_display_style == 2 then
                function view.UpdateHealthBar(self, data)
                        local c = PnkUI.UnitClassOrAllegianceColor(config.unit_id);
                        self.HealthBar:SetPoint(
                                "RIGHT", self, "LEFT",
                                self:GetWidth() * data.health_percent, 0
                        );
                        self.HealthBar:SetTexture(c.r, c.g, c.b, c.a);
                end
        else
                function view.UpdateHealthBar(self, data)
                        self.HealthBar:SetPoint(
                                "RIGHT", self, "LEFT",
                                self:GetWidth() * data.health_percent, 0);
                end
        end

        if settings.health_display_style == 0 then
                function view.UpdateHealthText(self, data)
                        self.HealthText:SetText(data.health);
                end
        elseif settings.health_display_style == 1 then
                function view.UpdateHealthText(self, data)
                        self.HealthText:SetText(
                                ("%d/%d"):format(data.health, data.max_health)
                        );
                end
        else
                function view.UpdateHealthText(self, data)
                        self.HealthText:SetText(
                                ("%d%%"):format(100 * data.health_percent)
                        );
                end
        end

        function view.UpdateHealth(self, data)
                self:UpdateHealthBar(data);
                self:UpdateHealthText(data);
        end

        function view.UpdatePowerBar(self, data)
                self.PowerBar:SetPoint(
                        "RIGHT", self, "LEFT",
                        self:GetWidth() * data.power_percent, 0);
        end

        function view.UpdatePowerBarColor(self, data)
                local c = power_type_color_map[data.power_type];
                self.PowerBar:SetTexture(c.r, c.g, c.b, c.a);
        end

        function view.UpdatePower(self, data)
                self:UpdatePowerBar(data);
                self:UpdatePowerBarColor(data);
        end


        function view.UpdateAll(self, data)
                self:UpdateName(data);
                self:UpdateHealth(data);
                self:UpdatePower(data);
        end

        return view;
end
