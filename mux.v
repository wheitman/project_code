


module mux2_36 ( 
    data0, 
    data1, 
    out, 
    select
  ) ;
  `include "parameters.v"

  input select ;
  input [DATA_BUS_WIDTH-1:0] data0 ;
  input [DATA_BUS_WIDTH-1:0] data1 ;
  output reg [DATA_BUS_WIDTH-1:0] out ;

  always @ ( select or data0 or data1 ) begin
    if ( select )
      out <= data1 ;
    else 
      out <= data0 ;
  end

endmodule
