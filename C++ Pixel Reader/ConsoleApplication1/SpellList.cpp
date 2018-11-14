#include "SpellList.h";

SpellList::SpellList()
{

}

RGBCOLOR SpellList::getSpell(std::string spellName)
{
	ptrdiff_t pos = std::distance(m_spellNames.begin(), std::find(m_spellNames.begin(), m_spellNames.end(), spellName));
	if (pos != m_spellNames.size())
	{
		return m_spells[pos];
	}
}

std::vector<int> SpellList::getSpellBinding(RGBCOLOR spellColor)
{
	ptrdiff_t pos = std::distance(m_spells.begin(), std::find(m_spells.begin(), m_spells.end(), spellColor));
	if (pos != m_spells.size())
	{
		return m_keyBindings[pos];
	}
	else
	{
		return {};
	}
}

void SpellList::registerSpell(std::string spellName, RGBCOLOR spellColor, std::initializer_list<int> keyBinding)
{
	m_spells.push_back(spellColor);
	m_spellNames.push_back(spellName);
	m_keyBindings.push_back(keyBinding);
}
