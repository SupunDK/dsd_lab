
module n_bit_cla_adder
 #(parameter N=8)(
    input logic [N-1:0] a, b,
    input logic cin,
    output logic [N-1:0] s,
    output logic cout
);

	
    logic [N:0] carry;
    
    assign carry[0] = cin;
    
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : cla
            assign carry[i+1] = (a[i] & b[i]) | ( (a[i]^b[i]) & carry[i]);
        end
    endgenerate
	
	assign cout = carry[N];
	assign s = a^b^carry;
endmodule