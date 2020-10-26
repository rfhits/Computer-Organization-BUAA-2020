`define s0 0
`define s_time 1
`define s_at 2
`define s_pc 3
`define s_colon 4
`define s_space1 5
`define s_space2 6
`define s_space3 7
`define s_grf 8
`define s_addr 9
`define s_data 10
`define s_equal 11





module cpu_checker(
    input clk,
    input reset,
    input [7:0] char,
 input [15:0] freq,
    output reg [1:0] format_type,
 output reg [3:0]error_code
    );
 reg [3:0] cnt;
 reg [3:0] state;
 reg [1:0] judge;
 reg [4:0] grf;
 reg [31:0] h;
 reg [31:0] t;
 reg [3:0] e;
 initial begin
  state <= `s0;
  cnt <=0;
  t <= 0;
  judge <= 0;
  format_type <= 0;
  error_code <= 0;
  e <= 0
  grf <= 0;
  h <= 0;
 end

always @( posedge clk ) begin
 if (reset) begin
  state <= `s0;
  cnt <= 0;
 end
 else begin
  case (state)
     `s0 : begin
    state <= (char == "^") ? `s_time : `s0 ;
    format_type <= 0;
    end

   `s_time : begin
    if ("0" <= char && char <= "9") begin
     cnt <= cnt + 1;
     t <= (t<<4) + char - "0";
     if (cnt <4)
      state <= `s_time ;
     else begin
      state <= `s0 ;
      cnt <= 0; 
      t <= 0;
     end
    end
    else if (char == "@" && cnt > 0 )begin
     state <= `s_pc ;
     if(t & ((freq>>>1)-1) != 0)
      e <= e + 1;   
     cnt <= 0;
    end 
    else begin
     state <= `s0;
     cnt <= 0;
     t <= 0;
    end
    end

   `s_pc : begin
    if ((char >= "0" && char <= "9")||(char >= "a" && char <="f")) begin
     cnt <= cnt + 1;
     if (char >= "0" && char <= "9")
      h <= (h<<4) + char - "0"; 
     else if (char >= "a" && char <="f")
      h <= (h<<4) + char - "a" + 10;
     if ( cnt < 8 )
      state <= `s_pc;
     else begin
      state <= `s0;
      cnt <= 0;
      h <= 0;
      e <= 0;
     end
    end
    else if (char == ":" && cnt == 8) begin
     state <= `s_space1;
     cnt <= 0;
     if(!((h & 3 == 0) && (h >= 32'h00003000 && h<= 32'h00004fff)))
      e <=e + 2;
     h <= 0;
    end
    else begin
     state <= `s0;
     cnt <= 0;
     h <= 0;
     e <= 0;
    end
   end

   `s_space1 :begin
    if (char == " ") 
     state <= `s_space1;
    else if  