/*
 * Grupo: João Miguel, Alícia Maria, Silas Silva, Hector
 * Disciplina: Arquitetura e Organização de Computadores - 2026.2
 * Atividade: Projeto 02 (2ª VA) - Implementação de MIPS em Verilog
 * Arquivo: mux32_2_1.v
 * Descrição: Multiplexador com entradas de 32 bits
 */

// Modulo para multiplexador 2 pra 1 com entradas de 32 bits
module mux32_2_1(ent1, ent2, sel, out);
    // entradas e saidas
    input wire [31:0] ent1;          // entrada 1
    input wire [31:0] ent2;          // entrada 2
    input wire sel;                  // entrada para seletor
    output wire [31:0] out;          // saida baseada no seletor

    // Se (sel == 1) {out = ent2} else {out = ent1}
    assign out = (sel == 1'd1) ? ent2 : ent1;
endmodule