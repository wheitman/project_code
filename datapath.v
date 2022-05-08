`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:52:44 04/19/2022 
// Design Name: 
// Module Name:    reg_alu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module datapath( clk, reset, mem_data );
`include "parameters.v"

   input clk ;
   input reset ;
   input [DATA_BUS_WIDTH-1:0] mem_data ;

   wire [DATA_BUS_WIDTH-1:0] databus ;
   wire [DATA_BUS_WIDTH-1:0] alu_in1 ;
   wire [DATA_BUS_WIDTH-1:0] alu_in2 ;
   wire [DATA_BUS_WIDTH-1:0] write_data ;
   wire [4:0] read1_addr ;
   wire [4:0] read2_addr ;
   wire [4:0] write_addr ;
   wire [3:0] flags ;
   wire write_enable ;
   wire control_instruction ;
   wire [4:0] aluOP ;
   wire [IMMEDIATE_WIDTH-1:0] immediate ;
   wire [WIDTH_OPCODE-1:0] opcode ;
   wire [INSTRUCTION_WIDTH-1:0] instruction ;

  inst_register iregister( .clk(clk), .en(control_instruction), .in_data(mem_data[27:0]), 
                           .instruction(instruction) ) ;
  decode_instruction decode( .instruction(instruction), .reg_source(read1_addr), 
                             .reg_dest(read2_addr),  .immediate(immediate), .opcode(opcode) ) ;

  regfile reg1 ( .write_addr( read2_addr), .write_data(write_data), 
                  .read1_addr(read1_addr), .read2_addr(read2_addr),
                  .read1(alu_in1), .read2(alu_in2), .write_enable(write_enable), .clk(clk) ) ;
  ALU alu1 ( .out(databus), .in1(alu_in1), .in2(alu_in2), .op(aluOP), .flags(flags) ) ; 

  mux2_36 imm_mux ( .data0({28'b0,immediate}), .data1(databus), .out(write_data), 
                    .select(imm_select) ) ; 

  multi_control control ( .clk(clk), .reset(reset), .opcode(opcode), 
                          .control_instruction(control_instruction),
                          .imm_select(imm_select), .write_enable(write_enable),
			  .aluOP(aluOP) ) ;

endmodule


