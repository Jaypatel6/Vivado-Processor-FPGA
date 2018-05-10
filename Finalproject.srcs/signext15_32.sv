`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2016 08:33:14 PM
// Design Name: 
// Module Name: signext15_32
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


module signext15_32(
    input signed [14:0] A,
    output signed [31:0] EXT_BY_17
    );
    
    logic [16:0] ext_part;
    
    assign ext_part = {17{A[14]}}; 
    assign EXT_BY_17 = {ext_part, A};
    
endmodule
