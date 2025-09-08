module clk_divider #(parameter div_factor=2)(
    input logic in_clk,
    output logic div_clk
);

localparam clen = $clog2(div_factor);
logic [clen:0] counter;

always_ff@(posedge in_clk) begin
    counter <= counter + 1;
end

assign div_clk = counter[clen];

endmodule