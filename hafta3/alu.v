
module full_adder (
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule


module adder4 (
    input  [3:0] a,
    input  [3:0] b,
    input        cin,
    output [3:0] sum,
    output       cout
);
    wire c1, c2, c3;

    full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(c1));
    full_adder fa1 (.a(a[1]), .b(b[1]), .cin(c1),  .sum(sum[1]), .cout(c2));
    full_adder fa2 (.a(a[2]), .b(b[2]), .cin(c2),  .sum(sum[2]), .cout(c3));
    full_adder fa3 (.a(a[3]), .b(b[3]), .cin(c3),  .sum(sum[3]), .cout(cout));
endmodule



module subtractor4 (
    input  [3:0] a,
    input  [3:0] b,
    output [3:0] diff,
    output       cout
);
    adder4 sub_add (
        .a(a),
        .b(~b),
        .cin(1'b1),
        .sum(diff),
        .cout(cout)
    );
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
    wire       sum_cout;
    wire       diff_cout;

    adder4      u_add (.a(a), .b(b), .cin(1'b0), .sum(sum_out), .cout(sum_cout));
    subtractor4 u_sub (.a(a), .b(b), .diff(diff_out), .cout(diff_cout));

    always @(*) begin
        case (select)
            2'b00:   result = sum_out;   
            2'b01:   result = diff_out; 
            2'b10:   result = a & b;
            2'b11:   result = a | b;
            default: result = 4'b0000;
        endcase
    end

endmodule
