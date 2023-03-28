GlobalNoteButton = CreateFrame("Button", "GlobalNoteButton", Core, "UIPanelButtonTemplate")
GlobalNoteButton:SetText("Общие")
GlobalNoteButton:SetPoint("TOPLEFT", Core, "TOPLEFT", PlayerNameLength + 10, -5)
GlobalNoteButton:SetSize(80, 30)
GlobalNoteButton:SetScript(
    "OnClick",
    function()
        CharacterNoteScrollFrame:Hide()
        CharacterNoteButton:Enable()
        GlobalNoteScrollFrame:Show()
        GlobalNoteButton:Disable()

    end
)

GlobalNoteText = CreateFrame("EditBox", "GlobalNoteText", Core)
GlobalNoteText:SetMultiLine(true)
GlobalNoteText:SetAutoFocus(false)
GlobalNoteText:SetMaxLetters(99999)
GlobalNoteText:EnableMouse(true)
GlobalNoteText:SetFont("Fonts\\FRIZQT__.TTF", 11)
GlobalNoteText:SetSize(255, 255)
GlobalNoteText:SetScript(
    "OnEscapePressed",
    function(self)
        self:ClearFocus()
    end
)
GlobalNoteText:SetScript(
    "OnEditFocusLost",
    function(self)
        GlobalNote = self:GetText()
    end
)

GlobalNoteScrollFrame = CreateFrame("ScrollFrame", "GlobalNoteScrollFrame", Core, "UIPanelScrollFrameTemplate")
GlobalNoteScrollFrame:SetPoint("TOPLEFT", Core, "TOPLEFT", 12, -40)
GlobalNoteScrollFrame:SetPoint("BOTTOMRIGHT", Core, "BOTTOMRIGHT", -30, 12)
GlobalNoteScrollFrame:SetScrollChild(GlobalNoteText)
GlobalNoteScrollFrame:EnableMouse(true)
GlobalNoteScrollFrame:Hide()
GlobalNoteScrollFrame:SetScript(
    "OnMouseDown",
    function()
        GlobalNoteText:SetFocus()
    end
)