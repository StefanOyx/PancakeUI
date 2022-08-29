local default = {
        is_enabled = true,
        dimensions = {
                width  = 144,
                height = 60,
        },
        padding = {
                top    = 0,
                right  = 0,
                bottom = 0,
                left   = 0,
        },
        anchors = {
                {
                        point         = "CENTER",
                        relativePoint = "CENTER",
                },
        },
        backdrop = {
                bgFile     = PnkUISettings.BG_PATH .. "Solid.tga",
                bg_color   = PnkUISettings.colors.UI_BACKGROUND,
        },
        colors_display_style = 1,
        health_display_style = 2,
};

default.HealthBar = {
        is_enabled = true,
        dimensions = {
                width  = default.dimensions.width,
                height = default.dimensions.height * 0.9167,
        },
        padding = {
                top    = 0,
                right  = 0,
                bottom = 0,
                left   = 0,
        },
        anchors = {
                {
                        point         = "TOPLEFT",
                        relativePoint = "TOPLEFT",
                },
        },
        color = PnkUISettings.colors.UI_FOREGROUND,
};

default.HealthText = {
        dimensions = {
                width  = default.HealthBar.dimensions.width * 0.9167,
                height = default.HealthBar.dimensions.height,
        },
        anchors = {
                {
                        point         = "TOPRIGHT",
                        relativePoint = "TOPRIGHT",
                        offset_x      = -6,
                        offset_y      = 0,
                },
        },
        font = {
                face  = 'Fonts\\FRIZQT__.TTF',
                size  = 10,
                style = nil,
                color = PnkUISettings.colors.WHITE,
        },
};

default.NameText = {
        dimensions = {
                width  = default.HealthBar.dimensions.width * 0.9167,
                height = default.HealthBar.dimensions.height,
        },
        anchors = {
                {
                        point         = "TOPLEFT",
                        relativePoint = "TOPLEFT",
                        offset_x      = 6,
                        offset_y      = 0,
                },
        },
        font = {
                face  = 'Fonts\\FRIZQT__.TTF',
                size  = 14,
                style = nil,
                color = PnkUISettings.colors.DARK_GRAY,
        },
};

default.PowerBar = {
        is_enabled = true,
        dimensions = {
                width  = default.dimensions.width,
                height = default.dimensions.height * 0.0833,
        },
        padding = {
                top    = 0,
                right  = 0,
                bottom = 0,
                left   = 0,
        },
        anchors = {
                {
                        point         = "BOTTOMLEFT",
                        relativePoint = "BOTTOMLEFT",
                },
        },
        color = PnkUISettings.colors.UI_FOREGROUND,
};

PnkUISettings.PlayerFrame = PnkUISettings.PlayerFrame or PnkUI.CopyTable(default);
PnkUISettings.TargetFrame = PnkUISettings.TargetFrame or PnkUI.CopyTable(default);
PnkUISettings.FocusFrame  = PnkUISettings.FocusFrame  or PnkUI.CopyTable(default);