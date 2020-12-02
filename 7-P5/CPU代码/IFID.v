`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:32:43 11/25/2020 
// Design Name: 
// Module Name:    IFID 
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
module IFID(

    input clk,
    input en,
    input reset,
	
	// PC above instr
    input [31:0] PCF,
    input [31:0] InstrF,
	
	// 1. Decode use it
	// 2. the Fwd in hzd use it
    output reg [31:0] PCD,
    output reg [31:0] InstrD
    );
	
	initial begin
		InstrD = 0;
	end
	always@(posedge clk) begin
		if (reset) begin
			PCD = 0;
			InstrD = 0;
		end
		else if (en) begin
			PCD <= PCF;
			InstrD <= InstrF;
		end
	end
endmodule
