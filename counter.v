// 4-bit Up Counter
module counter (
    input clk,
    input rst,
    output reg [3:0] count
);

always @(posedge clk or posedge rst) begin
    if (rst)
        count <= 4'b0000;
    else
        count <= count + 1;
end

endmodule

// Testbench for Counter
module counter_tb;
    reg clk;
    reg rst;
    wire [3:0] count;

    // Instantiate the counter module
    counter uut (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        
        // Apply reset
        #10 rst = 0;
        
        // Run for some time
        #100;
        
        // Apply reset again
        rst = 1;
        #10 rst = 0;
        
        // Run for more time
        #50;
        
        // Finish simulation
        $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t clk=%b rst=%b count=%b", $time, clk, rst, count);
    end
endmodule


Steps to be followed:
Invoke conformal Equivalence checking Tool
Lec –lpgxl –nogui
SETUP> read design ./cla8bit.v –golden
SETUP> read design ./cla_netlist.v –revised
SETUP> read library ./lib/slow.lib -liberty
 Set system mode lec
 Add compared points –all
 Compare
 Report verification
 Tclmode
report_unmapped_points > set_gui
