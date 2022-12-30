`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2021 09:53:11 PM
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(
	output [15:0] S,
	output flag,
	input signed [15:0] A,
	input signed [15:0] B,
	input [3:0] alu_ops
	);

    //assign z=~|S;
  /*  wire [15:0] 
    
  reg signed [15:0] A_signed = A;
  reg signed [15:0] B_signed = B;*/

    
    
    reg[15:0] result=0;
    //wire [15:0] result;
    assign S=result;
    assign flag=(B==0 && alu_ops==2'b11);
    
    
    always @(*) begin
        case (alu_ops)
            2'b00: result <= A+B;
            2'b01: result <= A-B;
            2'b10: begin result<=A*B;  end
            2'b11: 
            begin 
            if(!flag)begin result<=A/B; end
            else begin result<=0; end 
            
            end
            /*4'b0100: begin result<=A|B;  end
            4'b0101: begin result<=A&B;  end
            4'b0110: begin result<=A^B; end
            4'b0111: begin result<=-A;  end
            4'b1000: begin result<=~A;  end 
            4'b1001: begin result<=~B;  end*/
            default: result <= 16'sd9999 ;
        endcase
    end

endmodule