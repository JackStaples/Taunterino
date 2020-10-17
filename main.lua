local name, addon = ...

-- setup the options
local interface = CreateFrame("Frame", "TaunterinoConfig", UIParent)
interface:RegisterEvent("ADDON_LOADED")

local function createCheckButton()
    return CreateFrame("CheckButton", nil, interface, "OptionsBaseCheckButtonTemplate")
end

local function addLabelToInterfaceOption(button, label)
    local buttonText = button:CreateFontString("inCombatButtonText", "OVERLAY")
    buttonText:SetPoint("LEFT", 32, 1)
    buttonText:SetFont("Fonts\\FRIZQT__.TTF", 12)
    buttonText:SetText(label)
    button.text = inCombatButtonText
end

local function addButtonToggleHandle(button, saved_variable)
    button:SetChecked(_G[saved_variable])
    local function toggleHandler(self)
        if _G[saved_variable] == true 
        then 
            _G[saved_variable] = false
        else 
            _G[saved_variable] = true
        end
    end
    button:SetScript("OnClick", toggleHandler)
end

local function addInterfaceToggleButton(yPosition, label, saved_variable)
    local inCombatButton = createCheckButton()
    inCombatButton:SetPoint("TOPLEFT", 20, yPosition);
    addLabelToInterfaceOption(inCombatButton, label)
    addButtonToggleHandle(inCombatButton, saved_variable)
end

local function makeSureGlobalIsSet(saved_variable)
    if _G[saved_variable] == nil
    then _G[saved_variable] = false
    end
end

local function checkForInitialLoad()
    makeSureGlobalIsSet("DisabledInCombat")
    makeSureGlobalIsSet("DisabledInWorld")
    makeSureGlobalIsSet("DisabledInBattleground")
    makeSureGlobalIsSet("DisabledInDungeon")
    makeSureGlobalIsSet("DisabledInRaid")
    makeSureGlobalIsSet("DisabledInArena")
end
-- toggle to allow users to prevent noise while in combat
local function onLoad(self, event, arg1)
    if name ~= arg1 then return
    end

    local interfaceTitle = interface:CreateFontString("interfaceTitleText", "OVERLAY")
    interfaceTitle:SetPoint("TOPLEFT", 15, -15)
    interfaceTitle:SetFont("Fonts\\FRIZQT__.TTF", 16)
    interfaceTitle:SetText("Taunterino")
    interfaceTitle:SetTextColor(1, 0.80, 0.20, 1.0);

    local interfaceDescription = interface:CreateFontString("interfaceDescriptText", "OVERLAY")
    interfaceDescription:SetPoint("TOPLEFT", 15, -37)
    interfaceDescription:SetFont("Fonts\\FRIZQT__.TTF", 10)
    interfaceDescription:SetText("Configuration options to customize your taunting experience")

    local disableTitle = interface:CreateFontString("disableTitle", "OVERLAY")
    disableTitle:SetPoint("TOPLEFT", 15, -75)
    disableTitle:SetFont("Fonts\\FRIZQT__.TTF", 12)
    disableTitle:SetText("Mute taunts while in:")
    disableTitle:SetTextColor(1, 0.80, 0.20, 1.0);

    local line = interface:CreateLine()
    line:SetColorTexture(1,1,1,1)
    line:SetStartPoint("TOPLEFT",15, -93)
    line:SetEndPoint("TOPRIGHT",-15, -93)
    line:SetThickness(0.5)

    checkForInitialLoad()

    
    local buttonYBeginning = -100
    addInterfaceToggleButton(buttonYBeginning, 'Combat', 'DisabledInCombat')
    addInterfaceToggleButton(buttonYBeginning - 25, 'World', 'DisabledInWorld')
    addInterfaceToggleButton(buttonYBeginning - 50, 'Battleground', 'DisabledInBattleground')
    addInterfaceToggleButton(buttonYBeginning - 75, 'Dungeon', 'DisabledInDungeon')
    addInterfaceToggleButton(buttonYBeginning - 100, 'Raid', 'DisabledInRaid')
    addInterfaceToggleButton(buttonYBeginning - 125, 'Arena', 'DisabledInArena')
    
    interface.name = "Taunterino"
    interface.title = "Taunterino"
    InterfaceOptions_AddCategory(interface)
end
interface:SetScript("OnEvent", onLoad)

local function shouldPlay()
    if DisabledInCombat then
        if UnitAffectingCombat('player') then return false
        end
    end
    local inInstance, instanceType = IsInInstance()
    if (DisabledInWorld) then
        if instanceType == "none" then return false
        end
    end
    if (DisabledInBattleground) then
        if instanceType == "pvp" then return false
        end
    end
    if (DisabledInDungeon) then
        if instanceType == "party" then return false
        end
    end
    if (DisabledInRaid) then
        if instanceType == "raid" then return false
        end
    end
    if (DisabledInArena) then
        if instanceType == "arena" then return false
        end
    end
    return true
end

-- This handles the actual taunting
local frame = CreateFrame("Frame", "Taunterino")
frame:RegisterEvent("CHAT_MSG_GUILD")
local function guildMessageHandler(self, event, message, ...)
    if shouldPlay() then
        if (string.match(message, '^[0-9]+$'))
        then 
            local path = 'Interface/Addons/Taunterino/clips/' .. message .. '.mp3'
            PlaySoundFile(path, "Master")
        end
    end
end
frame:SetScript("OnEvent", guildMessageHandler)