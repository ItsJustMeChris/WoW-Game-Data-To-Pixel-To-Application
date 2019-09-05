local loop = CreateFrame("Frame");
local toggle = true

local nextSpellFrame = CreateFrame("Frame", "nextSpellFrame", UIParent) 
nextSpellFrame:SetSize(1, 1) 
nextSpellFrame:SetPoint("TOPLEFT", 0, 0);

local nextSpellFrameTexture = nextSpellFrame:CreateTexture() 
nextSpellFrameTexture:SetAllPoints() 

function buffcount(unit, buff)
    for i=1,40 do
        local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, 
        nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitBuff(unit,i)
        if name == buff then
            return (count == 0 and 1 or count)
        end
    end
    return 0
end

function debuffcount(unit, buff)
    for i=1,40 do
        local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, 
        nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff(unit,i)
        if name == buff then
            return (count == 0 and 1 or count)
        end
    end
    return 0
end

function auraexists(unit, auraName)
    local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, 
    nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod = AuraUtil.FindAuraByName(auraName, unit, "player")
		
	if name then
        return true
    else
		return false
	end
end

function spellcooldown(spell)
    local time, value = GetSpellCooldown(spell)
	local gcdTime, gcdValue = GetSpellCooldown(61304)
    if time == 0 then
        return 0
    end
    local cd = gcdTime + gcdValue + time + value - GetTime()
    if cd > 0 then
        return cd
    else
        return 8675309
    end
end

function interruptable(unit) 
    local name, subText, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo(unit)
	local cname, ctext, ctexture, cstartTimeMS, cendTimeMS, cisTradeSkill, cnotInterruptible, cspellId = UnitChannelInfo(unit)

    if notInterruptible == 1 or cnotInterruptible == 1 then
        return true
    else 
        return false
    end
end

function curSpellCharges(spell) 
	local currentCharges, maxCharges, cooldownStart, cooldownDuration, chargeModRate = GetSpellCharges(spell)
	return currentCharges
end

function health(unit)
	return (UnitHealth(unit) / UnitHealthMax(unit)) * 100
end

function setNextSpell(r,g,b,a)     
    nextSpellFrameTexture:SetColorTexture(r,g,b,a)
    nextSpellFrame.background = nextSpellFrameTexture 
end

function isChanneling(unit)
	return UnitChannelInfo(unit)
end

function castable(spell) 
	local usable, nomana = IsUsableSpell(spell)
	local cdcheck = spellcooldown(spell) == 0
	return usable == true and cdcheck == true
end

function lowest() 
    local lowestUnit = not UnitIsDeadOrGhost("player") and "player" or false
    local lowesthp = not UnitIsDeadOrGhost("player") and health("player") or math.huge
    local unit
    for i = 1, GetNumGroupMembers() - 1 do
        unit = IsInRaid() and 'raid' .. i or UnitInBattleground("player") and 'raid' .. i or 'party' .. i
            if IsActionInRange(1, unit) and not UnitIsDeadOrGhost(unit) and health(unit) < lowesthp then
                lowestUnit = unit
                lowesthp = health(unit)
            end
    end
    return lowestUnit
end


