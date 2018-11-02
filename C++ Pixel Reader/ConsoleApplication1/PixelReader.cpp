#include <windows.h>
#include <stdio.h>
#include <iostream>
#include <math.h>
#include "RGBCOLOR.h"
#include "SpellList.h"


RGBCOLOR getNextSpell(HDC desktopHdc, HWND desktop)
{
	COLORREF color = GetPixel(desktopHdc, 0, 0);

	double red, green, blue;
	red = green = blue = 0;

	blue = GetBValue(color);
	green = GetGValue(color);
	red = GetRValue(color);

	red = ceil((red / 255) * 100) / 100;
	green = ceil((green / 255) * 100) / 100;
	blue = ceil((blue / 255) * 100) / 100;

	RGBCOLOR rgb = RGBCOLOR(red, green, blue);

	return rgb;
}

void sendKey(int key)
{
	INPUT ip;

	ip.type = INPUT_KEYBOARD;
	ip.ki.wScan = 0; 
	ip.ki.time = 0;
	ip.ki.dwExtraInfo = 0;

	ip.ki.wVk = key; 
	ip.ki.dwFlags = 0; 
	SendInput(1, &ip, sizeof(INPUT));

	ip.ki.dwFlags = KEYEVENTF_KEYUP;
	SendInput(1, &ip, sizeof(INPUT));
}

int main(int argc, char** argv)
{
	std::cout << "Pixel Reader Ready. Ensure wow is in windowed fullscreen on monitor 1. " << std::endl;
	while (true) 
	{
		Sleep(300);
		HWND desktop = GetDesktopWindow();
		HDC desktopHdc = GetDC(desktop);

		RGBCOLOR nextSpell = getNextSpell(desktopHdc, desktop);

		ReleaseDC(desktop, desktopHdc);

		SpellList dhv;
		dhv.registerSpell("spiritBomb", RGBCOLOR(.51, 0, 0), 0x36);
		dhv.registerSpell("fracture", RGBCOLOR(0, .51, 0), 0x32);
		dhv.registerSpell("immolationAura", RGBCOLOR(0, 0, .51), 0x37);
		dhv.registerSpell("soulCleave", RGBCOLOR(1, 1, 0), 0x34);
		dhv.registerSpell("throwGlaive", RGBCOLOR(0, 1, 1), 0x33);
		dhv.registerSpell("disrupt", RGBCOLOR(0, .51, 1), 0x38);

		auto key = dhv.getSpellBinding(nextSpell);
		if (key != 0x16)
		{
			sendKey(key);
		}

	}
	return 0;
}