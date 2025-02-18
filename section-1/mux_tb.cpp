#include "Vmux.h"  // Auto-generated header by Verilator
#include "verilated.h"
#include <iostream>

int main() {
    Verilated::traceEverOn(true);
    
    Vmux* dut = new Vmux;  // Instantiate the module

    // Test Case 1: sel = 0, expect y = a
    dut->a = 0;
    dut->b = 1;
    dut->sel = 0;
    dut->eval();  // Simulate
    std::cout << "sel=0: y=" << (int)dut->y << std::endl;

    // Test Case 2: sel = 1, expect y = b
    dut->sel = 1;
    dut->eval();  // Simulate
    std::cout << "sel=1: y=" << (int)dut->y << std::endl;

    delete dut;  // Free memory
    return 0;
}
