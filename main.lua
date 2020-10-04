
local frame = CreateFrame("MessageFrame")
frame.name = "Taunterino"
InterfaceOptions_AddCategory(frame)
-- This handles the actual taunting
frame:RegisterEvent("CHAT_MSG_GUILD")
local function guildMessageHandler(self, event, message, ...)
    if (string.match(message, '^[0-9]+$'))
    then 
        local path = 'Interface/Addons/Taunterino/clips/' .. message .. '.mp3'
        PlaySoundFile(path, "Master")
    end
end
frame:SetScript("OnEvent", guildMessageHandler)