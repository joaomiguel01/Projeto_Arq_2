/*
 * Grupo: João Miguel, Alícia Maria, Silas Silva, Hector
 * Disciplina: Arquitetura e Organização de Computadores - 2026.2
 * Atividade: Projeto 02 (2ª VA) - Implementação de MIPS em Verilog
 * Arquivo: shift.v
 * Descrição: Modulo para fazer o deslocamento de bits para instrucões de beq ou jump
 */

// Modulo para fazer deslocamento a esquerda de 2 bits
module shift(ent, out);
    // entradas e saidas
    input wire [31:0] ent;      // entrada
    output wire [31:0] out;     // saida deslocada

    // logica para deslocamento de 2 bits (x4)
    assign out = ent << 2;
endmodule