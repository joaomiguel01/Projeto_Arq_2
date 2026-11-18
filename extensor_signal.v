/*
 * Grupo: João Miguel, Alícia Maria, Silas Silva, Hector
 * Disciplina: Arquitetura e Organização de Computadores - 2026.2
 * Atividade: Projeto 02 (2ª VA) - Implementação de MIPS em Verilog
 * Arquivo: extensor_signal.v
 * Descrição: Extensor de sinal para extender dados de 16 para 32 bits
 */

// Modulo para extender a entrada de 16 bits para 32 bits
module extensor(ent, extOp, out);
    // entradas e saidas
    input wire [15:0] ent;      // entrada
    input wire extOp;           // entrada extra para operacoes immediate
    output wire [31:0] out;     // saida extendida

    // extende sinal considerando números negativos e positivos
    assign out = (extOp) ? {{16{ent[15]}}, ent} : {16'd0, ent};
endmodule