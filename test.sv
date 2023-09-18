`include "test.svh"
module gcd (
    input [DATA_WIDTH-1:0] operand_a_i, 
    input [DATA_WIDTH-1 ]operand_b_i, 
    input clk_i, 
    input nreset_i,
    output gcd_data gcd_o
);
gcd_data gcd_inputs;

typedef enum logic [1:0]{
    S_BIGA,
    S_BIGB,
    S_FINISH
} state_e;

state_e state, next_state;

always_ff @(posedge clk_i or negedge nreset_i) begin 
    if(!nreset_i) 
        state <= S_FINISH;
    else 
        state <= next_state;
end

always_ff @(posedge clk_i or negedge nreset_i) begin 
    if(!nreset_i) 
        gcd_inputs <= '0;
    else begin
        gcd_inputs.a <= operand_a_i;
        gcd_inputs.b <= operand_b_i;
    end 
        
end

always_comb begin
    case(state)
    S_BIGA : if(gcd_inputs.b > gcd_inputs.a) begin
                next_state = S_BIGB; 
            end
            else if (gcd_inputs.a == gcd_inputs.b) begin 
                next_state  = S_FINISH; 
            end
    S_BIGB : if(gcd_inputs.a > gcd_inputs.b) begin
                next_state = S_BIGA; 
            end
            else if (gcd_inputs.a == gcd_inputs.b) begin 
                next_state = S_FINISH; 
            end
    endcase
end


 
gcd_data gcd_in_temp;
gcd_data gcd_temp;

always_comb begin
    gcd_in_temp.a = '0;
    gcd_in_temp.b = '0;
    gcd_temp.a = '0; 

    case(next_state)
        S_BIGA : gcd_in_temp.a = gcd_inputs.a - gcd_inputs.b; 
        S_BIGB : gcd_in_temp.b = gcd_inputs.b - gcd_inputs.a; 
        S_FINISH : gcd_temp.a = gcd_inputs.a;
    endcase
end

always @(posedge clk_i or negedge nreset_i) begin 
if(!nreset_i) begin
gcd_o = '0; 
end
else begin
gcd_inputs.a = gcd_in_temp.a;
gcd_inputs.b = gcd_in_temp.b;
gcd_o = gcd_temp.a;
end 
end

endmodule