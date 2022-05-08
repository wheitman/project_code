
module inst_register( 
    clk, 
    in_data, 
    instruction,
    en
  ) ;

  `include "parameters.v"

  input clk ;
  input en ;
  input [INSTRUCTION_WIDTH-1:0] in_data ;
  output reg [INSTRUCTION_WIDTH-1:0] instruction ;

  always @ (posedge clk) begin
    if ( en )
      instruction[INSTRUCTION_WIDTH-1:0] <= in_data ;
  end

endmodule
