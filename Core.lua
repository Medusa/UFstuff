---------------------------------------------------------------------------------------------------------------
-- ********************************************************************************************************* --
---------------------------------------------------------------------------------------------------------------
-- DON'T TOUCH THE CODES BELOW IF YOU DON'T KNOWN WHAT TO DO! -------------------------------------------------
---------------------------------------------------------------------------------------------------------------
local config = UFScripts .config
---------------------------------------------------------------------------------------------------------------
-- Enable class colors health bars (excluded NPCs and mobs)----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
if config.class_colors_hb == true then
	local function colour(statusbar, unit)
		local _, class, c
		if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit) then
			_, class = UnitClass(unit)
			c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
			statusbar:SetStatusBarColor(c.r, c.g, c.b)
		end
	end
	hooksecurefunc("UnitFrameHealthBar_Update", colour)
	hooksecurefunc("HealthBar_OnValueChanged", function(self)
		colour(self, self.unit)
	end)
end
---------------------------------------------------------------------------------------------------------------
-- Enable player class icon portrait --------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
if config.player_class_icon == true then
	hooksecurefunc("UnitFramePortrait_Update",function(self)
	if self.unit ~= "player" then return end
		if self.portrait then        
			local p = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
			if p then
				self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
				self.portrait:SetTexCoord(unpack(p))
			end
		else
			self.portrait:SetTexCoord(0,1,0,1)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------
-- Enable pet class icon portrait -----------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
if config.pet_class_icon == true then
	hooksecurefunc("UnitFramePortrait_Update",function(self)
	if self.unit ~= "pet" then return end
		if self.portrait then               
			local p = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
			if p then
				self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
				self.portrait:SetTexCoord(unpack(p))
			end
		else
			self.portrait:SetTexCoord(0,1,0,1)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------
-- Enable focus and target class icons portraits (excluded NPCs and mobs) -------------------------------------
---------------------------------------------------------------------------------------------------------------
if config.class_icons == true then
	hooksecurefunc("UnitFramePortrait_Update",function(self)
	if self.unit == "player" or self.unit == "pet" then return end
		if self.portrait then
			if UnitIsPlayer(self.unit) then                      
				local p = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
				if p then
					self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
					self.portrait:SetTexCoord(unpack(p))
				end
			else
				self.portrait:SetTexCoord(0,1,0,1)
			end
		end
	end)
end
---------------------------------------------------------------------------------------------------------------
-- Disable combat text over player portrait -------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
if config.player_portrait_spam == true then
	PlayerHitIndicator:SetText(nil)
	PlayerHitIndicator.SetText = function() end
end
---------------------------------------------------------------------------------------------------------------
-- Disable combat text over pet portrait ----------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
if config.pet_portrait_spam == true then
	PetHitIndicator:SetText(nil)
	PetHitIndicator.SetText = function() end
end
---------------------------------------------------------------------------------------------------------------
-- Disable group number frame ---------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
if config.disable_number == true then
	PlayerFrameGroupIndicator.Show = function() return end
end
---------------------------------------------------------------------------------------------------------------
-- Enable a flashy spellsteal border for non-mages characters and/or for enrage effects -----------------------
---------------------------------------------------------------------------------------------------------------
if config.flashy_border == true then
	hooksecurefunc("TargetFrame_UpdateAuras", function(s)
		for i = 1, MAX_TARGET_BUFFS do
			_, _, ic, _, dT = UnitBuff(s.unit, i)
			if(ic and (not s.maxBuffs or i<=s.maxBuffs)) then
				fS=_G[s:GetName()..'Buff'..i..'Stealable']
				if(UnitIsEnemy(PlayerFrame.unit, s.unit) and dT=='Magic') then
						fS:Show()
				else
						fS:Hide()
				end
			end
		end
	end)
end
---------------------------------------------------------------------------------------------------------------
-- Hide player PvP faction icon -------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
if config.hide_player_icon == true then
	PlayerPVPIcon:SetAlpha(0)
end
---------------------------------------------------------------------------------------------------------------
-- Hide target PvP faction icon ------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
if config.hide_target_icon == true then
	TargetFrameTextureFramePVPIcon:SetAlpha(0)
end
---------------------------------------------------------------------------------------------------------------
-- Hide focus PvP faction icon --------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
if config.hide_focus_icon == true then
	FocusFrameTextureFramePVPIcon:SetAlpha(0)
end
---------------------------------------------------------------------------------------------------------------
-- New slash command to reload the UI -------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
SlashCmdList.RELOADUI = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"
---------------------------------------------------------------------------------------------------------------
-- A big thank to Thaya for http://www.arenajunkies.com/topic/222642-default-ui-scripts/ ----------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
-- ********************************************************************************************************* --
---------------------------------------------------------------------------------------------------------------