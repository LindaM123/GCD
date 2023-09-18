localparam DATA_WIDTH = 2;
typedef struct packed{
    logic signed [DATA_WIDTH-1:0] a;
    logic signed [DATA_WIDTH-1:0] b;
} gcd_data; 
