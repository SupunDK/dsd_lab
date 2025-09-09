`timescale 1ns/1ps

module adder32_tb();

	parameter N = 32;
	logic [N-1:0] a, b, s;
	logic cin = 0;
	logic cout;
	logic clk = 0;
	
	cascaded_sequential_adder adder32 (.*);
	
	parameter CLK_PERIOD = 2;
	
	always #(CLK_PERIOD/2) clk <= ~clk;
	
	initial begin
		a = 283;
		b = 50;
		repeat(200) begin 
			@(posedge clk) #1
			assert ({cout,s} == a + b + cin) else $error("%d+%d+%d != {%d,%d}", a, b, cin, cout, s);
			a = a + 1318402;
			b = b + 182553;
		end
	end
	
	
endmodule