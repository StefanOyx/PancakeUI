local TEXTURE_PATH = "Interface\\AddOns\\PancakeUI\\Textures\\";

PnkUISettings = PnkUISettings or {
        bg_path   = TEXTURE_PATH .. "Background\\",
        edge_path = TEXTURE_PATH .. "Edge\\",
        icon_path = TEXTURE_PATH .. "Icons\\",

        colors = {
                UI        = WowColor.FromHex("090909"),
                textWhite = WowColor.FromHex("FFFFFF"),

                friendly  = WowColor.FromHex("29CC3C"),
                contested = WowColor.FromHex("E65010"),
                hostile   = WowColor.FromHex("E6222F"),
                sanctuary = WowColor.FromHex("00E8FC"),
        },
};

function PnkUI.AddComponent(component_data)
        if not component_data.settings.is_enabled then
                return nil;
        end

        local component = CreateFrame(
                component_data.widget_type,
                component_data.global_name,
                component_data.parent,
                component_data.inherits
        );

        local dimensions = component_data.settings.dimensions;
        local padding    = component_data.settings.padding;
        local anchor     = component_data.settings.anchor;
        local backdrop   = component_data.settings.backdrop;

        component:SetSize(
                dimensions.width  + padding.left + padding.right,
                dimensions.height + padding.top  + padding.bottom
        );

        component:SetPoint(
                anchor.point,
                anchor.relativeTo,
                anchor.relativePoint,
                anchor.offset_x,
                anchor.offset_y
        );

        component:SetBackdrop(backdrop);
        component:SetBackdropColor(backdrop.bg_color());
        component:SetBackdropBorderColor(backdrop.edge_color());

        return component;
end
