// Modulo para extender a entrada de 16 bits para 32 bits
module extensor(ent, out);
    // entradas e saidas
    input wire [15:0] ent;      // entrada
    output wire [31:0] out;     // saida extendida

    // extende sinal considerando números negativos e positivos
    assign out = (ent[15] == 1'd1) ? {{16{1'd1}}, ent} : {{16{1'd0}}, ent};
endmodule