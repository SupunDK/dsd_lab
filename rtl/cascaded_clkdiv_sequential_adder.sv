module cascaded_clkdiv_sequential_adder (
    input logic [31:0] a,
	input logic [31:0] b,
	input logic cin, clk,
	output logic [31:0] s,
	output logic cout
    );
    
    logic [31:0] a_saved, b_saved, s_saved;
    logic cin_saved, cout_saved; 
    logic div_clk;

    clk_divider clk_div(
        .in_clk(clk),
        .div_clk(div_clk)
    );
    
    always_ff@(posedge div_clk) begin
        a_saved <= a;
        b_saved <= b;
        cin_saved <= cin;
        
        s <= s_saved;
        cout <= cout_saved;
    end
    
    // use cascaded ripple carry adder
    cascaded_rc_adder adder(
        .a(a_saved),
        .b(b_saved),
        .s(s_saved),
        .cin(cin_saved),
        .cout(cout_saved)
    );
    
    // use cascaded carry look ahead adder
//    cascaded_cla_adder adder(
//        .a(a_saved),
//        .b(b_saved),
//        .s(s_saved),
//        .cin(cin_saved),
//        .cout(cout_saved)
//    );
    
    
endmodule