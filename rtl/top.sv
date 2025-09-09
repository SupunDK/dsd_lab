
module top (
    input logic clk, rstn
);
    logic [31:0] a, b, s;
	logic cin, valid_in, cout, valid_out;

    pipelined_sequential_adder adder_module(.*);

    adder_test adder_test_module(.*);

endmodule