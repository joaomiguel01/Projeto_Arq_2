/*
 * Grupo: João Miguel, Alícia Maria, Silas Silva, Hector
 * Disciplina: Arquitetura e Organização de Computadores - 2026.2
 * Atividade: Projeto 02 (2ª VA) - Implementação de MIPS em Verilog
 * Arquivo: register_pc.v
 * Descrição: Registrador PC que aponta para a instrucao
 */
 
// Modulo para o registrador PC e armazenar o endereço da proxima instrucao
module PC(clk, nextPc, pc);
    // Entradas e saidas
    input wire clk;                 // Clock
    input wire [31:0] nextPc;       // Endereco da respectiva instrução
    output reg [31:0] pc;           // Saida para o modulo i_mem

    // Valor padrao da saida no comeco do processamento
    initial begin
        pc = 32'd0;
    end

    always @(posedge clk) begin
        pc <= nextPc;    // Carrega o endereco da instrucao para ser utilizado no i_mem
    end
endmodule