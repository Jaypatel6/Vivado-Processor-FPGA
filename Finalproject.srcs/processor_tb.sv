`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2016 08:52:11 PM
// Design Name: 
// Module Name: processor_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module processor_tb;
    logic clk;
    logic rst;
    logic [31:0] reg_write_data;
    
    processor test(.clk(clk),
                   .rst(rst),
                   .reg_write_data(reg_write_data)
                   );

initial begin
clk = 0;
rst = 0;
#3;
rst = 1;
clk = 1;
#3;
clk = 0;
#3;
clk = 1;
rst = 0;
#3;
repeat(10) begin
clk = 0;
#3;
clk = 1;
#3;
end
end
endmodule
