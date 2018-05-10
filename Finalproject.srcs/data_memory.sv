`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2016 09:08:50 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input logic [6:0]  address,
    input logic [31:0]  wd,
    input logic         we2,
    input logic clk,
    output logic [31:0] rd    
);

logic [31:0] mem [127:0];
always_ff @(posedge clk) begin
    if (we2 == 1'b1) begin
        mem[address] <= wd;
    end
  //  rd <= mem[address];
end
always_comb
begin
  rd = mem[address];
  end
  
endmodule
