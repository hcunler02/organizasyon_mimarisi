module tb_adder4;

  logic [3:0] a, b;
  logic       cin;
  logic [3:0] sum;
  logic       cout;

  adder4 dut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

  initial begin
    a = 4'd3;  b = 4'd5;  cin = 0; #10;
    $display("%d + %d + %b = %d, cout=%b (beklenen 8, 0)", a, b, cin, sum, cout);

    a = 4'd9;  b = 4'd6;  cin = 0; #10;
    $display("%d + %d + %b = %d, cout=%b (beklenen 15, 0)", a, b, cin, sum, cout);

    a = 4'd9;  b = 4'd7;  cin = 0; #10;
    $display("%d + %d + %b = %d, cout=%b (beklenen 0, 1)", a, b, cin, sum, cout);

    a = 4'd15; b = 4'd15; cin = 1; #10;
    $display("%d + %d + %b = %d, cout=%b (beklenen 15, 1)", a, b, cin, sum, cout);

    $finish;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_adder4);
  end

endmodule
