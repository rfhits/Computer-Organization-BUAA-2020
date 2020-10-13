`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:51:13 09/30/2020 
// Design Name: 
// Module Name:    cpu_checker 
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
`define S0  5'b0000
`define S1  5'b0001
`define S2  5'b0010
`define S3  5'b0011
`define S4  5'b0100
`define S5  5'b0101
`define S6  5'b0110
`define S7  5'b0111
`define S8  5'b1000
`define S9  5'b1001
`define S10 5'b1010
`define S11 5'b1011
`define S12 5'b1100
`define S13 5'b1101
`define S14 5'b1110

module cpu_checker(
    input clk,
    input reset,
    input [7:0] char,
    output [2:0] format_type
    );
reg[5:0] status;
reg[2:0] ct_tm;//1~4��ʮ������
reg[3:0] ct_pc;//8 hex
reg[2:0] ct_grf;//1~4��ʮ������
reg[3:0] ct_addr;//8 hex
reg[3:0] ct_data;//8 hex
reg which;//�Ĵ���д�� or ���ݴ洢��д��

initial begin
	status = `S0;
	ct_tm = 0;// counter_time
	ct_pc=0;
	ct_grf = 0;
	ct_addr = 0;
	ct_data = 0;
	which = 0;
end

always @(posedge clk) begin
	if(reset == 1) begin
		status <= `S0;
		ct_tm <= 0;
	end		
	else begin
		case(status)

//<�ַ�'^'><ʮ������time><�ַ�'@'><8λʮ��������pc>
//<�ַ�':'><0�������ɿո�>


//<�ַ�'$'><ʮ������grf>
//<�ַ�'*'><8λʮ��������addr>


//<0�������ɿո�>
//<�ַ�'<'��'='><0�������ɿո�><8λʮ��������data><�ַ�'#'>

		`S0 : begin //match noting
					if(char == "^")
						status <= `S1;
					else
						status <= `S0;
				end	
		`S1 : begin //match "^"
					if ((char >= "0") && (char <= "9")) begin
						status <= `S2;
						ct_tm <= 1;
					end
					else 
						status <= `S0;
				end
		`S2 : begin //match 1~4 decimals
					if(char == "@") begin //���� @
						if(ct_tm <= 4) begin
							status <= `S3;
							ct_tm <=0;
						end
						else begin
							status <= `S0;
							ct_tm <= 0;
						end
					end
					else if((char >= "0") && (char <= "9")) begin //����ʮ��������
								if(ct_tm <= 3)
									ct_tm <= ct_tm +1;
								else begin
									status <= `S0;
									ct_tm <= 0;
								end
							end
					else begin //������ ��λ
						status <= `S0;
						ct_tm <=0;
					end
				end
		`S3 : begin //matched @ ,target to 8 hex
					if((((char >= "0")&&(char <= "9")) || ((char >= "a") && (char <= "f"))))//����16������
						if(ct_pc==7) begin
							status <= `S4;
							ct_pc <= 0;
						end
						else if (ct_pc <7)
							ct_pc <= ct_pc + 1;
						else begin
							status <= `S0;
							ct_pc <= 0;
						end
					else begin
						status <= `S0;
						ct_pc <= 0;
					end
				end
		`S4 : begin//
					if(char == ":")
						status <= `S5;
					else
						status <= `S0;
				end
		`S5 : begin//matched : ,target to which
					if(char == " ")
						status <= `S5;
					else if(char == "$") begin
						status <= `S6;
						which <=0;
					end
					else if(char == "*") begin
						status <= `S7;
					end
					else
						status <= `S0;
				end
		`S6 : begin
					if((char >="0") && (char <= "9"))//�����������
						if (ct_grf == 3) begin
							status <= `S8;
							ct_grf <= 0;
							which <= 0;
						end
						else if(ct_grf < 3)
							ct_grf <= ct_grf + 1;
						else begin
							status <= `S0;
							ct_grf <= 0;
						end
					else if (char == " ")//�������ո�
						if (ct_grf != 0) begin//���������ʮ������
							status <= `S8;
							which <= 0;
							ct_grf <= 0;
						end
						else begin //��ǰһ�����ֶ�δ����
							status <= `S0;
							which <=0;
							ct_tm <= 0;
							ct_pc <= 0;
							ct_grf <= 0;
							ct_addr <= 0;
							ct_data <= 0;
						end
					else if(char == "<")
						if((ct_grf <= 4) && (ct_grf >0)) begin
							status <= `S9;
							ct_grf <=0;
						end
						else begin
							status <= `S0;
							ct_grf <= 0;
						end
					else begin //����� ���� �� �ո�
						status <= `S0;
						ct_grf <= 0;
						which <=0;
						ct_tm <= 0;
						ct_pc <= 0;
						ct_grf <= 0;
						ct_addr <= 0;
						ct_data <= 0;
					end				
				end
		`S7 : begin
					if((((char >= "0")&&(char <= "9")) || ((char >= "a") && (char <= "f")))) begin//����ʮ��������
						if(ct_addr == 7) begin//ԭ����7����ֱ����ת
							status <= `S8;
							which <= 1;
							ct_addr <= 0;
						end
						else if(ct_addr < 7)//ԭ������7��
							ct_addr <= ct_addr + 1;
						else begin//����7��
							status <= `S0;
							ct_addr <= 0;
							which <= 0;
						end
					end
					else begin //������
						status <= `S0;
						ct_addr <= 0;
						which <= 0;
					end
				end
		`S8 : begin //matched 1~4 decimals or matched 8 hexs, target to "<"
					if(char == " ") begin
					end
					else if (char == "<")
						status <= `S9;
					else begin
						status <= `S0;
						which <=0;
					end
				end
		`S9 : begin 
					if(char == "=")
						status <= `S10;
					else begin
						status <= `S0;
						which <=0;
					end
				end
		`S10 : begin // target to 8 hex
					if(char == " ") begin//����ո�״̬����
					end
					else if((((char >= "0")&&(char <= "9")) || ((char >= "a") && (char <= "f")))) begin//����16������
						status <= `S11;
						ct_data <= 1;
					end
					else begin//����������
						status <= `S0;
						ct_data <= 0;
						which <=0;
					end
				end
		`S11 : begin // �Ѿ��õ���1λdata
					if((((char >= "0")&&(char <= "9")) || ((char >= "a") && (char <= "f")))) begin//����16������
						if(ct_data == 7) begin
							status <= `S12;
							ct_data <= 0;
						end
						else if(ct_data < 7) begin
							ct_data <= ct_data +1;
						end
						else begin
							status <= `S0;
							ct_data <= 0;
						end
					end
					else begin
						status <= `S0;
						ct_data <= 0;
						which <=0;
					end
				end
		`S12 : begin //
					if(char == "#")
						status <= `S13;//����match��������
					else begin
						status <= 0;
						which <=0;
					end
				end
		`S13 : begin//matched ��������
					if(char == "^")//���¿�ʼ
						status <= `S1;
					else 
						status <= `S0;
					which <=0;
				end
				
		default begin
						status <= `S0;
						which <=0;
						ct_tm <= 0;
						ct_pc <= 0;
						ct_grf <= 0;
						ct_addr <= 0;
						ct_data <= 0;
					end	
		endcase
	end
end
assign format_type = (status != `S13)? 2'b00:
							(which == 0)? 	2'b01:
							(which == 1)?	2'b10:
												2'b00;
endmodule
