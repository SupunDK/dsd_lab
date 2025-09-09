`timescale 1ns/1ps

module top_tb;
    // Clock and reset signals
    logic clk;
    logic rstn;
    
    // Instantiate the DUT (Device Under Test)
    top dut (.*);
    
    // Clock generation - 100MHz (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle every 5ns for 10ns period
    end
    
    // Reset and test sequence
    initial begin
        // Initialize signals
        rstn = 0;
        
        // Apply reset for several clock cycles
        repeat(5) @(posedge clk);
        
        // Release reset
        rstn = 1;
        
        // Let the system run for some time
        repeat(100) @(posedge clk);
        
        // Finish simulation
        $display("Testbench completed at time %0t", $time);
        $finish;
    end

endmodule