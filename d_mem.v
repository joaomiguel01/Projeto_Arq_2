module d_mem #(
    parameter DEPTH = 256
)(
    input         Clock,
    input  [31:0] Address,
    input  [31:0] WriteData,
    input         MemWrite,
    input         MemRead,
    output [31:0] ReadData
);

    // Declaração do vetor de memória
    reg [31:0] ram [0:DEPTH-1];

    // Conversão de endereço em bytes para índice de palavra
    wire [31:0] word_addr = Address >> 2;

    // Escrita síncrona na borda de subida do clock
    always @(posedge Clock) begin
        if (MemWrite) begin
            ram[word_addr] <= WriteData;
        end
    end

    // Leitura assíncrona com controle da flag MemRead
    assign ReadData = (MemRead) ? ram[word_addr] : 32'h00000000;

endmodule