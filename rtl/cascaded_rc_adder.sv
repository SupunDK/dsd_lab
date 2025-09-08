
module cascaded_rc_adder (
	input logic [31:0] a,
	input logic [31:0] b,
	input logic cin,
	output logic [31:0] s,
	output logic cout);
	
	logic [4:0] carry;
	
	genvar i;

    generate
        for (i = 0; i < 4; i = i + 1) begin : adders
            n_bit_rc_adder adder(
                .a(a[8*i + 7 : 8*i]),
                .b(b[8*i + 7 : 8*i]),
                .s(s[8*i + 7 : 8*i]),
                .cin(carry[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate
    
    assign carry[0] = cin;
    assign cout = carry[4];    
	
endmodule
	
	
	
	
	
	