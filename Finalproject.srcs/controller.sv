`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2016 11:35:43 AM
// Design Name: 
// Module Name: controller
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


module controller(
    input logic [31:0] instr,
    output logic [5:0] rs,
    output logic [5:0] rt,
    output logic [5:0] rd,
    output logic [14:0] imm,
    output logic [3:0] ALUopsel,
    output logic MUXsel1,
    output logic MUXsel2,
    output logic REGwrite,
    output logic MEMwrite
    );
    assign MUXsel1 = instr[31];
    assign rs = instr[30:25];
    assign rd = instr[24:19];
    assign rt = instr[14:9];
    assign imm = instr[14:0];
    always_comb begin
        case(instr[18:15])
            4'b1111: begin
                     ALUopsel = 4'b0010; 
                     REGwrite = 0;
                     MEMwrite = 0;
                     MUXsel2 = 1;
                     end
            4'b0000: begin 
                     ALUopsel = 4'b0000;
                     REGwrite = (instr[24:19] == 6'b0) ? 0:1;
                     MEMwrite = 0;
                     MUXsel2 = 1;
                     end
            4'b0011: begin
                     ALUopsel = 4'b0011;
                     REGwrite = (instr[24:19] == 6'b0) ? 0:1;
                     MEMwrite = 0;
                     MUXsel2 = 1;
                     end
            4'b1000: begin
                     ALUopsel = 4'b1000;
                     REGwrite = (instr[24:19] == 6'b0) ? 0:1;
                     MEMwrite = 0;
                     MUXsel2 = 1;
                     end
            4'b1001: begin
                     ALUopsel = 4'b1001;
                     REGwrite = (instr[24:19] == 6'b0) ? 0:1;
                     MEMwrite = 0;
                     MUXsel2 = 1;
                     end
            4'b1011: begin
                     ALUopsel = 4'b1011;
                     REGwrite = (instr[24:19] == 6'b0) ? 0:1;
                     MEMwrite = 0;
                     MUXsel2 = 1;
                     end
            4'b1010: begin 
                     ALUopsel = 4'b1010;
                     REGwrite = (instr[24:19] == 6'b0) ? 0:1;
                     MEMwrite = 0;
                     MUXsel2 = 1;
                     end
            4'b1101: begin
                     ALUopsel = 4'b1101;
                     REGwrite = (instr[24:19] == 6'b0) ? 0:1;
                     MEMwrite = 0;
                     MUXsel2 = 1;
                     end                     
            4'b0010: begin
                     ALUopsel = 4'b0010;
                     REGwrite = (instr[24:19] == 6'b0) ? 0:1;
                     MEMwrite = 0;
                     MUXsel2 = 1;
                     end                     
            4'b0100: begin
                     ALUopsel = 4'b0010;
                     REGwrite = (instr[24:19] == 6'b0) ? 0:1;
                     MEMwrite = 0;
                     MUXsel2 = 0;
                     end                     
            4'b0110: begin 
                     ALUopsel = 4'b0010;
                     REGwrite = 0;
                     MEMwrite = 1;
                     MUXsel2 = 1;////
                     end
            default: begin
                     ALUopsel = 4'b0010; 
                     REGwrite = 0;
                     MEMwrite = 0;
                     MUXsel2 = 1;
                     end
      endcase
      end                            
endmodule
