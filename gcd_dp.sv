// This file is public domain, it can be freely copied without restrictions.
// SPDX-License-Identifier: CC0-1.0
`include "gcd.svh"
module my_design_gcd1 # (
  parameter DATA_WIDTH = 2
) (
  input logic [DATA_WIDTH-1:0] operand_a_i,
  input logic [DATA_WIDTH-1:0] operand_b_i, 
  input logic clk_i,
  input logic nreset_i,
  input logic [1:0] state,
  input logic gcd_enable,
  output logic compute_enable,
  output logic compare_zero,
  output gcd_data gcd_o
);

  timeunit 1ns;
  timeprecision 1ns;

  gcd_data gcd_inputs = '0;
//  logic signed [DATA_WIDTH-1:0] sub;
  logic msb;
  gcd_data gcd_o_temp  = '0;



always_ff @(posedge clk_i or negedge nreset_i) begin
    
    if(!nreset_i) 
        gcd_inputs.a <= '0;
    else if(!msb && (state== 2'b01)) //if state is INIT
    begin
      if(state==2'b00 && gcd_enable)
      begin
        gcd_inputs.a <= operand_a_i;
      end
      else
        gcd_inputs.a <= gcd_o_temp.a;
    end 
    else
    begin
        gcd_inputs.a <= gcd_inputs.a;
    end


    if(!nreset_i) 
        gcd_inputs.b <= '0;
    else if(msb && (state==S_COMPUTE)) //if state is INIT
    begin
      if(state==2'b00 && gcd_enable)
      begin
        gcd_inputs.b <= operand_b_i;
      end
      else
        gcd_inputs.b <= gcd_o_temp.a;
    end 
    else
    begin
        gcd_inputs.b <= gcd_inputs.b;
    end 
end



always_comb begin     
  if(gcd_inputs.a == 2'b00)
  begin
    gcd_inputs.a = gcd_inputs.b;
    compare_zero = 1;
  end
      
  if(gcd_inputs.b == 2'b00)
  begin
    compare_zero = 1;
  end

  if()
  sub = gcd_inputs.a - gcd_inputs.b;
  msb = sub[DATA_WIDTH-1];
  
  if(msb)
  begin
    gcd_o_temp.a <= !(sub-1);
  end
  else
  begin
    gcd_o_temp.a <= sub;
  end
  compute_enable <= !(compare_zero) && gcd_enable;
end

always @(posedge clk_i or negedge nreset_i) begin 
    if(!nreset_i) begin
      gcd_o = '0; 
    end
    else if(state == 2'b10) begin
      gcd_o.a = gcd_o_temp.a;
      gcd_o.b = gcd_o_temp.a;
    end 
end


endmodule
