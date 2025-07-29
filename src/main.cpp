#include <iostream>
#include <fstream>
#include "OrderBook.h"

int main(int argc, char* argv[]) {
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " mbo.csv" << std::endl;
        return 1;
    }

    std::ifstream infile(argv[1]);
    if (!infile) {
        std::cerr << "Failed to open input file" << std::endl;
        return 1;
    }

    OrderBook ob;
    std::string line;
    bool first = true;

    while (std::getline(infile, line)) {
        if (first) { first = false; continue; } // skip clear[R]
        ob.processLine(line);
        if (ob.hasChanged()) {
            std::cout << ob.serializeTop10() << "\n";
        }
    }

    return 0;
}