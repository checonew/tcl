// Modified Booth Multiplier
module booth_multiplier #(parameter WIDTH = 4)(
    input  signed [WIDTH-1:0] multiplicand,
    input  signed [WIDTH-1:0] multiplier,
    output signed [(2*WIDTH)-1:0] product
);
    reg signed [(2*WIDTH)-1:0] P;
    reg signed [WIDTH:0] M;
    reg signed [WIDTH:0] Q;
    integer i;
    
    always @(*) begin
        P = 0;
        M = {multiplicand, 1'b0}; // Extend M with 0
        Q = {multiplier, 1'b0};   // Extend Q with 0
        
        for (i = 0; i < WIDTH; i = i + 1) begin
            case (Q[1:0])
                2'b01: P = P + (M << i); // Add M shifted i times
                2'b10: P = P - (M << i); // Subtract M shifted i times
            endcase
            Q = Q >>> 1; // Arithmetic right shift
        end
    end
    
    assign product = P;
endmodule

// Testbench for Modified Booth Multiplier
module tb_booth_multiplier;
    parameter WIDTH = 4;
    reg signed [WIDTH-1:0] multiplicand;
    reg signed [WIDTH-1:0] multiplier;
    wire signed [(2*WIDTH)-1:0] product;
    
    booth_multiplier #(WIDTH) uut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product)
    );
    
    initial begin
        $monitor("%d * %d = %d", multiplicand, multiplier, product);
        multiplicand = 4; multiplier = 3; #10;
        multiplicand = -4; multiplier = 3; #10;
        multiplicand = 4; multiplier = -3; #10;
        multiplicand = -4; multiplier = -3; #10;
        multiplicand = 7; multiplier = 2; #10;
        $finish;
    end
endmodule


//i dont know (if needed use)
create_clock -name clk -period 10 -waveform {0 5} [get_ports "clk"]
set_clock_transition -rise 0.1 [get_clocks "clk"]
set_clock_transition -fall 0.1 [get_clocks "clk"]
set_clock_uncertainty 0.01 [get_ports "clk"]
set_input_delay -max 1.0 [get_ports "rst"] -clock [get_clocks "clk"]
set_output_delay -max 1.0 [get_ports "count"] -clock [get_clocks "clk"]
