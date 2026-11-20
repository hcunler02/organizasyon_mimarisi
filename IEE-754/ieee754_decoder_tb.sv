`timescale 1ns/1ps

module ieee754_decoder_tb;

    logic [31:0] data_in;
    logic        sign;
    logic [7:0]  exponent;
    logic [22:0] mantissa;
    logic        is_zero, is_subnormal, is_normal, is_inf, is_nan;

    // DUT baglantisi
    ieee754_decoder dut (
        .data_in      (data_in),
        .sign         (sign),
        .exponent     (exponent),
        .mantissa     (mantissa),
        .is_zero      (is_zero),
        .is_subnormal (is_subnormal),
        .is_normal    (is_normal),
        .is_inf       (is_inf),
        .is_nan       (is_nan)
    );

    // Test vektorleri ve beklenen {zero, subn, norm, inf, nan}
    logic [31:0] vec      [0:7];
    logic [4:0]  expected [0:7];

    logic [4:0]  flags;
    integer      i, errors, ones;

    initial begin
        vec[0] = 32'h00000000;  expected[0] = 5'b10000;  // +0
        vec[1] = 32'h80000000;  expected[1] = 5'b10000;  // -0
        vec[2] = 32'h427d0000;  expected[2] = 5'b00100;  // normal
        vec[3] = 32'hbfc00000;  expected[3] = 5'b00100;  // normal
        vec[4] = 32'h00000001;  expected[4] = 5'b01000;  // subnormal
        vec[5] = 32'h7f800000;  expected[5] = 5'b00010;  // +Inf
        vec[6] = 32'hff800000;  expected[6] = 5'b00010;  // -Inf
        vec[7] = 32'h7fc00001;  expected[7] = 5'b00001;  // NaN

        errors = 0;

        $display("Hex Giris  | S | Exp | Zero | SubN | Norm | Inf | NaN | Sonuc");
        $display("-----------------------------------------------------------------");

        for (i = 0; i < 8; i = i + 1) begin
            data_in = vec[i];
            #10;
            flags = {is_zero, is_subnormal, is_normal, is_inf, is_nan};

            $display("0x%08h | %0d | %3d |  %0d   |  %0d   |  %0d   |  %0d  |  %0d  | %s",
                     data_in, sign, exponent,
                     is_zero, is_subnormal, is_normal, is_inf, is_nan,
                     (flags === expected[i]) ? "PASS" : "FAIL");

            if (flags !== expected[i]) errors = errors + 1;
        end

        // Ek kontrol: rastgele girislerde tam olarak bir bayrak 1 olmali
        for (i = 0; i < 10000; i = i + 1) begin
            data_in = $urandom;
            #1;
            ones = is_zero + is_subnormal + is_normal + is_inf + is_nan;
            if (ones != 1) begin
                $display("HATA: one-hot degil -> 0x%08h", data_in);
                errors = errors + 1;
            end
        end

        if (errors == 0) $display("\nTum testler basarili.");
        else             $display("\n%0d hata bulundu!", errors);

        $finish;
    end

endmodule
