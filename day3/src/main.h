#ifndef __MAIN__H
#define __MAIN__H

#include <cstdio>
#include <fstream>
#include <string>
#include <vector>

typedef struct cell {
  int volatage = 0;
  int position = 0;
} cell;

typedef struct batteryBank {
  std::vector<std::vector<cell>> battery = std::vector<std::vector<cell>>();
} batteryBank;

batteryBank generateBatteryBank(const char *fileToMakeBattery);

std::string readFileContents(const char *fileName);

#endif
