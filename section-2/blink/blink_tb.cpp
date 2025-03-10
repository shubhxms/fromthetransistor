// thank you claude

#include "Vblink.h"
#include "verilated.h"
#include <iostream>

int main(int argc, char** argv) {
    // Initialize Verilator
    Verilated::commandArgs(argc, argv);
    
    // Create instance of our module
    Vblink* blink_module = new Vblink;
    
    // Simulation variables
    int time = 0;
    int reset_duration = 2;
    
    // Print CSV header for waveform data
    std::cout << "Time,Clock,Reset,LED\n";
    
    // Run simulation for 100 cycles
    for (int i = 0; i < 100; i++) {
        time = i;
        
        // Generate clock - toggle every cycle
        blink_module->clk = (i % 2);
        
        // Assert reset for first few cycles
        blink_module->reset = (i < reset_duration) ? 1 : 0;
        
        // Evaluate design (process inputs)
        blink_module->eval();
        
        // Display outputs in CSV format for easy plotting
        std::cout << time << "," << (int)blink_module->clk << "," 
                  << (int)blink_module->reset << "," << (int)blink_module->q << "\n";
    }
    
    // Clean up
    delete blink_module;
    return 0;
}