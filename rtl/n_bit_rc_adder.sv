
module n_bit_rc_adder #(parameter N = 8)
					(input logic [N-1:0] a, b,
					input logic cin,
					output logic [N-1:0] s,
					output logic cout);
	
	logic [N-1:0] cin_array;
	logic [N-1:0] cout_array;
	logic [N-1:0] sum_array;
	
	//full_adder [N-1:0] full_adder_insts(.a(a), .b(b), .s(sum_array), .cin(cin_array), .cout(cout_array));
	full_adder full_adder_insts [N-1:0]
    (
        .a(a),
        .b(b),
        .s(sum_array),
        .cin(cin_array),
        .cout(cout_array)
    );
	
	always_comb begin
		for (int i = 1; i < N; i = i+1) begin
			cin_array[i] = cout_array[i-1];
		end
	end
	
	assign cin_array[0] = cin;
	assign cout = cout_array[N-1];
	assign s = sum_array;
	
endmodule