`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2016 09:45:35 PM
// Design Name: 
// Module Name: mtp_Team DJ_alu
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


module alu_32bit ( op1 , op2 , opsel , mode , result , c_flag , z_flag , o_flag , s_flag );

    parameter DWIDTH = 32;

    input  logic [ DWIDTH -1:0] op1 ;
    input  logic [ DWIDTH -1:0] op2 ;
    input  logic [ 2:0]         opsel ;
    input  logic                mode ;
    output logic [ DWIDTH -1:0] result ;
    output logic                c_flag ;
    output logic                z_flag ;
    output logic                o_flag ;
    output logic                s_flag ;
    logic [DWIDTH-1:0] temp;
    logic [2:0] tempsel;
    logic [0:0] [2:0] tempsel2 [DWIDTH-1];
    logic [DWIDTH-1:0] tempb;
    alu_1bit alu0 (.op1(op1[0]),
                   .op2(op2[0]),
                   .cin(1'b0),
                   .opsel(opsel),
                   .mode(mode),
                   .result(result[0]),
                   .c_flag(temp[0])
                   );
    assign tempsel = (mode == 0 && opsel == 3'b100) ? 3'b000 : (mode == 0 && opsel == 3'b101) ? 3'b011:
                                     (mode == 0 && opsel == 3'b110) ? 3'b000 :(mode == 0 && opsel == 3'b011) ? 3'b001: opsel;
    assign tempb = (mode == 0 && opsel == 3'b100) ? 0:(mode == 0 && opsel == 3'b101) ? 0 :op2;
    genvar i;
    generate
     for(i=1;i<DWIDTH;i=i+1) begin
      assign tempsel2[i-1][0] = (mode == 0 && opsel == 3'b101 && temp[i-1] == 1'b0) ? 3'b010:
                       (mode == 0 && opsel == 3'b101 && temp[i-1] == 1'b1) ? 3'b101: tempsel;
      alu_1bit alui (.op1(op1[i]),
                     .op2(tempb[i]),
                     .cin(temp[i-1]),
                     .opsel(tempsel2[i-1][0]),
                     .mode(mode),
                     .result(result[i]),
                     .c_flag(temp[i])
                     );
     end
   endgenerate
   assign s_flag = result[DWIDTH-1];
   assign z_flag = (result == 0) ? 1:0;
   assign c_flag = (mode == 0'b0 && (opsel == 3'b001 || opsel == 3'b011)) ? temp[DWIDTH-1] + 1'b1 : temp[DWIDTH-1];
   assign o_flag = (mode == 1'b0) ? (temp[DWIDTH-1]^temp[DWIDTH-2]):1'bz;
  endmodule 

module alu_1bit ( op1 , op2 , cin, opsel , mode , result , c_flag, z_flag , o_flag , s_flag );

    input  logic        op1 ;
    input  logic        op2 ;
    input  logic        cin ;
    input  logic [2:0] opsel ;
    input  logic        mode ;
    output logic        result ;
    output logic        c_flag ;
    output logic        z_flag ;
    output logic        o_flag ;
    output logic        s_flag;
    
    logic temp1,temp2;
    logic ctemp1,ctemp2;
    arithmetic_unit l1(.a(op1),
                       .b(op2),
                       .sel(opsel),
                       .cin(cin),
                       .o(temp1),
                       .cout(ctemp1)
                       );
    logic_unit l2(.a(op1),
                  .b(op2),
                  .sel(opsel),
                  .cin(cin),
                  .o(temp2),
                  .cout(ctemp2)
                  );
   mux21 l3(.a(temp1),
            .b(temp2),
            .sel(mode),
            .out(result)
            );
    mux21 l4(.a(ctemp1),
             .b(ctemp2),
             .sel(mode),
             .out(c_flag)
             );
            

endmodule 

module arithmetic_unit(
    input logic a,
    input logic b,
    input logic [2:0] sel,
    input logic cin,
    output logic o,
    output logic cout
    );
    logic btemp,ctemp;
    logic mode;
    assign mode = (sel == 3'b101)?(1'b1):(1'b0);
    mux8_1 b1(
        .a(b),
        .b(~b),
        .c(1'b0),
        .d(~b),
        .e(1'b0),
        .f(1'b0),
        .g(b),
        .h(z),
        .sel(sel),
        .o(btemp)
        );
    mux8_1 c1(
        .a(cin),
        .b(cin),      
        .c(1'b0),
        .d(1'b1),      
        .e(1'b1),
        .f(1'b1),
        .g(1'b1),
        .h(z),
        .sel(sel),
        .o(ctemp)
        ); 
    add_sub g1(
        .x(a),
        .y(btemp),
        .cin(ctemp),
        .mode(mode),
        .o(o),
        .cout(cout)
        );       
    
    
endmodule

module logic_unit(
    input logic a,
    input logic b,
    input logic cin,
    input logic [2:0] sel,
    output logic o,
    output logic cout
    );
    mux8_1 l1(
        .a(a&b),
        .b(a|b),
        .c(a^b),
        .d(~a),
        .e(z),
        .f(cin),
        .g(z),
        .h(z),
        .sel(sel),
        .o(o)
        );
   assign cout = (sel == 3'b101) ? a:z;
endmodule

module mux8_1(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    input logic e,
    input logic f,
    input logic g,
    input logic h,
    input [2:0] sel,
    output o
    );
    logic temp1,temp2;
    mux41 l1(
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .s0(sel[0]),
        .s1(sel[1]),
        .out(temp1)
        );
    mux41 l2(
            .a(e),
            .b(f),
            .c(g),
            .d(h),
            .s0(sel[0]),
            .s1(sel[1]),
            .out(temp2)
            );        
    mux21 l3(
        .a(temp1),
        .b(temp2),
        .sel(sel[2]),
        .out(o)
        );
endmodule

module mux41(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    input logic s0,
    input logic s1,
    output logic out
    );
    
    logic temp1,temp2;
    mux21 l1(
                    .a(a),
                    .b(b),
                    .sel(s0),
                    .out(temp1));
    mux21 l2(
                     .a(c),
                     .b(d),
                     .sel(s0),
                     .out(temp2));
    mux21 l3(
                     .a(temp1),
                     .b(temp2),
                      .sel(s1),
                      .out(out));
endmodule

module mux21(
    input logic a,
    input logic b,
    input logic sel,
    output logic out
    );
    
    assign out = (sel == 1'b0)? a:b;
endmodule

module add_sub( 
    input logic x,  
    input logic y,
    input logic cin,
    input logic mode,
    output logic o,
    output logic cout
);
    logic m1, m2, m4, m7;
    assign m1=(~x& ~y& cin);
    assign m2=(~x& y& ~cin);
    assign m4=( x& ~y& ~cin);
    assign m7=( x& y& cin);
    assign o = (m1 | m2| m4| m7);
    assign cout = (mode == 1'b0) ? (x&y)|(cin&(x|y)): (~x&cin)|(~x&y)|(y&cin);
endmodule
    
