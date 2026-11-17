// Modulo de unidade de controle do processador
module ctrl(opcode, regDst, branch, memRead, memToReg, aluOp, memWrite, aluSrc, regWrite);
    // entradas e saidas
    input wire [5:0] opcode;                    // OPCODE da instrucao
    output reg regDst, branch, memRead;        // Saidas de controle
    output reg memToReg, aluOp, memWrite;      // Saidas de controle
    output reg aluSrc, regWrite;               // Saidas de controle

endmodule