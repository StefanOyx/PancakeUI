function PnkUI.CreateView(data)
        if not data.settings.is_enabled then
		return nil, nil;
	end

        local view = CreateFrame(
                data.widget_type,
                data.global_name,
                data.parent,
                data.inherits
        );

        local dimensions = data.settings.dimensions;
	local padding    = data.settings.padding;
	local anchors    = data.settings.anchors;
	local backdrop   = data.settings.backdrop;

	view:SetSize(
		dimensions.width  + padding.left + padding.right,
		dimensions.height + padding.top  + padding.bottom
	);

        for _, anchor in ipairs(anchors) do
                view:SetPoint(
                        anchor.point,
                        data.parent,
                        anchor.relativePoint,
                        anchor.offset_x,
                        anchor.offset_y
                );
        end

	view:SetBackdrop(backdrop);

	if backdrop and backdrop.bg_color then
		view:SetBackdropColor(
                        backdrop.bg_color.r,
                        backdrop.bg_color.g,
                        backdrop.bg_color.b,
                        backdrop.bg_color.a);
	end

	if backdrop and backdrop.edge_color then
		view:SetBackdropBorderColor(
                        backdrop.edge_color.r,
                        backdrop.edge_color.g,
                        backdrop.edge_color.b,
                        backdrop.edge_color.a);
	end

        view:SetClampedToScreen(true);

        data.parent[data.local_name] = view;

        return view, data.settings;
end
