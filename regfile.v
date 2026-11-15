`timescale 1ns/1ps

// Modulo regfile
module regfile(clk, rst, regWrite, readAddr1, readAddr2, writeAddr, writeData, readData1, readData2);
  // entradas e saidas
  input wire clk, rst, regWrite;	// Clock, Reset e RegWrite
  input wire [4:0] readAddr1;
  input wire [4:0] readAddr2;
  input wire [4:0] writeAddr;
  input wire [31:0] writeData;
  output wire [31:0] readData1;
  output wire [31:0] readData2;
  
  // banco de registradores
  reg [31:0] registers [31:0];
  
  // Valores padrões nos registradores
  initial begin
    registers[0] <= 32'd0;
    registers[1] <= 32'd0;
    registers[2] <= 32'd0;
    registers[3] <= 32'd0;
    registers[4] <= 32'd0;
    registers[5] <= 32'd0;
    registers[6] <= 32'd0;
    registers[7] <= 32'd0;
    registers[8] <= 32'd0;
    registers[9] <= 32'd0;
    registers[10] <= 32'd0;
    registers[11] <= 32'd0;
    registers[12] <= 32'd0;
    registers[13] <= 32'd0;
    registers[14] <= 32'd0;
    registers[15] <= 32'd0;
    registers[16] <= 32'd0;
    registers[17] <= 32'd0;
    registers[18] <= 32'd0;
    registers[19] <= 32'd0;
    registers[20] <= 32'd0;
    registers[21] <= 32'd0;
    registers[22] <= 32'd0;
    registers[23] <= 32'd0;
    registers[24] <= 32'd0;
    registers[25] <= 32'd0;
    registers[26] <= 32'd0;
    registers[27] <= 32'd0;
    registers[28] <= 32'd0;
    registers[29] <= 32'd0;
    registers[30] <= 32'd0;
    registers[31] <= 32'd0;
  end
  
  always @(posedge clk or posedge rst) begin
    if (rst == 1'd1) begin
      // Se o Reset == 1, reseta todos os registradores
      registers[0] <= 32'd0;
      registers[1] <= 32'd0;
      registers[2] <= 32'd0;
      registers[3] <= 32'd0;
      registers[4] <= 32'd0;
      registers[5] <= 32'd0;
      registers[6] <= 32'd0;
      registers[7] <= 32'd0;
      registers[8] <= 32'd0;
      registers[9] <= 32'd0;
      registers[10] <= 32'd0;
      registers[11] <= 32'd0;
      registers[12] <= 32'd0;
      registers[13] <= 32'd0;
      registers[14] <= 32'd0;
      registers[15] <= 32'd0;
      registers[16] <= 32'd0;
      registers[17] <= 32'd0;
      registers[18] <= 32'd0;
      registers[19] <= 32'd0;
      registers[20] <= 32'd0;
      registers[21] <= 32'd0;
      registers[22] <= 32'd0;
      registers[23] <= 32'd0;
      registers[24] <= 32'd0;
      registers[25] <= 32'd0;
      registers[26] <= 32'd0;
      registers[27] <= 32'd0;
      registers[28] <= 32'd0;
      registers[29] <= 32'd0;
      registers[30] <= 32'd0;
      registers[31] <= 32'd0;
    end
    else if (regWrite == 1'd1 && writeAddr != 5'd0) begin
      // Opção de escrita caso regWrite == 1, Reset == 0 e writeAddr != 0 (nao escreve no registrador 0)
      registers[writeAddr] <= writeData;
    end
  end
  
  // Associao assincrona as saidas
  assign readData1 = (readAddr1 != 5'd0) ? registers[readAddr1] : (32'h00000000);
  assign readData2 = (readAddr2 != 5'd0) ? registers[readAddr2] : (32'h00000000);
  
endmodule