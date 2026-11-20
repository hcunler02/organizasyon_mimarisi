// 32-bit IEEE 754 bit cozumleyici ve ozel durum tespit devresi
module ieee754_decoder (
    input  logic [31:0] data_in,

    // Ayristirilmis alanlar
    output logic        sign,
    output logic [7:0]  exponent,
    output logic [22:0] mantissa,

    // Ozel durum bayraklari
    output logic        is_zero,
    output logic        is_subnormal,
    output logic        is_normal,
    output logic        is_inf,
    output logic        is_nan
);

    // Alanlarin ayrilmasi
    assign sign     = data_in[31];
    assign exponent = data_in[30:23];
    assign mantissa = data_in[22:0];

    // Yardimci kosullar
    logic exp_all_zero;   // us  = 8'h00
    logic exp_all_one;    // us  = 8'hFF
    logic mant_zero;      // kesir = 23'd0

    assign exp_all_zero = (exponent == 8'h00);
    assign exp_all_one  = (exponent == 8'hFF);
    assign mant_zero    = (mantissa == 23'd0);

    // Siniflandirma
    assign is_zero      =  exp_all_zero &  mant_zero;
    assign is_subnormal =  exp_all_zero & ~mant_zero;
    assign is_normal    = ~exp_all_zero & ~exp_all_one;   // 8'h01 .. 8'hFE
    assign is_inf       =  exp_all_one  &  mant_zero;
    assign is_nan       =  exp_all_one  & ~mant_zero;     // isaret onemsiz

endmodule
