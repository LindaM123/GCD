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
  output gcd_data gcd_o
);
// el reset se activa cuando nreset es cero

  timeunit 1ns;
  timeprecision 1ns;

  gcd_data gcd_inputs = '0;
  
  logic signed [DATA_WIDTH-1:0] sub;
  
  gcd_data gcd_in_temp = '0;
  gcd_data gcd_o_temp  = '0;



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

  always_comb begin
      if(gcd_inputs.b == 2'b00 | gcd_inputs.a == 2'b00)
      begin 
              gcd_inputs.a = operand_a_i;
              gcd_inputs.b = operand_b_i;
              if (operand_b_i == 0) begin 
                next_state = S_FINISH; 
              end
              else if (operand_a_i  == 0) begin 
                  gcd_inputs.a = operand_b_i;
                  next_state = S_FINISH;
              end
              else if(operand_a_i > operand_b_i) begin 
                next_state = S_BIGA; 
              end
              else if (operand_b_i > operand_a_i) begin 
                next_state = S_BIGB; 
              end
              else if (operand_a_i == operand_b_i) begin 
                gcd_inputs.a = operand_a_i;
                next_state = S_FINISH; 
              end

      end
      else if (gcd_inputs.b > 2'b00 && gcd_inputs.a > 2'b00)
      begin 
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
        S_FINISH : next_state = S_FINISH;
        default : next_state = next_state;
        endcase
      end
  end



  always_comb begin
      sub = gcd_inputs.a - gcd_inputs.b;
      case(state)
          S_BIGA :begin  
                  gcd_in_temp.a = sub; 
//                  gcd_in_temp.b = gcd_inputs.b;
                  end
          S_BIGB :begin  
//                  gcd_in_temp.a = gcd_inputs.a;
                  gcd_in_temp.b = !(sub - 1); 
                  end
          S_FINISH : begin
                  gcd_o_temp.a = gcd_inputs.a;
                  gcd_o_temp.b = gcd_inputs.a;
                  gcd_in_temp.a = gcd_inputs.a;
                  gcd_in_temp.b = gcd_inputs.b;
                  end
          default : begin 
                  gcd_o_temp.a = '0;
                  gcd_o_temp.b = '0;
                  end
      endcase
  end

  always @(posedge clk_i or negedge nreset_i) begin 
    if(!nreset_i) begin
      gcd_o = '0; 
    end
    else begin
      gcd_o.a = gcd_o_temp.a;
      gcd_o.b = gcd_o_temp.b;
      gcd_inputs.a = gcd_in_temp.a;
      gcd_inputs.b = gcd_in_temp.b;
    end 
  end


endmodule
