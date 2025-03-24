module lfsr32 (clk, rst, enable, out);
input clk, rst, enable;
output reg [31:0] out;


always @(posedge clk or negedge rst)
begin
if (~rst)
begin
out<=32'b1;
end
else if(enable) begin
out<={out[30:0], out[31]^out[21]^out[1]};
end
end
endmodule

Test Bench:
module lfsr32_tb ();
reg clk, rst, enable;
wire [31:0] out;

lfsr32 uuu(.clk(clk), .rst(rst), .enable(enable), .out(out));

always #5 clk=~clk;

initial begin
clk=0;
rst=0;
enable=0;

#10 rst=1;
enable=1;

#200;

$stop;
end

initial
begin
$monitor("time=%0t, out=%b", $time,out);
end
endmodule


/// or


// 32-bit Linear Feedback Shift Register (LFSR) Module
module lfsr32 (clk, rst, enable, out);
    input clk, rst, enable;
    output reg [31:0] out;
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            out <= 32'b1; // Initialize LFSR with a non-zero value
        else if (enable) 
            out <= {out[30:0], out[31] ^ out[21] ^ out[1] ^ out[0]}; // XOR feedback taps
    end
endmodule

// Testbench for LFSR
module lfsr32_tb();
    reg clk, rst, enable;
    wire [31:0] out;
    
    lfsr32 uut(.clk(clk), .rst(rst), .enable(enable), .out(out));
    
    always #5 clk = ~clk; // Clock signal with 10ns period
    
    initial begin
        clk = 0;
        rst = 1; // Assert reset
        enable = 0;
        
        #10 rst = 0; // Deassert reset after 10ns
        enable = 1; // Enable LFSR
        
        #200; // Run simulation
        $stop;
    end
    
    initial begin
        $monitor("time=%0t, out=%b", $time, out);
    end
endmodule
