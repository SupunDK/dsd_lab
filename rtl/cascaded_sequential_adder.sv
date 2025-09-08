`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2025 11:45:10 PM
// Design Name: 
// Module Name: adder_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cascaded_sequential_adder (
    input logic [31:0] a,
	input logic [31:0] b,
	input logic cin, clk,
	output logic [31:0] s,
	output logic cout
    );
    
    logic [31:0] a_saved, b_saved, s_saved;
    logic cin_saved, cout_saved; 
    
    always_ff@(posedge clk) begin
        a_saved <= a;
        b_saved <= b;
        cin_saved <= cin;
        
        s <= s_saved;
        cout <= cout_saved;
    end
    
    // use cascaded adder
//    cascaded_rc_adder adder(
//        .a(a_saved),
//        .b(b_saved),
//        .s(s_saved),
//        .cin(cin_saved),
//        .cout(cout_saved)
//    );
    
    // use cascaded carry look ahead adder
    cascaded_cla_adder adder(
        .a(a_saved),
        .b(b_saved),
        .s(s_saved),
        .cin(cin_saved),
        .cout(cout_saved)
    );
    
    
endmodule
