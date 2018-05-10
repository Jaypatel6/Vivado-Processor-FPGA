`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2016 12:59:53 PM
// Design Name: 
// Module Name: fp_Team DJ_processor
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


module processor(
    input logic clk,
    input logic rst,
    output logic [31:0] reg_write_data
    );

    logic [5:0] count;
    counter6bit PC(.clk(clk),
                   .reset(rst),
                   .count(count));
    logic [31:0] inst;
    instruction_memory im(.addr(count),
                          .data(inst));
    logic [5:0] rs;
    logic [5:0] rt;
    logic [5:0] rd;
    logic [14:0] imm;
    logic [3:0] ALUopsel;
    logic MUXsel1;
    logic MUXsel2;
    logic REGwrite;
    logic MEMwrite;
    controller cont(.instr(inst),
                    .rs(rs),
                    .rt(rt),
                    .rd(rd),
                    .imm(imm),
                    .ALUopsel(ALUopsel),
                    .MUXsel1(MUXsel1),
                    .MUXsel2(MUXsel2),
                    .REGwrite(REGwrite),
                    .MEMwrite(MEMwrite));
    logic [31:0] OperandA;
    logic [31:0] rd2;
    logic [31:0] wd;    
    reg_file rf(.ra1(rs),
                .ra2(rt),
                .wa(rd),
                .wd(wd),
                .we1(REGwrite),
                .rd1(OperandA),
                .clk(clk),
                .rd2(rd2));
   logic [31:0] ext_imm;
   signext15_32 ext(.A(imm),
                    .EXT_BY_17(ext_imm));
   logic [31:0] OperandB;
   mux21_32 mux1(.a(rd2),
              .b(ext_imm),
              .sel(MUXsel1),
              .out(OperandB));
   logic [31:0] ALUresult;
   logic c_flag;
   logic z_flag;
   logic o_flag;
   logic s_flag;
   alu_32bit alu(.op1(OperandA),
                         .op2(OperandB),
                         .opsel(ALUopsel[2:0]),
                         .mode(ALUopsel[3]),
                         .result(ALUresult),
                         .c_flag(c_flag),
                         .z_flag(z_flag),
                         .o_flag(o_flag),
                         .s_flag(s_flag));

  logic [31:0] read_data; 
  logic [6:0] dmemaddr;
  assign dmemaddr =  ALUresult[6:0];
  data_memory dm(.address(dmemaddr),
                 .wd(rd2),
                 .we2(MEMwrite),
                 .clk(clk),
                 .rd(read_data));
            
  mux21_32 mux2(.a(read_data),
             .b(ALUresult),
             .sel(MUXsel2),
             .out(wd));
  
  assign reg_write_data = wd;                          
endmodule

module mux21_32(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic sel,
    output logic [31:0] out
    );
    assign out = (sel == 1'b0)? a:b;
endmodule
