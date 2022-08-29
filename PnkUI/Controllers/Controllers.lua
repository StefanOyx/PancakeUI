function PnkUI.CreateController(data)
        if not data.settings.is_enabled then
                return nil, data.settings;
        end

        local controller = CreateFrame(
                data.widget_type or "Frame",
                data.global_name,
                data.parent,
                data.inherits
        );

        local dimensions = data.settings.dimensions;
	local padding    = data.settings.padding;
	local anchors    = data.settings.anchors;

        controller.model = data.parent[data.model_name];
        controller.view  = data.parent[data.view_name];

	controller:SetSize(
		dimensions.width  + padding.left + padding.right,
		dimensions.height + padding.top  + padding.bottom
	);

        controller:SetAllPoints(controller.view);

        for _, event in ipairs(data.events) do
                controller:RegisterEvent(event);
        end

        data.parent[data.local_name] = controller;
        return controller, data.settings;
end

function PnkUI.CreateSizerFor(controller, anchor_point, OnUpdate, SaveSettings)
        controller.sizers = controller.sizers or {};

        local sizer = CreateFrame("Button", nil, controller);
        sizer:SetPoint(anchor_point);
        sizer:SetSize(12, 12);
        sizer:SetScript("OnDragStart", function(self)
                local view = self:GetParent().view;
                view:StartSizing(anchor_point);
                view:SetScript("OnUpdate", OnUpdate);
        end);
        sizer:SetScript("OnDragStop", function(self)
                local controller = self:GetParent();
                local view       = controller.view;

                view:SetScript("OnUpdate", nil);
                view:StopMovingOrSizing(anchor_point);
                controller:SetAllPoints(view);

                SaveSettings(view);
        end);

        controller.sizers[anchor_point] = sizer;
end
