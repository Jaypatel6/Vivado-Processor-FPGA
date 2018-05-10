`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2016 08:56:32 PM
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    input logic [5:0]   ra1,
    input logic [5:0]   ra2,
    input logic [5:0]   wa,
    input logic [31:0]  wd,
    input logic         we1,
    output logic [31:0] rd1,
    input logic clk,
    output logic [31:0] rd2
);

logic [31:0] mem [63:0];
assign mem[0] = 32'b0;

always_ff @(posedge clk) begin
    if (we1 == 1'b1) begin
        mem[wa] <= wd;
    end
//    rd1 <= mem[ra1];
//    rd2 <= mem[ra2];
end

always_comb 
begin
   rd1 = mem[ra1];
   rd2 = mem[ra2];
   end

endmodule
