#include "InputFaker.h";
#include <iostream>

InputFaker::InputFaker()
{

}

void InputFaker::sendKey(std::vector<int> keys)
{
	INPUT ip;
	
	for (auto i : keys)
	{
		ip.ki.wVk = i;
		ip.ki.dwFlags = 0; // 0 for key press
		ip.type = INPUT_KEYBOARD;
		ip.ki.wScan = 0;
		ip.ki.time = 0;
		ip.ki.dwExtraInfo = 0;
		ip.ki.wVk = i;
		ip.ki.dwFlags = 0;
		SendInput(1, &ip, sizeof(INPUT));
	}
	for (auto i : keys)
	{
		ip.type = INPUT_KEYBOARD;
		ip.ki.wScan = 0;
		ip.ki.time = 0;
		ip.ki.dwExtraInfo = 0;
		ip.ki.wVk = i;
		ip.ki.dwFlags = KEYEVENTF_KEYUP;
		SendInput(1, &ip, sizeof(INPUT));
	}
}