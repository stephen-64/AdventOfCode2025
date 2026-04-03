#include "main.h"

int main(int argc, char *argv[]) {
  std::printf("Hello World\r\n");
  std::printf(readFileContents("tests/test.txt").c_str());
  return 0;
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
