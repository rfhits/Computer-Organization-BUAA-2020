`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:04:20 10/30/2020 
// Design Name: 
// Module Name:    alu 
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
`define	s0	0
`define	s1	1
`define	s2	2
`define	s3	3
`define	s4	4
`define	s5	5
`define	s6	6


module alu(
    input [3:0] a,
    input [3:0] b,
    output [1:0] out// 00 equal, 01 a big
    );
always@(*) begin
	if(a[3]==b[3]) begin
		if(a[2]==b[2]) begin
			if(a[1]==b[1]) begin
				if(a[0]==b[0]) begin
					out <=0;
				end
			end
			else begin
				if(a[1]==0) begin
					out <= 2'b10;
				end
				else begin
					out <= 2'b01;
				end
			end
		end
		else begin
			if(a[2]==0) begin
				out <= 2'b10;
			end
			else begin
				out <= 2'b01;
			end
		end
	end
	else
		if(a[3]==0) begin
			out <= 2'b01;
		end
		else begin
			out <= 2'b10;
		end
	end
end
endmodule
	