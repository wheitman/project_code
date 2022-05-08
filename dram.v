`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:02:55 04/02/2020 
// Design Name: 
// Module Name:    ram 
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
module data_ram(
    clk,
    address,
    write_data,
    read_data,
    read_not_write,
    cs
  );

  `include "params.v"

  input [ADDRESS_BUS_WIDTH-1:0] address ;
  input [DATA_BUS_WIDTH-1:0] write_data ;
  output [DATA_BUS_WIDTH-1:0] read_data ;
  input read_not_write ;
  input cs ;
  input clk ;

  // NUM_ADDRESS/2 x INSTRUCTION_BUS_WIDTH bits 
  // parameter NUM_DATA_ADDRESSES = NUM_ADDRESS / 2 ;
  // Uncomment the parameter above for the real addresses.
  // Cut it down to 64 for debugging purposes.
  parameter NUM_DATA_ADDRESSES = 64 ;

  // Actual memory is Byte oriented!!! Try using Little Endian!
  reg [7:0] ram_memory [NUM_DATA_ADDRESSES-1:0] ;
  reg [DATA_BUS_WIDTH-1:0] ram_private ;

  initial begin

  // The Data
  ram_memory[0] = 8'd0 ;
  ram_memory[1] = 8'd1 ;
  ram_memory[2] = 8'd2 ;
  ram_memory[4] = 8'd4 ;
  ram_memory[8] = 8'd8 ;
  ram_memory[16] = 8'd20 ;
  ram_memory[17] = 8'd0 ;
  ram_memory[32] = 8'd22 ;
  ram_memory[33] = 8'd0 ;

  end

  always @ ( posedge clk ) begin
    if ( cs )
      if ( read_not_write ) begin
	     ram_private[7:0] <= ram_memory[address] ;
	     ram_private[15:8] <= ram_memory[address+1] ;
      end else begin 
	    ram_memory[address] <= write_data[7:0] ;
	    ram_memory[address+1] <= write_data[15:8] ;
    end else 
      ram_private <= 16'bz ;
  end
  assign read_data = ram_private ;

endmodule
