/*
 * Grupo: João Miguel, Alícia Maria, Silas Silva, Hector
 * Disciplina: Arquitetura e Organização de Computadores - 2026.2
 * Atividade: Projeto 02 (2ª VA) - Implementação de MIPS em Verilog
 * Arquivo: testbench.v
 * Descrição: Arquivo de testbench para realizar os testes das intruções no instruction.list
 */

`timescale 1ns/1ps

module testbench;

    // Sinais de estimulo (entradas do top-level)
    reg clk;
    reg rst;

    // Sinais de monitoramento (saidas do top-level)
    wire [31:0] pc_out;
    wire [31:0] ula_out;
    wire [31:0] dmem_out;

    // Instanciacao do nucleo MIPS (Device Under Test - DUT)
    mips DUT (
        .clk(clk),
        .rst(rst),
        .pc_out(pc_out),
        .ula_out(ula_out),
        .dmem_out(dmem_out)
    );

    // Geracao de clock com periodo de 10ns (5ns nivel alto, 5ns nivel baixo)
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Controle da simulacao e monitoramento no terminal
    initial begin
        // Gera arquivo de formas de onda para visualizacao (GTKWave / EDA Playground)
        $dumpfile("ondas.vcd");
        $dumpvars(0, testbench);

        $display("=========================================================================");
        $display(" Tempo |    PC    |  Instrucao (Hex) |  Saida ULA (Hex) | Saida DMEM (Hex)");
        $display("=========================================================================");

        // Aplica reset inicial no banco de registradores antes da primeira borda de subida
        rst = 1'b1;
        #3;
        rst = 1'b0;

        // Monitora cada ciclo logo antes da borda de subida do clock (quando os sinais combinacionais ja estabilizaram)
        repeat (33) begin
            @(negedge clk);
            $display(" %4t  | %h |     %h     |     %h     |     %h",
                     $time, pc_out, DUT.instr, ula_out, dmem_out);
        end

        $display("=========================================================================");
        $display("Verificacao final de registradores chave:");
        $display("$t0 (R8)  = %h (Esperado: 00000000 - sltiu)", DUT.REGFILE_inst.registers[8]);
        $display("$t2 (R10) = %h (Esperado: 00000005 - add)",   DUT.REGFILE_inst.registers[10]);
        $display("$t3 (R11) = %h (Esperado: 0000000f - sub)",   DUT.REGFILE_inst.registers[11]);
        $display("$s0 (R16) = %h (Esperado: 00000001 - slt)",   DUT.REGFILE_inst.registers[16]);
        $display("$s2 (R18) = %h (Esperado: 00000028 - sll)",   DUT.REGFILE_inst.registers[18]);
        $display("$s3 (R19) = %h (Esperado: fffffffd - sra)",   DUT.REGFILE_inst.registers[19]);
        $display("$t9 (R25) = %h (Esperado: 12340000 - lui)",   DUT.REGFILE_inst.registers[25]);
        $display("$k0 (R26) = %h (Esperado: 00000005 - lw)",    DUT.REGFILE_inst.registers[26]);
        $display("$ra (R31) = %h (Esperado: 00000078 - jal)",   DUT.REGFILE_inst.registers[31]);
        $display("=========================================================================");

        $finish;
    end

endmodule