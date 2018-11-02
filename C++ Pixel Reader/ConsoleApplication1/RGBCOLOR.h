#pragma once
struct RGBCOLOR {
	double m_r;
	double m_g;
	double m_b;

	RGBCOLOR(double red, double green, double blue);
	bool operator==(RGBCOLOR other);
};