// This file is public domain, it can be freely copied without restrictions.
// SPDX-License-Identifier: CC0-1.0
`include "gcd.svh"
module my_design_gcd1 # (
  parameter DATA_WIDTH = 2
) (
  input [DATA_WIDTH-1:0] operand_a_i, 
  input [DATA_WIDTH-1:0] operand_b_i, 
  input logic clk_i,
  input logic nreset_i,
  output gcd_data gcd_o
);
// el reset se activa cuando nreset es cero

  timeunit 1ns;
  timeprecision 1ns;

  gcd_data gcd_inputs;

  typedef enum logic [1:0]{
      S_BIGA, //00
      S_BIGB, //01
      S_FINISH //10
  } state_e;

  state_e state, next_state;

  always_ff @(posedge clk_i or negedge nreset_i) begin 
    if(!nreset_i) 
        state = S_FINISH;
    else 
        state = next_state;
  end


  always_ff @(posedge clk_i or negedge nreset_i) begin 
    if(!nreset_i) 
        gcd_inputs = '0;
    else begin
        gcd_inputs.a = operand_a_i;
        gcd_inputs.b = operand_b_i;
    end 
        
  end

  always_comb begin
      case(state)
      S_BIGA : begin
              if(gcd_inputs.b > gcd_inputs.a) begin
                next_state = S_BIGB; 
              end
              else if (gcd_inputs.a == gcd_inputs.b) begin 
                  next_state  = S_FINISH; 
              end
      end
      S_BIGB : begin
              if(gcd_inputs.a > gcd_inputs.b) begin 
                next_state = S_BIGA; 
              end
              else if (gcd_inputs.a == gcd_inputs.b) begin 
                next_state = S_FINISH; 
              end
      end
      default : next_state = S_FINISH;
      endcase
  end

  logic signed [DATA_WIDTH-1:0] sub;
  
  gcd_data gcd_in_temp;
  gcd_data gcd_o_temp;

  always_comb begin
      sub = gcd_inputs.a - gcd_inputs.b;
      case(next_state)
          S_BIGA : gcd_in_temp.a = sub; 
          S_BIGB : gcd_in_temp.b = !(sub - 1); 
          S_FINISH : gcd_o_temp.a = gcd_inputs.a;
          default : gcd_o_temp.a = '0;
      endcase
  end

  always @(posedge clk_i or negedge nreset_i) begin 
    if(!nreset_i) begin
      gcd_o = '0; 
    end
    else begin
      gcd_inputs.a = gcd_in_temp.a;
      gcd_inputs.b = gcd_in_temp.b;
      gcd_o = gcd_o_temp.a;
    end 
  end


endmodule
