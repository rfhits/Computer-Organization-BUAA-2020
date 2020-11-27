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
module control(
    input eq,
    input [31:0] instr,
    output WeGrf,
    output WeDm,
    output [1:0] RegDst,
    output [1:0] WhichtoReg,
    output AluSrc,
    output [2:0] AluOp,
    output sign,
	output branch,
    output JType,
    output jr
    );
	
	wire [5:0] op, func;
	assign op = instr[31:26];
	assign func = instr[5:0];
	wire addu,subu,ori,lw,sw,beq,lui,jal,nop;
	
	

	assign addu = (op == 6'b000000)&(func == 6'b100001);
	assign subu = (op == 6'b000000)&(func == 6'b100011);
	assign ori = (op == 6'b001101);
	assign lw = (op == 6'b100011);
	assign sw = (op == 6'b101011);
	assign beq = (op == 6'b000100);
	assign lui = (op == 6'b001111);
	assign jal = (op == 6'b000011);
	assign j = (op == 6'h000010);
	assign jr = (op == 6'b000000)&(func == 6'b001000);
	assign nop= (op==6'b000000)&(func==6'b000000);
	
	// WE
	assign WeGrf = addu|subu|ori|lw|lui|jal;
	assign WeDm = sw;
	
	// RegDst
	// RegWriteAddr == rd? rt? 31?
	// assign RegDst[0] = ori|lw|lui;
	// assign RegDst[1] = jal;
	
	assign RegDst = (ori|lw|lui) ? 2'b01 :
					(jal) ? 2'b10 :
					2'b00;
	
	// WhichtoReg
	// choose from PC4 / MemRead / res
	// assign WhichtoReg[0] = lw;
	// assign WhichtoReg[1] = jal;
	
	assign WhichtoReg =	lw	? 2'b01 :
						jal	? 2'b10 :
						2'b00;
	
	// AluSrc
	assign AluSrc = ori|lw|sw|lui;
	
	// AluOp
	
	// assign AluOp[0] = subu|ori;
	// assign AluOp[1] = ori;
	// assign AluOp[2] = lui;
	
	assign AluOp =	addu ?	3'b000 :
					subu ?	3'b001 :
					// and is 010, "and" is a key word
					ori ?	3'b011 :
					lui ?	3'b100 :
					0;
	
	// sign
	assign sign = lw|sw|beq;
	
	// branch
	assign branch = beq&eq;
	
	
	// JType
	assign JType = j|jal;
	
	// jr already assign
	// assign jr = jr;


endmodule
