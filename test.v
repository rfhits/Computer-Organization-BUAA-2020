`define s0 0
`define s1 1
`define s2 2
`define s3 3
`define s4 4
`define s5 5
`define s6 6
`define s7 7
`define s8 8
`define s9 9
`define s10 10
`define s11 11


module BlockChecker(
    input clk,
    input reset,
    input [7:0] in,
    output reg result
    );
reg [31:0]cnt;
reg [5:0]state;

initial
begin
 cnt <= 0;
 state <= `s0;
 result <= 1;
end

always @(posedge clk or posedge reset)
begin
 if(reset)
 begin
  cnt <= 0;
  state <= (in == " ")?`s0:`s3;
  result <=1;
 end
 else
 begin
  case(state)
   `s0:
   state <= (in == " ")?`s0:
      (in == "b"||in == "B")?`s1:
      (in == "e"||in == "E")?`s2:
      `s3;
   `s1:
   state <= (in == "e"||in == "E")?`s4:
      (in == " ")?`s0:`s3;
   `s2:
   state <= (in == "n"||in == "N")?`s8:
      (in == " ")?`s0:`s3;
   `s3:
   state <= (in == " ")?`s0:`s3;
   `s4:
   state <= (in == "g"||in == "G")?`s5:
      (in == " ")?`s0:`s3;
   `s5:
   state <= (in == "i"||in == "I")?`s6:
      (in == " ")?`s0:`s3;
   `s6:
   begin
    if(in == "n"||in == "N")
    begin
     result <= 0;
     cnt <= cnt +1;
     state <= `s7;
    end
    else if(in == " ")
     state <= `s0;
    else
     state <= `s3;
   end
   
   `s7:
   begin
    if(in == " ")state <= `s0;
    else
    begin
     state <= `s3;
     result <= 1;
     cnt <= $signed($signed(cnt) -1);
    end
   end
   `s8:
   begin
    if(in == "d"||in == "D")
    begin
     if(cnt > 0)
     begin
      result <= 1;
      state <= `s9;
      cnt <= $signed($signed(cnt) -1);
     end
     else
     begin
      result <= 0;
      state <= `s10;
      
     end
    end
    else if(in == " ")
     state <= `s0;
    else 
     state <= `s3;
   end
   `s9:
   begin
    if(in == " ")
    begin
     state <= `s0;
    end
    else
    begin
     cnt <= cnt + 1;
     state <= `s3;
     result <= 0;
    end
   end
   `s10:
   begin
    if(in == " ")state <= `s11;
    else 
    begin
     state <= `s3;
     result <= 1;
    end
    
   end
   `s11:
   begin
    state <= `s11;
    result <= 0;
   end
  endcase
 end
end

endmodule