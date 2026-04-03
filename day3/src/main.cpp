#include "main.h"
#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <regex>
#include <sstream>
#include <string>
#include <vector>

bool cellCompareGreaterPosition(const cell a, const cell b) {
  return a.position > b.position;
}

int main(int argc, char *argv[]) {
  std::string inputFile = readFileContents("tests/test.txt");
  // std::printf(inputFile.c_str());
  batteryBank bank = generateBatteryBank(inputFile.c_str());
  std::printf("The First Value in the Bank is: %i\n", bank.battery[0][0].volatage);
  int numberOfBatteriesToPull = 2;
  int total = 0;
  for (std::vector<cell> battery : bank.battery) {
    std::printf("%i\n", battery[0].volatage);
    cell cellsToEnable[numberOfBatteriesToPull];
    for (int i = 0; i < numberOfBatteriesToPull; i++) {
      cellsToEnable[i] = battery[i];
    }
    int n = sizeof(cellsToEnable) / sizeof(cellsToEnable[0]);
    std::sort(cellsToEnable, cellsToEnable + n, cellCompareGreaterPosition);
    int sum = 0;
    for (int i = 0; i < numberOfBatteriesToPull; i++) {
      sum += cellsToEnable[i].volatage * std::pow(10, i);
    }
    std::printf("Test Value: %i\n", sum);
    total += sum;
  }
  std::printf("The total volatage is: %i\n", total);
  return 0;
}

bool cellGreaterCompareVoltages(const cell a, const cell b) {
  return a.volatage > b.volatage;
};

batteryBank generateBatteryBank(const char *fileToMakeBattery) {
  batteryBank bank;
  std::stringstream parser = std::stringstream(fileToMakeBattery);
  std::string line;
  std::regex numbersOnly = std::regex("^[^0-9]+");
  if (fileToMakeBattery != NULL) {
    while (std::getline(parser, line, '\n')) {
      if (std::regex_match(line, numbersOnly)) {
        continue;
      }
      std::vector<cell> batteryLineHolder = std::vector<cell>();
      std::printf(line.c_str());
      std::printf("\n");
      cell cellHolder;
      for (int pos = 0; pos < line.size() - 1; pos++) {
        cellHolder.position = pos;
        cellHolder.volatage = line[pos] - '0';
	//std::printf("The state of the cell is: volt: %i pos: %i\n", cellHolder.volatage, cellHolder.position);
        batteryLineHolder.push_back(cellHolder);
      }
      std::sort(batteryLineHolder.begin(), batteryLineHolder.end(),
                cellGreaterCompareVoltages);
      bank.battery.push_back(batteryLineHolder);
    }
  }
  return bank;
}

std::string readFileContents(const char* fileName) {
  std::ifstream fileStream;
  std::string line;
  std::string fileContents = "";
  fileStream.open(fileName);
  if (fileStream.is_open()) {
    while (std::getline(fileStream, line)) {
      fileContents.append(line);
      fileContents.append("\r\n");
    }
  }
  return fileContents;
}
