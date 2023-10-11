// This file is public domain, it can be freely copied without restrictions.
// SPDX-License-Identifier: CC0-1.0
`include "gcd.svh"
module gcd_fsm # (
  parameter DATA_WIDTH = 2
) (
  input logic clk_i,
  input logic nreset_i,
  input logic gcd_enable,  
  input logic compare_zero,
  output logic compute_enable,
  output logic [1:0] state_o
);
// el reset se activa cuando nreset es cero

  timeunit 1ns;
  timeprecision 1ns;

  typedef enum logic [1:0]{
      S_INIT, //00
      S_COMPUTE, //01
      S_FINISH //10
  } state_e;

  state_e state, next_state;


  always_ff @(posedge clk_i or negedge nreset_i) begin 
    if(!nreset_i) 
    begin
        state <= S_FINISH;
        state_o <= S_FINISH;
    end
    else if(gcd_enable)
    begin 
      state <= S_INIT;
      state_o <= S_INIT;      
    end
    else
    begin 
        state <= next_state;
        state_o <= state;
    end  
  end

  always_comb begin 
        case(state)
        S_INIT : begin
                if(compare_zero) begin
                  next_state = S_FINISH;
                end
                else if(compute_enable) begin
                  next_state = S_COMPUTE; 
                end
                else 
                begin
                  next_state = S_INIT;
                end
          
        end        
        S_COMPUTE : begin
                if(compare_zero) begin
                  next_state = S_FINISH;
                end
                else
                begin 
                  next_state = S_COMPUTE;
                end

        end
        S_FINISH : next_state = S_FINISH;
        default : next_state = next_state;
        endcase
  end


endmodule
