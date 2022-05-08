
// Sample Instruction Set Architecture Design
// 1) Choose 2 operand data operations - accumulator mode
// 2) Choose Register names indexed as R<integer> valid for [0..NUM_REGISTERS-1]
// 3) (R0) <-> 0 
module decode_instruction(
  instruction,
  reg_dest,     // Overwritten
  reg_source,   // Not overwritten
  immediate,
  opcode,
  decoded) ;
  `include "parameters.v"

  input [INSTRUCTION_WIDTH-1:0] instruction ;
  output [REGFILE_ADDR_BITS-1:0] reg_source ;
  output [REGFILE_ADDR_BITS-1:0] reg_dest ;
  output [IMMEDIATE_WIDTH-1:0] immediate ;
  output [WIDTH_OPCODE-1:0] opcode ;
  output [NUM_INSTRUCTIONS-1:0] decoded ;

  //   Ri .... R7  log 7 base 2 = 3
  // Instruction format 1: Data computation 
  // ASSEMBLY: add R1, R2  ; R1 = R1 + R2 ;
  // opcode | reg_dest | reg_source | unused  
  //   5    |    5     |    5          15      // 28 - 15  = 13
  // 27..23   22..18     17..13 
  parameter OPCODE_LSB = INSTRUCTION_WIDTH - WIDTH_OPCODE ;
  assign opcode = instruction[INSTRUCTION_WIDTH-1:OPCODE_LSB];
  // assign opcode = instruction[25:21];
  // This gives 26-1 : 25-5 or [25:21]   25 24 23 22 21
  //
  parameter DEST_LSB = OPCODE_LSB - REGFILE_ADDR_BITS ;
  assign reg_dest = instruction[OPCODE_LSB-1:DEST_LSB] ;
  // assign reg_dest = instruction[20:18] ;
  // This gives 26-5-1 : 26-5-3 or [20:18]   20 19 18
  //
  // Add parameter here:
  parameter SOURCE_MSB = DEST_LSB - 1 ;
  parameter SOURCE_LSB = SOURCE_MSB - REGFILE_ADDR_BITS + 1 ;
  // assign reg_source = instruction[SOURCE_MSB:SOURCE_LSB] ;
  assign reg_source = instruction[17:13] ;

  // This gives 26-5-3-1 : 26-5-6 or [17:15]   17 16 15

  assign immediate = instruction[IMMEDIATE_WIDTH-1:0] ;

  // Instruction formats:
  //
  // ASSEMBLY: nop
  // opcode = INSTR_NOP
  // opcode | unused
  //   5    |   21      // 26 - 5  = 21
  //
  // ASSEMBLY: add R1, R2  ; R1 <= R1 + R2 ;
  // opcode = INSTR_ADD
  // opcode | reg_dest | reg_source | unused  
  //   5    |    3     |    3          15      // 26 - 11  = 15

  // Instruction format 2a: Load Register or lr
  // See my assembly scaled displacement form looks like an array
  // ASSEMBLY: lr RDest, RSource[Immediate] : lr R2, R1[0x10] or load ((R1)+0x10) into R2
  // opcode = INSTR_LR
  // opcode | reg_dest | reg_source | unused | immediate   
  //   5    |    3     |    3          3        12     // 26 - 11 - 12 = 3
  //
  // Instruction format 2b: Save Register
  // ASSEMBLY: sr RDest[Immediate], Rsource : sr R1[0x10], R2 or save R2 -> ((R1)+0x10)
  // opcode = INSTR_SR
  // opcode | reg_dest | reg_source | unused | immediate   
  //   5    |    3     |    3          3        12     // 26 - 11 - 12 = 3
    
  // Your other instructions here.
  //
   
  // Program C = A + B   A @ 0x10 B @ 0x20 C @ 0x30
  // li R5, 20
  // li R8, 22
  // add R8, R5  ; R8 <= (R5) + (R8)
  //
  // Program machine encoding:
  // li opcode = 6. li R5, 20
  // opcode | reg_dest | reg_source | unused | immediate   
  //   5    |    5     |    5          5        8     // 28 - 23 = 5
  // 00110     00101       00000      00000    0001 0100  16 + 4 -> 0x14
  // regroup bits:
  // 0011 0001 0100 0000 0000    0001 0100  16 + 4 -> 0x14
  //
  // hex value:
  // 0x3140014
  //
  // li opcode = 6. li R8, 22
  // opcode | reg_dest | reg_source | unused | immediate   
  //   5    |    5     |    5          5        8     // 28 - 15 - 8 = 5
  // 00110     01000       00000      00000    0001 0110
  // regroup bits:
  // 0011 0010 0000 0000 0000    0001 0110
  // hex value:
  // 0x3200016
  //
  // add opcode = 1. add R8, R5  ; R8 <= (R5) + (R8)
  // opcode | reg_dest | reg_source | unused | unused   
  //   5    |    5     |    5       |  5        8     // 28 - 15 = 13
  // 00001    01000       00101        00000    0000 0000
  // regroup bits:
  // 0000 1010 0000 1010 0000    0000 0000
  // hex value:
  // 0x0A0A000
  //
  // sr opcode = 3. sr Rd[immediate], Rsource
  // ASSEMBLY: sr RDest[Immediate], Rsource : sr R0[0x30], R2
  // opcode | reg_dest | reg_source | unused | immediate   
  //   5    |    3     |    3          3        12     // 26 - 11 - 12 = 3
  // 00011     000        010         000       0000 0011 0000
  // regroup bits:
  // 00  0110  0001  0000       0000 0011 0000
  // hex value:
  // 0x0610030
  //
  // Program 1:
  // 0x0440010
  // 0x0480020
  // 0x0288000
  // 0x0610030
  //
  // Program 2:
  // int sum = 0 ;
  // for( i = 0 ; i <= 10 ; i++ ){
  //   sum += i ; 
  // }
  // Assembly code for sum progam here:
  //
  // Machine code sum progam here:
    
endmodule

