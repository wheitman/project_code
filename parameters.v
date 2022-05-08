// Here are the parameter definitions for all modules
parameter ADDRESS_BUS_WIDTH = 14 ;
// parameter NUM_ADDRESS = 16384 ;
parameter NUM_ADDRESS = (1 << ADDRESS_BUS_WIDTH) ;

parameter PROGRAM_LOAD_ADRESS = 2048 ;
parameter DATA_BUS_WIDTH = 36 ;
parameter REGFILE_ADDR_BITS = 5 ;
parameter NUM_REGISTERS = (1 << REGFILE_ADDR_BITS) ;
parameter WIDTH_REGISTER_FILE = 36 ;
parameter INSTRUCTION_WIDTH = 28 ;
parameter IMMEDIATE_WIDTH = 8 ;
parameter NUM_INSTRUCTIONS = 32 ;
parameter WIDTH_OPCODE = 5 ;
parameter INSTR_NOP = 0 ;
parameter INSTR_ADD = 1 ;
parameter INSTR_LR = 2 ;
parameter INSTR_SR = 3 ;
parameter INSTR_BNEQ = 4 ;
parameter INSTR_MOV = 5 ;
parameter INSTR_LI = 6 ;
parameter INSTR_ADDI = 7 ;

parameter OP_ADD = 0 ;
parameter OP_SUB = 1 ;
parameter OP_AND = 2 ;
parameter OP_OR = 3 ;
parameter OP_EQUAL = 4 ;
parameter OP_DIVIDE = 5 ;

// parameter NUM_STATES = 16 ;
parameter STATE_BITS = 4 ;
parameter NUM_STATES = (1<<STATE_BITS) ;

parameter STATE_FETCH = 0 ;
parameter STATE_DECODE = 1 ;
parameter STATE_EXEC = 2 ;

//    register file index $4 it takes 5 bits to encode r0...r31
///   addr  --------------------
//          | 36            10 |
//       r0 |  .............   |      Address has nothing to do with the size of data!
//       r1 |  width of data   |      Address | Data tupple (A,D)
//          |                  |
//       .  |                  |
//       .  |                  |
//       .  |                  |
//          |                  |
//       r31|                  |
//          |                  |
///         --------------------
//
