addonNameForChat = "|cffffff00CharacterNotes:|r"
print(addonNameForChat, "Чтобы открыть заметки, напишите команду /cnotes")

Core = CreateFrame("Frame", "CharacterNotes", UIParent)
Core:SetSize(500, 300)
Core:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
Core.texture = Core:CreateTexture()
Core.texture:SetAllPoints(Core)
Core.texture:SetTexture(0, 0, 0, 0.8)
Core:SetMovable(true)
Core:EnableMouse(true)
Core:RegisterForDrag("LeftButton")
Core:SetScript("OnDragStart", Core.StartMoving)
Core:SetScript("OnDragStop", Core.StopMovingOrSizing)
Core:SetBackdrop(
    {
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = {left = 4, right = 4, top = 4, bottom = 4}
    }
)
Core:SetBackdropColor(0, 0, 0, 0)
Core:SetScript(
    "OnHide",
    function()
        FrameHidden = true
    end
)
Core:RegisterEvent("PLAYER_LOGIN")
Core:RegisterEvent("PLAYER_LOGOUT")
Core:SetScript(
    "OnEvent",
    function(self, event, ...)
        return self[event](self, ...)
    end
)

CloseButton = CreateFrame("Button", "CloseButton", Core, "UIPanelCloseButton")
CloseButton:SetPoint("TOPRIGHT", Core, "TOPRIGHT", -2, -5)
CloseButton:SetSize(30, 30)
PlayerName = UnitName("player")
PlayerNameLength = strlenutf8(PlayerName) * 12
CharacterNoteButton = CreateFrame("Button", "CharacterNoteButton", Core, "UIPanelButtonTemplate")
CharacterNoteButton:SetText(PlayerName)
CharacterNoteButton:Disable()
CharacterNoteButton:SetPoint("TOPLEFT", Core, "TOPLEFT", 10, -5)
CharacterNoteButton:SetSize(PlayerNameLength, 30)
CharacterNoteButton:SetScript(
    "OnClick",
    function()
        CharacterNoteScrollFrame:Show()
        CharacterNoteButton:Disable()
        GlobalNoteScrollFrame:Hide()
        GlobalNoteButton:Enable()

    end
)

CharacterNoteText = CreateFrame("EditBox", "CharacterNoteText", Core)
CharacterNoteText:SetMultiLine(true)
CharacterNoteText:SetAutoFocus(false)
CharacterNoteText:SetMaxLetters(99999)
CharacterNoteText:EnableMouse(true)
CharacterNoteText:SetFont("Fonts\\FRIZQT__.TTF", 11)
CharacterNoteText:SetSize(255, 255)
CharacterNoteText:SetScript(
    "OnEscapePressed",
    function(self)
        self:ClearFocus()
    end
)
CharacterNoteText:SetScript(
    "OnEditFocusLost",
    function(self)
        CharacterNote = self:GetText()
    end
)

CharacterNoteScrollFrame = CreateFrame("ScrollFrame", "CharacterNoteScrollFrame", Core, "UIPanelScrollFrameTemplate")
CharacterNoteScrollFrame:SetPoint("TOPLEFT", Core, "TOPLEFT", 12, -40)
CharacterNoteScrollFrame:SetPoint("BOTTOMRIGHT", Core, "BOTTOMRIGHT", -30, 12)
CharacterNoteScrollFrame:SetScrollChild(CharacterNoteText)
CharacterNoteScrollFrame:EnableMouse(true)
CharacterNoteScrollFrame:SetScript(
    "OnMouseDown",
    function()
        CharacterNoteText:SetFocus()
    end
)

Core:Hide()

SLASH_CNOTES1 = "/cnotes"
FrameHidden = true
SlashCmdList["CNOTES"] = function()
    if FrameHidden then
        Core:Show()
        if CharacterNote ~= nil then
            CharacterNoteText:SetText(CharacterNote)
        end
        if GlobalNote ~= nil then
            GlobalNoteText:SetText(GlobalNote)
        end
        FrameHidden = false
    else
        Core:Hide()
        FrameHidden = true
    end
end
