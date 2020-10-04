local name, addon = ...

-- setup the options
local interface = CreateFrame("Frame", "TaunterinoConfig", UIParent)
interface:RegisterEvent("ADDON_LOADED")

-- toggle to allow users to prevent noise while in combat
local function onLoad(self, event, arg1)
    if name ~= arg1 then return
    end
    local inCombatButton = CreateFrame("CheckButton", "inCombatButton", interface, "OptionsBaseCheckButtonTemplate")
    inCombatButton:SetPoint("TOPLEFT", 20, -20);
    local inCombatButtonText = inCombatButton:CreateFontString("inCombatButtonText", "OVERLAY")
    inCombatButtonText:SetPoint("LEFT", 32, 1)
    inCombatButtonText:SetFont("Fonts\\FRIZQT__.TTF", 12)
    inCombatButtonText:SetText('Disable in Combat')
    inCombatButton.text = inCombatButtonText
    local function inCombatButtonToggleHandler(self)
        return
    end
    inCombatButton:SetScript("OnClick", inCombatButtonToggleHandler)

    interface.name = "Taunterino"
    InterfaceOptions_AddCategory(interface)
end
interface:SetScript("OnEvent", onLoad)

-- This handles the actual taunting
local frame = CreateFrame("Frame", "Taunterino")
frame:RegisterEvent("CHAT_MSG_GUILD")
local function guildMessageHandler(self, event, message, ...)
    local inCombatDisabled = inCombatButton:GetChecked()
    print(inCombatDisabled)
    if inCombatDisabled then
        if UnitAffectingCombat('player') then return 
        end
    end
    if (string.match(message, '^[0-9]+$'))
    then 
        local path = 'Interface/Addons/Taunterino/clips/' .. message .. '.mp3'
        PlaySoundFile(path, "Master")
    end
end
frame:SetScript("OnEvent", guildMessageHandler)