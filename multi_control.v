`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:14:05 03/30/2022 
// Design Name: 
// Module Name:    multi_control 
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
module multi_control(
    clk,
    reset,
    opcode,
    control_instruction,
    imm_select,
    write_enable,
    aluOP
    );
    `include "parameters.v"

    input clk ;
    input reset ;
    input [4:0] opcode ;
    output reg control_instruction ;
    output reg imm_select ;
    output reg write_enable ;
    output reg [4:0] aluOP ;

    reg [STATE_BITS-1:0] state ;
    reg [STATE_BITS-1:0] next_state ;

    always @ ( posedge clk )
      if( reset )
	state <= STATE_FETCH ;
      else
	state <= next_state ;

    always @ ( state or opcode ) begin
      next_state <= 'bX ;
      control_instruction <= 0 ;
      imm_select <= 1 ;
      write_enable <= 0 ;
      case ( state )
	STATE_FETCH: begin
	  next_state <= STATE_DECODE ;
	  control_instruction <= 1 ;

	end

	STATE_DECODE: begin
	  next_state <= STATE_EXEC ;
	  case ( opcode )
	    INSTR_ADD: begin
	    end

	    INSTR_LI: begin
	      imm_select <= 0 ;
	      write_enable <= 1 ;
	      next_state <= STATE_FETCH ;
	    end
	  endcase
	end

	STATE_EXEC: begin
	  next_state <= STATE_FETCH ;
	  aluOP <= OP_DIVIDE ;
	  case (opcode)
	    INSTR_ADD: begin
	      imm_select <= 1 ;
	      write_enable <= 1 ;
	      aluOP <= OP_ADD ;
	    end
	  endcase

	end

      endcase


    end



endmodule
