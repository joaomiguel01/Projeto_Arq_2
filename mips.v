/*
 * Grupo: João Miguel, Alícia Maria, Silas Silva, Hector
 * Disciplina: Arquitetura e Organização de Computadores - 2026.2
 * Atividade: Projeto 02 (2ª VA) - Implementação de MIPS em Verilog
 * Arquivo: mips.v
 * Descrição: Arquivo top-level que integra todos os outros módulos
 */

// Modulo top-level do processador MIPS
module mips (
    input  wire        clk,       // Clock do sistema
    input  wire        rst,       // Reset para o banco de registradores
    output wire [31:0] pc_out,    // Valor atual do PC
    output wire [31:0] ula_out,   // Valor atual da saida da ULA
    output wire [31:0] dmem_out   // Valor atual da saida da memoria de dados
);

    // Fios internos do caminho de dados
    wire [31:0] pc_current, pc_next, pc_plus_4, pc_branch, pc_jump;
    wire [31:0] instr;
    wire [31:0] reg_data1, reg_data2, reg_write_data;
    wire [4:0]  reg_write_addr;
    wire [31:0] imm_ext, imm_shifted;
    wire [31:0] ula_in1, ula_in2, ula_result;
    wire [31:0] dmem_read_data;
    wire        zero_flag;

    // Sinais de controle
    wire [1:0] regDst, memToReg;
    wire       branch, bne, memRead, memWrite, aluSrc, regWrite, jump, extOp;
    wire [3:0] aluOp, ula_op;

    // Sinais auxiliares para instrucoes de deslocamento e jr (Tipo R)
    wire is_r_type  = (instr[31:26] == 6'b000000);
    wire is_jr      = is_r_type && (instr[5:0] == 6'b001000);
    wire is_shift_i = is_r_type && (instr[5:0] == 6'b000000 || // sll
                                    instr[5:0] == 6'b000010 || // srl
                                    instr[5:0] == 6'b000011);  // sra
    wire is_shift_v = is_r_type && (instr[5:0] == 6'b000100 || // sllv
                                    instr[5:0] == 6'b000110 || // srlv
                                    instr[5:0] == 6'b000111);  // srav
    wire is_shift   = is_shift_i || is_shift_v;

    // 1. Registrador PC e somador de PC + 4
    PC PC_inst (
        .clk(clk),
        .nextPc(pc_next),
        .pc(pc_current)
    );

    adder32 adder_pc4 (
        .ent1(pc_current),
        .ent2(32'd4),
        .out(pc_plus_4)
    );

    // 2. Memoria de Instrucoes (ROM)
    i_mem IMEM_inst (
        .address(pc_current),
        .i_out(instr)
    );

    // 3. Unidade de Controle Principal
    ctrl CTRL_inst (
        .opcode(instr[31:26]),
        .regDst(regDst),
        .branch(branch),
        .bne(bne),
        .memRead(memRead),
        .memToReg(memToReg),
        .aluOp(aluOp),
        .memWrite(memWrite),
        .aluSrc(aluSrc),
        .regWrite(regWrite),
        .jump(jump),
        .extOp(extOp)
    );

    // 4. Banco de Registradores (regfile)
    // MUX 3x1 para WriteAddr: 00 -> $rt | 01 -> $rd | 10 -> $31 (jal)
    assign reg_write_addr = (regDst == 2'b00) ? instr[20:16] :
                            (regDst == 2'b01) ? instr[15:11] : 5'd31;

    // MUX 3x1 para WriteData: 00 -> ULA | 01 -> d_mem | 10 -> PC+4 (jal)
    assign reg_write_data = (memToReg == 2'b00) ? ula_result :
                            (memToReg == 2'b01) ? dmem_read_data : pc_plus_4;

    regfile REGFILE_inst (
        .clk(clk),
        .rst(rst),
        .regWrite(regWrite && !is_jr), // Bloqueia escrita durante jr
        .readAddr1(instr[25:21]),      // $rs
        .readAddr2(instr[20:16]),      // $rt
        .writeAddr(reg_write_addr),
        .writeData(reg_write_data),
        .readData1(reg_data1),
        .readData2(reg_data2)
    );

    // 5. Extensor de Imediato, Shift Left 2 e Somador de Branch
    extensor EXT_inst (
        .ent(instr[15:0]),
        .extOp(extOp),
        .out(imm_ext)
    );

    shift SHIFT_inst (
        .ent(imm_ext),
        .out(imm_shifted)
    );

    adder32 adder_branch (
        .ent1(pc_plus_4),
        .ent2(imm_shifted),
        .out(pc_branch)
    );

    // 6. Controle da ULA e ULA
    ula_ctrl ULA_CTRL_inst (
        .aluOp(aluOp),
        .func(instr[5:0]),
        .op(ula_op)
    );

    // Selecao das entradas da ULA (considerando shifts e imediatos)
    assign ula_in1 = (is_shift) ? reg_data2 : reg_data1;

    assign ula_in2 = (is_shift_i) ? {27'd0, instr[10:6]} : // shamt
                     (is_shift_v) ? reg_data1 :            // $rs
                     (aluSrc)     ? imm_ext : reg_data2;   // imediato ou $rt

    ula ULA_inst (
        .ent1(ula_in1),
        .ent2(ula_in2),
        .op(ula_op),
        .result(ula_result),
        .zero_flag(zero_flag)
    );

    // 7. Memoria de Dados (RAM)
    d_mem DMEM_inst (
        .Clock(clk),
        .Address(ula_result),
        .WriteData(reg_data2),
        .MemWrite(memWrite),
        .MemRead(memRead),
        .ReadData(dmem_read_data)
    );

    // 8. Logica de selecao do proximo PC (PC+4, Branch, Jump, JR)
    wire take_branch = (branch && zero_flag) || (bne && !zero_flag);
    wire [31:0] pc_after_branch = (take_branch) ? pc_branch : pc_plus_4;
    assign pc_jump = {pc_plus_4[31:28], instr[25:0], 2'b00};

    assign pc_next = (is_jr) ? reg_data1 :
                     (jump)  ? pc_jump : pc_after_branch;

    // Saidas de monitoramento do top-level
    assign pc_out   = pc_current;
    assign ula_out  = ula_result;
    assign dmem_out = dmem_read_data;

endmodule