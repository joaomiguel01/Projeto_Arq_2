// Modulo para execução de operações na ULA
module ula(ent1, ent2, op, result, zero_flag);
    // entradas e saidas
    input wire [31:0] ent1;         // entrada para operando 1
    input wire [31:0] ent2;         // entrada para operando 2
    input wire [3:0] op;            // operador
    output reg [31:0] result;       // resultado da operacao
    output wire zero_flag;           // flag que indica result == 0

    // Bloco das operacoes
    always @(*) begin
        case (op)
            4'b0000: result = ent1 + ent2;                                                // Operacao de soma
            4'b0001: result = ent1 - ent2;                                                 // Operacao de subtracao
            4'b0010: result = ent1 & ent2;                                                 // AND logico bit a bit
            4'b0011: result = ent1 | ent2;                                                 // OR logico bit a bit
            4'b0100: result = ent1 ^ ent2;                                                 // XOR logico bit a bit
            4'b0101: result = ~(ent1 | ent2);                                              // NOR logico bit a bit
            4'b0110: result = ($signed(ent1) < $signed(ent2)) ? 32'd1 : 32'd0;             // Set Less Than com sinal
            4'b0111: result = (ent1 < ent2) ? 32'd1 : 32'd0;                               // Set Less Than sem sinal
            4'b1000: result = ent1 << ent2[4:0];                                           // deslocamento (sem sinal) a esquerda considerando shamt ou o registrador do banco
            4'b1001: result = ent1 >> ent2[4:0];                                           // deslocamento (sem sinal) a direita considerando shamt ou o registrador do banco
            4'b1010: result = $signed(ent1) >>> ent2[4:0];                                 // deslocamento (com sinal) a direita considerando shamt ou o registrador do banco
            4'b1011: result = {ent2[15:0], 16'b0};
            default: result = 32'd0;
        endcase
    end

    // atribuicao da flag em 1 caso result = 0
    assign zero_flag = (result == 32'd0) ? 1'd1 : 1'd0;
endmodule