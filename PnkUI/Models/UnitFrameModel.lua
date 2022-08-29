local model = {
        name = "Unknown",
        health         = 0,
        max_health     = 0,
        health_percent = 0,
        power          = 0,
        max_power      = 0,
        power_percent  = 0,
        power_type     = 0,
};

function model.UpdateHealth(self, unit_id)
        self.health     = UnitHealth(unit_id);
        self.max_health = UnitHealthMax(unit_id);
        self.health_percent = self.health / self.max_health;

        return self;
end

function model.UpdatePower(self, unit_id)
        self.power      = UnitPower(unit_id);
        self.max_power  = UnitPowerMax(unit_id);
        self.power_percent = self.power / self.max_power;

        return self;
end

function model.UpdatePowerType(self, unit_id)
        self.power_type = UnitPowerType(unit_id);

        return self;
end

function model.UpdateName(self, unit_id)
        self.name = UnitName(unit_id);

        return self;
end

function model.UpdateAll(self, unit_id)
        self:UpdateName(unit_id);
        self:UpdateHealth(unit_id);
        self:UpdatePower(unit_id);
        self:UpdatePowerType(unit_id);

        return self;
end

PnkUI.PlayerFrameModel = PnkUI.CopyTable(model);
PnkUI.TargetFrameModel = PnkUI.CopyTable(model);
PnkUI.FocusFrameModel  = PnkUI.CopyTable(model);