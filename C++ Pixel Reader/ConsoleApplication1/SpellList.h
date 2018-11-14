#pragma once
#include "RGBCOLOR.h"
#include <iostream>
#include <vector>

class SpellList
{
private:
	std::vector<std::string> m_spellNames;
	std::vector<RGBCOLOR> m_spells;
    std::vector<std::vector<int>> m_keyBindings;
public:
	SpellList();
	RGBCOLOR getSpell(std::string spellName);
	std::vector<int> getSpellBinding(RGBCOLOR spellColor);
	void registerSpell(std::string spellName, RGBCOLOR spellColor, std::initializer_list<int> keyBinding);
};
