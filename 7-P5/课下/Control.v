`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:37:25 11/18/2020 
// Design Name: 
// Module Name:    control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "macros.v"
module Control(
    input [31:0] instr,
	input eq,
	input eqz,
	input ltz,
	// Decode-Stage
    output sign,
	
	output branch,
    output JType,
    output JReg,
	
	output WDSelD,	// jump and link will generate the WriteData
	output [4:0] A3DE,		// GRF WriteDst
	
	
	// Execute-Stage
    output [3:0] ALUOp,
	output ALUASel,
	output ALUBSel,
	output [1:0] WDSelE,
	
	// Memory-Stage
	output WEMem,
	output width,
	output LoadSign,
	output WDSelM
    );
	
	wire [5:0] op, funct, rt;
	assign op = instr[`op];
	assign funct = instr[`funct];
	assign rt = instr[`rt];
	
	wire addu,subu,ori,lw,sw,beq,lui,jal,nop;
	
	assign addu = (op == `R)&(funct == `ADDU);
	assign subu = (op == `R)&(funct == `SUBU);
	assign ori = (op == `ORI);
	assign lw = (op == `LW);
	assign sw = (op == `SW);
	assign beq = (op == `BEQ);
	assign lui = (op == `LUI);
	
	// Jump
	assign j = (op == `J);
	assign jal = (op == `JAL);
	
	assign jr = (op == `R)&(funct == `JR);
	assign jalr = (op == `R)&(funct == `JALR);
	
	assign	nop= (op == `R)&(funct == 0),
			lb = (op == `LB),
			lbu = (op == `LBU),
			lh = (op == `LH),
			lhu = (op == `LHU),
			sb = (op == `SB),
			sh = (op == `SH),
			add = (op == `R) && (funct == `ADD),
			sub = (op == `R) && (funct == `SUB),
			mult = (op == `R) && (funct == `MULT),
			multu = (op == `R) && (funct == `MULTU),
			div = (op == `R) && (funct == `DIV),
			divu = (op == `R) && (funct == `DIVU),
			sll = (op == `R) && (funct == `SLL),
			srl = (op == `R) && (funct == `SRL),
			sra = (op == `R) && (funct == `SRA),
			sllv = (op == `R) && (funct == `SLLV),
			srlv = (op == `R) && (funct == `SRLV),
			srav = (op == `R) && (funct == `SRAV),
			andw = (op == `R) && (funct == `AND),	// "and" is key word
			orw = (op == `R) && (funct == `OR),		// "or" is key word
			xorw = (op == `R) && (funct == `XOR),
			norw = (op == `R) && (funct == `NOR),
			addi = (op == `ADDI),
			addiu = (op == `ADDIU),
			andi = (op == `ANDI),
			xori = (op == `XORI),
			slt = (op == `R) && (funct == `SLT),
			slti = (op == `SLTI),
			sltiu = (op == `SLTIU),
			sltu = (op == `R) && (funct == `SLTU),
			bne = (op == `BNE),
			blez = (op == `BLEZ),
			bgtz = (op == `BGTZ),
			bltz = (op == `BLTZ) && (rt == 0),
			bgez = (op == `BGEZ) && (rt == 5'b00001),
			mfhi = (op == `R) && (funct == `MFHI),
			mflo = (op == `R) && (funct == `MFLO),
			mthi = (op == `R) && (funct == `MTHI),
			mtlo = (op == `R) && (funct == `MTLO);
			
	

///////////// Decode /////////////////////////

	// sign
	assign sign = lw|sw|beq;
	
	// branch
	assign branch =  beq & eq;
	// JType
	assign JType = j|jal;
	// JReg
	assign JReg = jr | jalr;
	
	// WDSelD
	assign WDSelD = jal | jalr;
	
	// A3DE
	assign A3DE =	(jal)? 5'd31:
					(lui | ori| lw )? instr[`rt]:		// I-Type
					(addu | subu | jalr)? instr[`rd]:
					0;
////////// Decode End /////////////

//////////// Execute begin ///////////

	// ALUOp
	assign ALUOp =	(subu | sub)?	4'b0001 :
					(andi | andw)?	4'b0010 :
					(ori | orw)?	4'b0011 :
					(lui)?			4'b0100 :
					0;
	// ALUSel
	assign ALUASel = sll || srl || sra;
	assign ALUBSel = ori || lw || sw || lui;
	assign WDSelE = mflo ? 2'b11 :
					mfhi ? 2'b10 :
					(lw || sw || addu || subu || ori || lui || add || sub || sll || srl || sra || sllv || srlv || srav || andw || orw || xorw || norw || addi || addiu || andi || xori || slt || slti || sltiu || sltu) ? 2'b01 :	// use alu data
					  2'b00;	// use jump data
////////////// Execute End ////////////

//////////// Memory Begin /////////////
	assign WEMem = sw || sh || sb;
	assign width =	(sb || lb || lbu) ? 2'b10 :
					(sh || lh || lhu) ? 2'b01 :
					2'b00;	// 32-bits word default
	assign LoadSign = lb || lh;		// lb and lh default LoadSign
	
	assign WDSelM = lw || lb || lbu || lh || lhu;	// once load, use the DM data
//////////// Memory End //////////////

endmodule
