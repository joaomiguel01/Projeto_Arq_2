// Modulo para fazer deslocamento a esquerda de 2 bits
module shift(ent, out);
    // entradas e saidas
    input wire [31:0] ent;      // entrada
    output wire [31:0] out;     // saida deslocada

    // logica para deslocamento de 2 bits (x4)
    assign out = ent << 2;
endmodule