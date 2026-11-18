/*
 * Grupo: João Miguel, Alícia Maria, Silas Silva, Hector
 * Disciplina: Arquitetura e Organização de Computadores - 2026.2
 * Atividade: Projeto 02 (2ª VA) - Implementação de MIPS em Verilog
 * Arquivo: ctrl.v
 * Descrição: Uniddade de controle do processador
 */

// Modulo de unidade de controle principal do processador MIPS
module ctrl(
    input  wire [5:0] opcode,    // OPCODE da instrucao (bits 31-26)
    output reg  [1:0] regDst,    // 00: $rt | 01: $rd | 10: $31 (jal)
    output reg        branch,    // 1 para beq
    output reg        bne,       // 1 para bne
    output reg        memRead,   // Habilita leitura na memoria de dados
    output reg  [1:0] memToReg,  // 00: ULA | 01: Memoria | 10: PC+4 (jal)
    output reg  [3:0] aluOp,     // Codigo de operacao para a ula_ctrl
    output reg        memWrite,  // Habilita escrita na memoria de dados
    output reg        aluSrc,    // 0: regfile ($rt) | 1: imediato estendido
    output reg        regWrite,  // Habilita escrita no banco de registradores
    output reg        jump,      // 1 para j e jal
    output reg        extOp      // 1: extensao de sinal | 0: extensao de zero
);

    always @(*) begin
        // Valores padrao (evita latches e facilita leitura)
        regDst   = 2'b00;
        branch   = 1'b0;
        bne      = 1'b0;
        memRead  = 1'b0;
        memToReg = 2'b00;
        aluOp    = 4'b0000;
        memWrite = 1'b0;
        aluSrc   = 1'b0;
        regWrite = 1'b0;
        jump     = 1'b0;
        extOp    = 1'b0;

        case (opcode)
            6'b000000: begin // Instrucoes Tipo-R
                regDst   = 2'b01;
                regWrite = 1'b1;
                aluOp    = 4'b0010;
            end

            6'b000010: begin // j (Jump)
                jump     = 1'b1;
            end

            6'b000011: begin // jal (Jump and Link)
                regDst   = 2'b10; // Seleciona registrador $31
                memToReg = 2'b10; // Seleciona PC + 4
                regWrite = 1'b1;
                jump     = 1'b1;
            end

            6'b000100: begin // beq
                branch   = 1'b1;
                aluOp    = 4'b0001; // Subtracao para comparar
                extOp    = 1'b1;
            end

            6'b000101: begin // bne
                bne      = 1'b1;
                aluOp    = 4'b0001; // Subtracao para comparar
                extOp    = 1'b1;
            end

            6'b001000: begin // addi
                aluSrc   = 1'b1;
                regWrite = 1'b1;
                extOp    = 1'b1;
                aluOp    = 4'b0011;
            end

            6'b001010: begin // slti
                aluSrc   = 1'b1;
                regWrite = 1'b1;
                extOp    = 1'b1;
                aluOp    = 4'b0100;
            end

            6'b001011: begin // sltiu
                aluSrc   = 1'b1;
                regWrite = 1'b1;
                extOp    = 1'b1;
                aluOp    = 4'b0101;
            end

            6'b001100: begin // andi (extensao de zero: extOp = 0)
                aluSrc   = 1'b1;
                regWrite = 1'b1;
                aluOp    = 4'b0110;
            end

            6'b001101: begin // ori (extensao de zero: extOp = 0)
                aluSrc   = 1'b1;
                regWrite = 1'b1;
                aluOp    = 4'b0111;
            end

            6'b001110: begin // xori (extensao de zero: extOp = 0)
                aluSrc   = 1'b1;
                regWrite = 1'b1;
                aluOp    = 4'b1000;
            end

            6'b001111: begin // lui
                aluSrc   = 1'b1;
                regWrite = 1'b1;
                aluOp    = 4'b1001;
            end

            6'b100011: begin // lw
                aluSrc   = 1'b1;
                memToReg = 2'b01;
                regWrite = 1'b1;
                memRead  = 1'b1;
                extOp    = 1'b1;
                aluOp    = 4'b0000; // Soma base + offset
            end

            6'b101011: begin // sw
                aluSrc   = 1'b1;
                memWrite = 1'b1;
                extOp    = 1'b1;
                aluOp    = 4'b0000; // Soma base + offset
            end

            default: begin
                // Mantem os valores zerados padrao
            end
        endcase
    end

endmodule