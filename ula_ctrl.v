/*
 * Grupo: João Miguel, Alícia Maria, Silas Silva, Hector
 * Disciplina: Arquitetura e Organização de Computadores - 2026.2
 * Atividade: Projeto 02 (2ª VA) - Implementação de MIPS em Verilog
 * Arquivo: ula_ctrl.v
 * Descrição: Unidade de controle de operações da ULA
 */

// Modulo para controle da ULA
module ula_ctrl(aluOp, func, op);
    // entradas e saidas
    input wire [3:0] aluOp;         // ALUOp vindo da unidade de controle
    input wire [5:0] func;          // 6 bits menos significativos da instrucao
    output reg [3:0] op;            // Operacao para ULA

    always @(*) begin
        case (aluOp)
            4'b0000: op = 4'b0000;  // lw, sw -> soma[cite: 5, 6]
            4'b0001: op = 4'b0001;  // beq, bne -> subtracao[cite: 5]
            4'b0011: op = 4'b0000;  // addi -> soma[cite: 5]
            4'b0100: op = 4'b0110;  // slti -> slt com sinal[cite: 5]
            4'b0101: op = 4'b0111;  // sltiu -> sltu sem sinal[cite: 5]
            4'b0110: op = 4'b0010;  // andi -> and[cite: 5]
            4'b0111: op = 4'b0011;  // ori -> or[cite: 5]
            4'b1000: op = 4'b0100;  // xori -> xor[cite: 5]
            4'b1001: op = 4'b1011;  // lui -> load upper immediate[cite: 5]

            4'b0010: begin          // Instrucoes Tipo-R (decodifica pelo func)[cite: 3, 4, 11]
                case (func)
                    6'b000000: op = 4'b1000; // sll
                    6'b000010: op = 4'b1001; // srl
                    6'b000011: op = 4'b1010; // sra[cite: 4]
                    6'b000100: op = 4'b1000; // sllv[cite: 4]
                    6'b000110: op = 4'b1001; // srlv[cite: 4]
                    6'b000111: op = 4'b1010; // srav[cite: 4]
                    6'b100000: op = 4'b0000; // add[cite: 3]
                    6'b100010: op = 4'b0001; // sub[cite: 3]
                    6'b100100: op = 4'b0010; // and[cite: 3]
                    6'b100101: op = 4'b0011; // or[cite: 3]
                    6'b100110: op = 4'b0100; // xor[cite: 3]
                    6'b100111: op = 4'b0101; // nor[cite: 3]
                    6'b101010: op = 4'b0110; // slt[cite: 3]
                    6'b101011: op = 4'b0111; // sltu[cite: 4]
                    default:   op = 4'b0000; // jr ou nao definida
                endcase
            end

            default: op = 4'b0000;  // Evita latches
        endcase
    end
endmodule