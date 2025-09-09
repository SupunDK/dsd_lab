`timescale 1ns/1ps

module n_bit_adder_tb();

	parameter N = 8;
	logic [N-1:0] a, b, s;
	logic cin = 0;
	logic cout;
	
	n_bit_rc_adder #(.N(N)) adder8 (.*);
	
	initial begin
		a = 10;
		b = 50;
		repeat(10) begin 
			#10
			assert ({cout,s} == a + b + cin) else $error("%d+%d+%d != {%d,%d}", a, b, cin, cout, s);
			a = a + 2;
			b = b + 7;
		end
	end
	
	
endmodule