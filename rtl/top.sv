
module top (
    input logic clk, rst,
	output logic valid_out, cout, s_0
);
    logic [31:0] a, b, s;
	logic cin, valid_in, rstn;
	
	assign rstn = ~rst;	// Active low reset
    assign s_0 = s[0];

    pipelined_adder adder_module(.*);

    adder_test adder_test_module(.*);

endmodule