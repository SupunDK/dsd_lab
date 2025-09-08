
module pipelined_sequential_adder (
	input logic [31:0] a,
	input logic [31:0] b,
	output logic [31:0] s,
	input logic cin, clk, rstn, valid_in,
	output logic cout, valid_out);
	
	logic [3:0] cin_saved;
	logic	[3:0] cout_saved, valid_saved;
	logic [3:0][31:0] a_saved, b_saved, s_saved;
	
	genvar i; // Declare a generate variable

    generate
        for (i = 0; i < 4; i = i + 1) begin : adders
            n_bit_rc_adder adder(
                .a(a_saved[i][8*i + 7 : 8*i]),
                .b(b_saved[i][8*i + 7 : 8*i]),
                .s(s_saved[i][8*i + 7 : 8*i]),
                .cin(cin_saved[i]),
                .cout(cout_saved[i])
            );
        end
    endgenerate
	
	generate
    	for (i = 1; i < 4; i++) begin: s_shift
			always_ff @(posedge clk) begin
				if (!rstn) s_saved[i][8*i-1 : 0] <= 'b0;
				else s_saved[i][8*i-1 : 0] <= s_saved[i-1][8*i-1 : 0];
			end
		end
	endgenerate

	always_ff @(posedge clk) begin
		
		if (!rstn) begin
			a_saved <= '{default: '0};
			b_saved <= '{default: '0};
			s <= 'b0;
			cout <= 'b0;
			valid_out <= 'b0;
			cin_saved <= 'b0;
			valid_saved <= 'b0;

		end else begin

			a_saved <= {a_saved[2:0], a};
			b_saved <= {b_saved[2:0], b};
			cin_saved <= {cout_saved[2:0], cin};
			valid_saved <= {valid_saved[2:0], valid_in};

			s <= s_saved[3];
			cout <= cout_saved[3];
			valid_out <= valid_saved[3];
			
		end

	end
	
endmodule
	
	
	
	
	
	