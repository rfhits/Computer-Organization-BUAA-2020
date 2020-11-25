`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:24:23 11/25/2020 
// Design Name: 
// Module Name:    Forward 
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
module Forward(
	// Decode
	// ID/EX knows which Decode to use
    input [4:0] A1D,
    input [4:0] A2D,
	
	// Decode store the val itself
    input [31:0] RD1D,
    input [31:0] RD2D,
	
	// ID/EX stored counted vals
    input [4:0] A3E,	// to detect confict
    input [31:0] WDE,
	
	// ID/EX know which Execute to use
    input [4:0] A1E,
    input [4:0] A2E,
    input [31:0] RD1E,
    input [31:0] RD1E,
	
	// EX/MEM stored the counted vals
    input [4:0] A3M,	// to detect confict
    input [31:0] WDM,
	
	// EX/MEM knows which Memory to use
    input [4:0] A2M,
    input [31:0] RD2M,
	
	// MEM/WB stored the counted vals
    input [4:0] A3W,
    input [31:0] WDW,
	
    output [31:0] FwdD1,
    output [31:0] FwdD2,
    output [31:0] FwdE1,
    output [31:0] FwdE2,
    output [31:0] FwdM2
    );
	
	// 'Cause the internal Fwd in GRF, so there are only two fwd
	assign FwdD1 =	(A1D == A3E && A3E != 0)? WDE :
					(A1D == A3M && A3M != 0)? WDM :
					RD1D;
	assign FwdD2 =	(A2D == A3E && A3E != 0)? WDE :
					(A2D == A3M && A3M != 0)? WDM :
					RD2D;
					
	// ALU use the fwd, fwd back from EX/MEM and MEM/WB
	assign FwdE1 =	(A1E == A3M && A3M != 0)? WDM :
					(A1E == A3W && A3W != 0)? WDW :
					RD1E;
	assign FwdE2 =	(A2E == A3M && A3M != 0)? WDM :
					(A2E == A3W && A3W != 0)? WDW :
					RD2E;
					
	assign FwdM2 =	(A2M == A3W && A3W != 0)? WDW :
					RD2M;
endmodule
