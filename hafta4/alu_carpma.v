
module multiplier4 (
    input  [3:0] a,
    input  [3:0] b,
    output [3:0] product
);
 
    wire [3:0] pp0 = a & {4{b[0]}};              
    wire [3:0] pp1 = {a[2:0], 1'b0} & {4{b[1]}};
    wire [3:0] pp2 = {a[1:0], 2'b00} & {4{b[2]}};
    wire [3:0] pp3 = {a[0],   3'b000} & {4{b[3]}};

    wire [3:0] s1, s2;
    wire       c1, c2, c3;

    adder4 add1 (.a(pp0), .b(pp1), .cin(1'b0), .sum(s1),      .cout(c1));
    adder4 add2 (.a(s1),  .b(pp2), .cin(1'b0), .sum(s2),      .cout(c2));
    adder4 add3 (.a(s2),  .b(pp3), .cin(1'b0), .sum(product), .cout(c3));
endmodule


// ALU
module alu (
    input  [3:0] a,
    input  [3:0] b,
    input  [1:0] select,
    output reg [3:0] result
);

    wire [3:0] sum_out;
    wire [3:0] diff_out;
    wire [3:0] mul_out;
    wire       sum_cout;
    wire       diff_cout;

    adder4      u_add (.a(a), .b(b), .cin(1'b0), .sum(sum_out), .cout(sum_cout));
    subtractor4 u_sub (.a(a), .b(b), .diff(diff_out), .cout(diff_cout));
    multiplier4 u_mul (.a(a), .b(b), .product(mul_out));

    always @(*) begin
        case (select)
            2'b00:   result = sum_out;  
            2'b01:   result = diff_out; 
            2'b10:   result = a & b;    
            2'b11:   result = mul_out;   
            default: result = 4'b0000;
        endcase
    end

endmodule
