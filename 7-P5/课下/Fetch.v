`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:25:01 11/25/2020 
// Design Name: 
// Module Name:    Fetch 
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
module Fetch(
    input clk,
    input reset,
    input EnPC,
    input [31:0] NPC,
	
	
    output [31:0] InstrFD,
    output [31:0] PCFD
    );
	
	wire PC;
	
	PC pc (
    .clk(clk), 
    .reset(reset), 
    .en(EnPC), 
    .NPC(NPC), 
    .PC(PC)
    );
	
	IM im(
    .PC(PC), 
    .instr(instr)
    );
	
	assign PCFD = PC;
	assign InstrFD = instr;



endmodule
