module tb_mux4to1;

  logic [7:0] a, b, c, d;
  logic [1:0] sel;
  logic [7:0] y;


  mux4to1 dut (
    .a(a), .b(b), .c(c), .d(d),
    .sel(sel),
    .y(y)
  );

  initial begin
    a = 8'h11;
    b = 8'h22;
    c = 8'h33;
    d = 8'h44;
