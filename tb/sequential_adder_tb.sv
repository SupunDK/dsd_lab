`timescale 1ns/1ps

module sequential_adder_tb();

	parameter N = 32;
	logic [N-1:0] a, b, s;
	logic cin = 0;
	logic cout;
	
	cascaded_rc_adder adder32 (.*);
	
	initial begin
		repeat(200) begin 
			#5
			a = $random;
			b = $random;
			#5
			assert ({cout,s} == a + b + cin) else $error("%d+%d+%d != {%d,%d}", a, b, cin, cout, s);
		end
	end
	
	
endmodule