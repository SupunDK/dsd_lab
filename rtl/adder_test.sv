
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
    logic read_wait;

    bram test_bram (
        .clock(clk),
        .wren(wea),
        .wraddress(addra),
        .data(dina),
        // .clkb(clk),
        .rdaddress(addrb),
        .q(doutb)
    );

    assign cin = 0;

    always_ff @(posedge clk) begin : read_logic
        if (!rstn) begin
            addrb <= 5'h0;   // Read address
            valid_in <= 1'h0;
            read_wait <= 1'h1;

        end else if (read_wait) begin
            read_wait <= 1'h0;
            addrb <= addrb + 5'h1;

        end else begin
            if (addrb[0] == 1) begin  // Read cycle 0
                a <= doutb;
                valid_in <= 0;
                addrb <= addrb + 5'h3;
            end else begin  // Read cycle 1
                b <= doutb;
                valid_in <= 1'h1;
                addrb <= addrb + 5'h1;
            end
        end
    end

    always_ff @(posedge clk) begin : write_logic
        if (!rstn) begin
            addra <= -1;   // Write address
            valid_out_saved <= 1'h0;
            wea <= 1'h0;

        end else begin
            valid_out_saved <= valid_out;

            if (valid_out | valid_out_saved) begin
                // Received valid output

                if (valid_out) begin    // Write cycle 0
                    cout_saved <= cout;
                    dina <= s;
                    wea <= 'h1;
                    addra <= addra + 5'h3;
                end else begin  // Write cycle 1
                    dina <= cout_saved;
                    wea <= 'h1;
                    addra <= addra + 5'h1;
                end

            end else begin
                wea <= 'h0;
            end
        end
    end

endmodule