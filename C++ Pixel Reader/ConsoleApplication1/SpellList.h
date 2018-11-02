#pragma once
#include "RGBCOLOR.h"
#include <iostream>
#include <vector>

class SpellList
{
private:
	std::vector<std::string> m_spellNames;
	std::vector<RGBCOLOR> m_spells;
	std::vector<unsigned char> m_keyBindings;
public:
	SpellList();
	RGBCOLOR getSpell(std::string spellName);
	int getSpellBinding(RGBCOLOR spellColor);
	void registerSpell(std::string spellName, RGBCOLOR spellColor, unsigned char keyBinding);
};
