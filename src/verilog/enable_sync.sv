module enable_sync (
  input logic clk_i
  ,input logic nreset_i
  ,input logic gcd_enable_i
  ,output logic gcd_enable_o
);

  logic gcd_enable_sync;

  always@(posedge clk_i or negedge nreset_i) begin 
    if(!nreset_i) 
      gcd_enable_sync = '0;
    else
      gcd_enable_sync = gcd_enable_i; 
  end

  always@(posedge clk_i or negedge nreset_i) begin 
    if(!nreset_i) 
      gcd_enable_o = '0;
    else
      gcd_enable_o = gcd_enable_sync; 
  end

endmodule
