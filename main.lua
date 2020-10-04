
local interface = CreateFrame("Frame", "TaunterinoConfig", UIParent)

local inCombatButton = CreateFrame("CheckButton", "inCombatButton", interface, "OptionsBaseCheckButtonTemplate")
inCombatButton:SetPoint("TOPLEFT", 20, -20);
local inCombatButtonText = inCombatButton:CreateFontString("inCombatButtonText", "OVERLAY")
inCombatButtonText:SetPoint("LEFT", 32, 1)
inCombatButtonText:SetFont("Fonts\\FRIZQT__.TTF", 12)
inCombatButtonText:SetText('Disable in Combat')
inCombatButton.text = inCombatButtonText

interface.name = "Taunterino"
interface.okay = function()
    print("okay")
end
interface.cancel = function()
    print("cancel")
end
InterfaceOptions_AddCategory(interface)



-- This handles the actual taunting
local frame = CreateFrame("Frame", "Taunterino")
frame:RegisterEvent("CHAT_MSG_GUILD")
local function guildMessageHandler(self, event, message, ...)
    if (string.match(message, '^[0-9]+$'))
    then 
        local path = 'Interface/Addons/Taunterino/clips/' .. message .. '.mp3'
        PlaySoundFile(path, "Master")
    end
end
frame:SetScript("OnEvent", guildMessageHandler)