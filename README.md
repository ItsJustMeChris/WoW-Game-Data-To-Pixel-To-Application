# WoW Game Data To Pixel To Application

This is an example of how to read game data from the game World of Warcraft using the Lua API and pixel colors.  

I might extend this later on to something like a semi full rotation engine. 


Discussing Line 69 of PixelReader.cpp;

Because COLORREF is a DWORD, it might be easiest to do your own conversion in the Lua side of the project to produce correct colors in the CPP side, because of how ints work, you cannot use .5 in lua and get 127.5 (.5)(255/2) in C++, instead a rounded 128.  I would recommend making a function in Lua to take a true 0-255 rgb value that is converted by (value/255) rounded up to a solid int.  This would mitigate any need to do color specification in the CPP version, and just make things cleaner ultimately.  You could also make things easier in the CPP by not using decimals for rgb colors, for instance .51 for 128, but just using 128.. 
