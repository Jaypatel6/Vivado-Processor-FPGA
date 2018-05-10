`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2016 08:43:38 PM
// Design Name: 
// Module Name: counter6bit
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


module counter6bit(
    input logic clk,
    input logic reset,
    output logic [5:0] count);

    logic [5:0] temp = 0;
    
always_ff @( posedge clk ) begin
    if ( reset ) begin
        temp <= 0;
    end else begin
        if ( temp == 63 ) begin
            temp <= 0;
        end else begin
            temp <= temp + 1;
        end
    end
end

assign count = temp;

endmodule
