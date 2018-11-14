#include "RGBCOLOR.h"

RGBCOLOR::RGBCOLOR(double red, double green, double blue)
{
	m_r = red;
	m_g = green;
	m_b = blue;
}

bool RGBCOLOR::operator==(RGBCOLOR other)
{
	return m_r == other.m_r && m_g == other.m_g && m_b == other.m_b;
}