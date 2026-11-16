// Modulo para o registrador PC e armazenar o endereço da proxima instrucao
module register_pc(clk, nextPc, pc);
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