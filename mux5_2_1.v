// Modulo para multiplexador 2 pra 1 com entradas de 5 bits
module mux5_2_1(ent1, ent2, sel, out);
    // entradas e saidas
    input wire [4:0] ent1;          // entrada 1
    input wire [4:0] ent2;          // entrada 2
    input wire sel;                 // entrada para seletor
    output wire [4:0] out;          // saida baseada no seletor

    // Se (sel == 1) {out = ent2} else {out = ent1}
    assign out = (sel == 1'd1) ? ent2 : ent1;
endmodule