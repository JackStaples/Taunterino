
local interface = CreateFrame("Frame", "TaunterinoConfig", UIParent)

local inCombatButton = CreateFrame("CheckButton", "inCombatButton", interface, "OptionsBaseCheckButtonTemplate")
inCombatButton:SetPoint("TOPLEFT", 0, 0);
--inCombatButton_GlobalNameText:SetText("Disable in Combat");
--getglobal(inCombatButton:GetName() .. 'Text'):SetText("CheckBox Name");
print(inCombatButton)

interface.name = "Taunterino"
interface.okay = function()
    print("Okay")
end
interface.cancel = function()
    print("Canceling")
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