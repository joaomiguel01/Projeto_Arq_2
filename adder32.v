/*
 * Grupo: João Miguel, Alícia Maria, Silas Silva, Hector
 * Disciplina: Arquitetura e Organização de Computadores - 2026.2
 * Atividade: Projeto 02 (2ª VA) - Implementação de MIPS em Verilog
 * Arquivo: adder32.v
 * Descrição: Somador para as operações de beq e j do processador
 */

// Modulo para somador para entradas de 32 bits
module adder32(ent1, ent2, out);
    // entradas e saidas
    input wire [31:0] ent1;         // entrada 1
    input wire [31:0] ent2;         // entrada 2
    output wire [31:0] out;         // saida com a soma das entradas

    assign out = ent1 + ent2;
endmodule