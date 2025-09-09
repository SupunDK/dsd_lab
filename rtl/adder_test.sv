
module adder_test (
    input logic clk, rstn, 
    input logic cout, valid_out,
    input logic [31:0] s, 
    output logic [31:0] a, b, 
    output logic cin, valid_in
);
    logic wea; 
    logic [4:0] addra, addrb;
    logic [31:0] dina, doutb;
    logic cout_saved, valid_out_saved;

    bram test_bram (
        .clka(clk),
        .wea(wea),
        .addra(addra),
        .dina(dina),

        .clkb(clk),
        .addrb(addb),
        .doutb(doutb)
    );

    assign cin = 0;

    always_ff @(posedge clk) begin : read_logic
        if (!rstn) begin
            addrb <= 'h0;   // Read address
            valid_in <= 'h0;

        end else begin
            if (addrb[0] == 0) begin  // Read cycle 0
                a <= doutb;
                valid_in <= 0;
                addrb <= addrb + 'h1;
            end else begin  // Read cycle 1
                b <= doutb;
                valid_in <= 'h1;
                addrb <= addrb + 'h3;
            end
        end
    end

    always_ff @(posedge clk) begin : write_logic
        if (!rstn) begin
            addra <= -1;   // Write address
            valid_out_saved <= 'h0;
            wea <= 'h0;

        end else begin
            valid_out_saved <= valid_out;

            if (valid_out | valid_out_saved) begin
                // Received valid output

                if (valid_out) begin    // Write cycle 0
                    cout_saved <= cout;
                    dina <= s;
                    wea <= 'h1;
                    addra <= addra + 'h3;
                end else begin  // Write cycle 1
                    dina <= cout_saved;
                    wea <= 'h1;
                    addra <= addra + 'h1;
                end

            end else begin
                wea <= 'h0;
            end
        end
    end

endmodule