PnkUISettings.minimap = PnkUISettings.minimap or {
        is_enabled = true,
        dimensions = {
                width  = 200,
                height = 200,
        },
        padding = {
                top    = 0,
                right  = 0,
                bottom = 0,
                left   = 0,
        },
        anchor = {
                point         = "TOPRIGHT",
                relativePoint = "TOPRIGHT",
                relativeTo    = PnkUI,
                offset_x      = 0,
                offset_y      = 0,
        },
        backdrop = {
                edgeFile = PnkUISettings.edge_path .. "MinimapEdge.tga",
                edgeSize = 4,
                insets =
                {
                        top    = 4,
                        right  = 4,
                        bottom = 4,
                        left   = 4,
                },

                edge_color = PnkUISettings.colors.UI,
                bg_color   = PnkUISettings.colors.UI, -- UNUSED
        }
};

local minimap = PnkUI.AddComponent({
        widget_type = "Frame",
        global_name = "PnkUI_Minimap",
        parent      = PnkUI,
        settings    = PnkUISettings.minimap,
});

if not minimap then return; end

PnkUI.minimap = minimap;

function PnkUI.minimap.HideBlizzardWidgets(self, settings)
        local widgets = {
                MinimapCluster,
                MinimapBackdrop,
                GameTimeFrame,
                TimeManagerClockButton,
        };

        for i, widget in ipairs(widgets) do
                widget.Show = function() end;
                widget:Hide();
        end

        Minimap:SetMaskTexture("Interface\\ChatFrame\\ChatFrameBackground");
end

function PnkUI.minimap.EmbedBlizzardMinimap(self)
        local dimensions = PnkUISettings.minimap.dimensions;
        local backdrop   = PnkUISettings.minimap.backdrop;

        Minimap:SetParent(self);
        Minimap:SetSize(
                dimensions.width  - 2 * backdrop.edgeSize,
                dimensions.height - 2 * backdrop.edgeSize
        );
        Minimap:SetPoint("CENTER");

        -- This is so that PnkUI_Minimap's children appear above the minimap.
        Minimap:SetFrameLevel(0);
end

PnkUI.minimap:HideBlizzardWidgets();
PnkUI.minimap:EmbedBlizzardMinimap();