function loop:onUpdate()
    local lowestParty = lowest()
    --if not toggle or not UnitExists("target") or UnitIsDeadOrGhost("target") or UnitIsFriend("player", "target") or isChanneling("player") then
	--	return setNextSpell(0,0,0,0)
    --end
    if not toggle or not UnitExists("target") or UnitIsDeadOrGhost("target") or isChanneling("player") then
		return setNextSpell(0,0,0,0)
    end
    
    --DH VENGEANCE
    --[[
	if castable("Disrupt") and interruptable("target") then
        return setNextSpell(.51, .51, 1,1)
    end

	if castable("Demon Spikes") and health("player") <= 70 and curSpellCharges("Demon Spikes") == 2 then
		return setNextSpell(1,.51,1,1)
	end
	if castable("Demon Spikes") and health("player") <= 50 and curSpellCharges("Demon Spikes") == 1 then
		return setNextSpell(1,.51,1,1)
	end
	if castable("Metamorphosis") and health("player") <= 40 then
		return setNextSpell(.51, .51, 0,1)
	end
	if castable("Fiery Brand") and health("player") <= 70 then
		return setNextSpell(.51, .51, 1,1)
	end
    if castable("Disrupt") and interruptable("target") then
        return setNextSpell(0,.5,1,1)
    end
    if castable("Immolation Aura") then
        return setNextSpell(0,0,.5,1)
    end
    if castable("Soul Cleave") and UnitPower("player", 18) >= 40 and IsActionInRange(4, "target") and debuffcount("target", "Frailty") >= 1 then
        return setNextSpell(1,1,0,1)
    end
    if castable("Spirit Bomb") and UnitPower("player", 18) >= 40 and buffcount("player", "Soul Fragments") >= 3 and debuffcount("target", "Frailty") == 0 then
        return setNextSpell(.5,0,0,1)
    end
    if castable("Fracture") and IsActionInRange(2, "target") then
        return setNextSpell(0,.5,0,1)
    end
    if castable("Throw Glaive") and IsActionInRange(3, "target") then
        return setNextSpell(0,1,1,1)
    end
    ]]--END VENGEANCE
    --DH HAVOC
    --[[
	if castable("Immolation Aura") and IsActionInRange(4, "target") then
		return setNextSpell(0, 0, .51,1)
	end
	if castable("Blade Dance") and IsActionInRange(4, "target") and UnitPower("player", 17) >= 15 then
		return setNextSpell(0, 1, 1,1)
	end
	if GetSpellInfo("Death Sweep") and castable("Death Sweep") and UnitPower("player", 17) >= 15 then
		return setNextSpell(0, 1, 1,1)
	end
	if castable("Eye Beam") and IsActionInRange(4, "target") and UnitPower("player", 17) >= 30 then
		return  setNextSpell(1, 1, 0, 1)
	end
	if castable("Chaos Strike") and IsActionInRange(5, "target") and UnitPower("player", 17) >= 30 then
		return setNextSpell(0, .51, 0, 1)
	end
	if GetSpellInfo("Annihilation") and castable("Chaos Strike") and IsActionInRange(4, "target") and UnitPower("player", 17) >= 40 then
		return setNextSpell(0, .51, 0, 1)
	end
	if castable(162243) and IsActionInRange(4, "target")  then
		return setNextSpell(1, .51, 1, 1)
    end]]--END HAVOC
    --HOLY PALADIN DUNGEON
    if (lowestParty == 'player') and not UnitIsUnit(lowestParty, 'target') then
        return setNextSpell(1,0,0,1)
    end
    if lowestParty == 'party1' and not UnitIsUnit(lowestParty, 'target') then
        return setNextSpell(0,1,0,1)
    end
    if lowestParty == 'party2' and not UnitIsUnit(lowestParty, 'target') then
        return setNextSpell(0,0,1,1)
    end
    if lowestParty == 'party3' and not UnitIsUnit(lowestParty, 'target') then
        return setNextSpell(0,1,1,1)
    end
    if lowestParty == 'party4' and not UnitIsUnit(lowestParty, 'target') then
        return setNextSpell(1,0,1,1)
    end
    if health(lowestParty) <= 85 and IsActionInRange(2, lowestParty) and castable("Holy Shock") then
        return setNextSpell(.51,0,0,1)
    end
    if health(lowestParty) <= 85 and IsActionInRange(3, lowestParty) and castable("Bestow Faith") then
        return setNextSpell(0,.51,0,1)
    end
    if health(lowestParty) <= 75 and IsActionInRange(5, lowestParty) and castable("Flash of Light") then
        return setNextSpell(.51,1,1,1)
    end
    if health(lowestParty) <= 85 and IsActionInRange(5, lowestParty) and castable("Holy Light") then
        return setNextSpell(0,0,.51,1)
    end
	return setNextSpell(0,0,0,0)
end

loop:SetScript("OnUpdate",loop.onUpdate)

SLASH_PIXEL1 = '/pixel' 
function SlashCmdList.PIXEL(msg, editbox) 
 toggle = not toggle
 print('State: ', toggle)
end