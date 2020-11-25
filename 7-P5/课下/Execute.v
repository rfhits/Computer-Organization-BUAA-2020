`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:42:53 11/25/2020 
// Design Name: 
// Module Name:    Execute 
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
module Execute(
    input clk,
    input reset,
	
    input [31:0] InstrE,
    input [31:0] imm32E,
	
    input [31:0] WDE,
    input [31:0] FwdE1,
    input [31:0] FwdE2,
	
    output [31:0] WDEM,
    output [31:0] RD2EM
    );
	wire ALUOp;
	wire ALUASel, ALUBSel;
	wire[31:0] ALUA, ALUB, res;
	wire [1:0] WDSelE;
	
	Control CtrlE (
    .instr(InstrE), 
    .ALUop(ALUOp), 
    .ALUASel(ALUASel), 
    .ALUBSel(ALUBSel), 
    .WDSelE(WDSelE)
    );
	
	assign ALUA = (ALUASel == 0)? FwdE1 : {27'b0, InstrE[10:6]};
	assign ALUB = (ALUBSel == 0)? FwdE2 : imm32E;
	
	ALU alu (
    .A(ALUA), 
    .B(ALUB), 
    .ALUOp(ALUOp), 
    .res(res)
    );
	assign WDEM =	(WDSelE == 2'b00)? WDE :
					(WDSelE == 2'b01)? res :
					0;// waiting for P6 to add the HI and LO
					
	assign RD2EM = FwdE2;
endmodule
