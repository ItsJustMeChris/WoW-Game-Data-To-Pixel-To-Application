local loop = CreateFrame("Frame");

local nextSpellFrame = CreateFrame("Frame", "nextSpellFrame", UIParent) 
nextSpellFrame:SetSize(1, 1) 
nextSpellFrame:SetPoint("TOPLEFT", 0, 0);

local nextSpellFrameTexture = nextSpellFrame:CreateTexture() 
nextSpellFrameTexture:SetAllPoints() 

function buffcount(unit, buff)
    for i=1,40 do
        local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, 
        nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitBuff("player",i)
        if name == buff then
            return (count == 0 and 1 or count)
        end
    end
    return 0
end

function spellcooldown(spell)
    local time, value = GetSpellCooldown(spell)
    if time == 0 then
        return 0
    end
    local cd = time + value - GetTime()
    if cd > 0 then
        return cd
    else
        return 8675309
    end
end


function setNextSpell(r,g,b,a)     
    nextSpellFrameTexture:SetColorTexture(r,g,b,a)
    nextSpellFrame.background = nextSpellFrameTexture 
end


function loop:onUpdate()
    if not UnitExists("target") then
        return setNextSpell(0,0,0,0)
    end
    if spellcooldown("Spirit Bomb") == 0 and buffcount("player", "Soul Fragments") >= 3 then
        return setNextSpell(.5,0,0,1)
    end

    if spellcooldown("Fracture") == 0 and IsActionInRange(2, "target") then
        return setNextSpell(0,.5,0,1)
    end

    if spellcooldown("Immolation Aura") == 0 then
        return setNextSpell(0,0,.5,1)
    end

    if spellcooldown("Soul Cleave") == 0 and IsActionInRange(4, "target") then
        return setNextSpell(1,1,0,1)
    end
end

loop:SetScript("OnUpdate",loop.onUpdate)