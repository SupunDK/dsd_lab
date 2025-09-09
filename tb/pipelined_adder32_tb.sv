`timescale 1ns/1ps 
 
module pipelined_adder32_tb(); 
 
	parameter N = 32; 
	parameter PIPELINE_DEPTH = 4; // Adjust based on your adder's pipeline depth
	
	logic [N-1:0] a, b, s; 
	logic cin = 0; 
	logic valid_in = 0; 
	logic cout, valid_out; 
	logic clk = 0; 
	logic rstn = 1; 
	 
	pipelined_adder adder32 (.*); 
	 
	parameter CLK_PERIOD = 10; 
	
	// Shift registers to delay inputs by pipeline depth
	logic [PIPELINE_DEPTH-1:0][N-1:0] a_delayed;
	logic [PIPELINE_DEPTH-1:0][N-1:0] b_delayed[PIPELINE_DEPTH];
	logic [PIPELINE_DEPTH-1:0] cin_delayed;
	 
	always #(CLK_PERIOD/2) clk <= ~clk; 
	
	// Shift register for delayed inputs
//	always @(posedge clk) begin
//		if (valid_in) begin
//			a_delayed <= {a_delayed[PIPELINE_DEPTH-2:0], a};
//			b_delayed <= {b_delayed[PIPELINE_DEPTH-2:0], b};
//			cin_delayed = {cin_delayed[PIPELINE_DEPTH-2:0], cin};
//		end
//	end
	 
	initial begin 
		#1 rstn = 0; 
		#10 rstn = 1; 
 
		a = 283; 
		b = 50; 
		valid_in = 1; 
		repeat(200) begin  
			@(posedge clk) #1;
//			if (valid_out) begin
//				assert ({cout,s} == a_delayed[PIPELINE_DEPTH-1] + b_delayed[PIPELINE_DEPTH-1] + cin_delayed[PIPELINE_DEPTH-1]) 
//					else $error("%d+%d+%d != {%d,%d}", 
//						a_delayed[PIPELINE_DEPTH-1], b_delayed[PIPELINE_DEPTH-1], cin_delayed[PIPELINE_DEPTH-1], cout, s); 
//			end
			a = a + 1318402; 
			b = b + 182553; 
		end 
		
		$finish;
	end 
	 
endmodule