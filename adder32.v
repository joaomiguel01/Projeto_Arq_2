// Modulo para somador para entradas de 32 bits
module adder32(ent1, ent2, out);
    // entradas e saidas
    input wire [31:0] ent1;         // entrada 1
    input wire [31:0] ent2;         // entrada 2
    output wire [31:0] out;         // saida com a soma das entradas

    assign out = ent1 + ent2;
endmodule