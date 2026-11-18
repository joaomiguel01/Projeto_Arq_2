/*
 * Grupo: João Miguel, Alícia Maria, Silas Silva, Hector
 * Disciplina: Arquitetura e Organização de Computadores - 2026.2
 * Atividade: Projeto 02 (2ª VA) - Implementação de MIPS em Verilog
 * Arquivo: i_mem.v
 * Descrição: Memória para a instrução apontada pelo PC
 */

module i_mem #(
    parameter DEPTH = 256,
    parameter INIT_FILE = "instruction.list"
)(
    input  [31:0] address,
    output [31:0] i_out
);

    // Declaração do vetor de memória
    reg [31:0] rom [0:DEPTH-1];

    // Inicialização da memória a partir do arquivo
    initial begin
        $readmemb(INIT_FILE, rom);
    end

    // Leitura assíncrona baseada no índice da palavra
    assign i_out = rom[address[31:2]];

endmodule