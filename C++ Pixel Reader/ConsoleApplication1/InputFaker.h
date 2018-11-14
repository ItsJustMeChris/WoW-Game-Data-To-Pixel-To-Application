#pragma once
#include <windows.h>
#include <vector>

class InputFaker
{
public:
	InputFaker();
	void sendKey(std::vector<int>);
};
