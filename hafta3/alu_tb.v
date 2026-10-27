module alu_tb;

    reg  [3:0] a, b;
    reg  [1:0] select;
    wire [3:0] result;

    alu uut (
        .a(a),
        .b(b),
        .select(select),
        .result(result)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, alu_tb);

        $monitor("t=%0t | a=%b (%0d) b=%b (%0d) sel=%b | result=%b (%0d)",
                 $time, a, a, b, b, select, result, result);

     
        a = 4'd5;  b = 4'd3;  select = 2'b00; #10;
        a = 4'd9;  b = 4'd8;  select = 2'b00; #10;
        a = 4'd15; b = 4'd1;  select = 2'b00; #10;  

       
        a = 4'd9;  b = 4'd4;  select = 2'b01; #10;
        a = 4'd3;  b = 4'd5;  select = 2'b01; #10;
        a = 4'd7;  b = 4'd7;  select = 2'b01; #10;   

   
        a = 4'b1100; b = 4'b1010; select = 2'b10; #10;

    
        a = 4'b1100; b = 4'b1010; select = 2'b11; #10;

        $finish;
    end

endmodule
