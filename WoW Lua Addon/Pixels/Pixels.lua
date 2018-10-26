local loop = CreateFrame("Frame");

local frame = CreateFrame("Frame", "MyFrame", UIParent) 
frame:SetSize(1, 1) 
frame:SetPoint("CENTER") 
local texture = frame:CreateTexture() 
texture:SetAllPoints() 

local test = 0

function loop:onUpdate()
    local pHealth = math.floor((UnitHealth("player") / UnitHealthMax("player")) * 100) / 100
    print(pHealth)
    texture:SetColorTexture(pHealth,0,0,1)
    frame.background = texture 
end

loop:SetScript("OnUpdate",loop.onUpdate)