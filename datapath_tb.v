`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:03:14 04/19/2022
// Design Name:   reg_alu
// Module Name:   /home/eng/w/wps100020/EE4304/spring2022_3/Project/reg_alu_tb.v
// Project Name:  Project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: reg_alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module datapath_tb ;
`include "parameters.v"

	// Inputs
	reg clk;
	reg reset;
	reg [DATA_BUS_WIDTH-1:0] mem_data ;

	integer i ;

	// Instantiate the Unit Under Test (UUT)
	datapath uut (
		.clk(clk), 
		.reset(reset), 
		.mem_data(mem_data) 
	);

	wire [STATE_BITS-1:0] st ;
	wire [STATE_BITS-1:0] next_st ;
        wire [INSTRUCTION_WIDTH-1:0] instr ;
	wire [IMMEDIATE_WIDTH-1:0] imm ;
	wire [REGFILE_ADDR_BITS-1:0] ra1 ;
	wire [REGFILE_ADDR_BITS-1:0] ra2 ;
	wire [DATA_BUS_WIDTH-1:0] r5 ;
	wire [DATA_BUS_WIDTH-1:0] r8 ;
        wire [4:0] aluOP ;
	wire [DATA_BUS_WIDTH-1:0] databus ;

	assign st = uut.control.state ;
	assign next_st = uut.control.next_state ;
	assign instr = uut.iregister.instruction ;
	assign imm = uut.immediate ;
	assign subclk = uut.iregister.clk ;
	assign sel = uut.imm_select ;
	assign r5 = uut.reg1.reg_data[5] ;
	assign r8 = uut.reg1.reg_data[8] ;
	assign we = uut.write_enable ;
	assign ra1 = uut.read1_addr ;
	assign ra2 = uut.read2_addr ;
	assign aluOP = uut.aluOP ;
	assign db = uut.alu_in2 ;


	initial begin
	        // $dumpfile ( "datapath.vcd" ) ;
	        // $dumpvars ;
		// Initialize Inputs
		clk = 0;
		reset = 0 ;
		mem_data = 'h3140014 ;
		#100 ;
		$display("%d %b %b %x %d %d %x %d %b %b %d %d %b %d %d %d %d", $stime, clk, reset, mem_data, 
		  st, next_st, instr, imm, subclk, sel, r5, r8, we, ra1, ra2,aluOP,db);
		// $monitor("%d %b %b %x %d %d %x %d %b %b %d %d %b %d %d", $stime, clk, reset, mem_data, 
		  // st, next_st, instr, imm, subclk, sel, r5, r8, we, ra1, ra2);


		// Reset
		reset = 1 ;
		for( i = 0 ; i < 3 ; i = i + 1) begin
		  #100;
		  $display("%d %b %b %x %d %d %x %d %b %b %d %d %b %d %d %d %d", $stime, clk, reset, mem_data, 
		    st, next_st, instr, imm, subclk, sel, r5, r8, we, ra1, ra2,aluOP,db);
		 //  $monitor("%d %b %b %x %d %d %x %d %b %b %d %d %b %d %d", $stime, clk, reset, mem_data, 
		 //    st, next_st, instr, imm, subclk, sel, r5, r8, we, ra1, ra2);
		end

		reset = 0 ;
		for( i = 0 ; i < 6 ; i = i + 1) begin
		  #100;
		  $display("%d %b %b %x %d %d %x %d %b %b %d %d %b %d %d %d %d", $stime, clk, reset, mem_data, 
		    st, next_st, instr, imm, subclk, sel, r5, r8, we, ra1, ra2,aluOP,db);
		  // $monitor("%d %b %b %x %d %d %x %d %b %b %d %d %b %d %d", $stime, clk, reset, mem_data, 
		  //   st, next_st, instr, imm, subclk, sel, r5, r8, we, ra1, ra2);
		end
		mem_data = 'h3200016 ;

		for( i = 0 ; i < 6 ; i = i + 1) begin
		  #100;
		  $display("%d %b %b %x %d %d %x %d %b %b %d %d %b %d %d %d %d", $stime, clk, reset, mem_data, 
		    st, next_st, instr, imm, subclk, sel, r5, r8, we, ra1, ra2,aluOP,db);
		  // $monitor("%d %b %b %x %d %d %x %d %b %b %d %d %b %d %d", $stime, clk, reset, mem_data, 
		  //   st, next_st, instr, imm, subclk, sel, r5, r8, we, ra1, ra2);
		end

		mem_data = 'h0A0A000 ;
		for( i = 0 ; i < 10 ; i = i + 1) begin
		  #100;
		  $display("%d %b %b %x %d %d %x %d %b %b %d %d %b %d %d %d %d", $stime, clk, reset, mem_data, 
		    st, next_st, instr, imm, subclk, sel, r5, r8, we, ra1, ra2,aluOP,db);
		  // $monitor("%d %b %b %x %d %d %x %d %b %b %d %d %b %d %d", $stime, clk, reset, mem_data, 
		  //   st, next_st, instr, imm, subclk, sel, r5, r8, we, ra1, ra2);
		end
        
		#100 $finish ;

	end

	always #100 clk = !clk ;
      
endmodule

