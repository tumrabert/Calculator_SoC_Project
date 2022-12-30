`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2022 12:08:29 AM
// Design Name: 
// Module Name: uartInput
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


module uartInput(
    output [15:0] A,B,
    output [1:0] alu_ops,
    output [1:0] st, 
    input [7:0] data,
    input received,reset,clk
    );
    
    reg [1:0]state=0;
    reg [2:0] rcd;  
    reg [2:0] rsd;
    reg [1:0]substate=2'b00;
    reg [15:0]A_reg,B_reg=0;
    reg [1:0]opcode_reg=0;
    reg en=0;
    integer tua,count;
    integer is_Aneg,is_Bneg;
    reg is_reset=0;
    /*reg [1:0]count;*/
    
    
    initial begin
    count=0;
    tua=10;
    is_Aneg=1;
    is_Bneg=1;
    end
    
    
    always @(posedge clk) begin
    rcd <= {rcd[1:0], received};
    rsd <= {rsd[1:0], reset};
    end
    
    /*always @(posedge clk) begin
        if(reset_substate)begin
        substate<=2'b00;
        reset_substate=0;
        end
        
        if(rcd[1] & ~rcd[2] & en)begin
        case(substate)
            2'b00:begin tua<=0;substate<=substate+1; end
            2'b01:begin tua<=10;substate<=substate+1; end
            2'b10:begin tua<=100;substate<=substate+1;end
            2'b11:begin tua<=1000;substate<=2'b00;end
            endcase
        end
        

    end*/
    
    always@(posedge clk)begin
        if((rsd[1] & ~rsd[2]) || is_reset) begin//Rise edge of reset
        state<=0;
        A_reg<=0;
        B_reg<=0;
        //en<=0;
        count=0;
        opcode_reg<=0;
        is_reset<=0;
        is_Aneg=1;is_Bneg=1;
        //reset_substate=1;
        end
        
        if(rcd[1] & ~rcd[2]) begin //Rise edge of received
        case(state)
        2'b00://Input A
                begin
                
                if(data==8'h6e) begin is_Aneg=-1; end
                
                if(count<4) begin
                en<=1;
                case(data)
                            8'h30:begin A_reg<=A_reg*tua+0;count=count+1; end
                            8'h31:begin A_reg<=A_reg*tua+1;count=count+1; end
                            8'h32:begin A_reg<=A_reg*tua+2;count=count+1; end
                            8'h33:begin A_reg<=A_reg*tua+3;count=count+1; end
                            8'h34:begin A_reg<=A_reg*tua+4;count=count+1; end
                            8'h35:begin A_reg<=A_reg*tua+5;count=count+1; end
                            8'h36:begin A_reg<=A_reg*tua+6;count=count+1; end
                            8'h37:begin A_reg<=A_reg*tua+7;count=count+1; end
                            8'h38:begin A_reg<=A_reg*tua+8;count=count+1; end
                            8'h39:begin A_reg<=A_reg*tua+9;count=count+1; end
                            //8'h6e:begin A_reg<=A_reg*-1;  end//n 
                            8'h0d:begin /*en<=0;reset_substate=1; */state<=state+1; count=0; end //enter 
                            endcase
                 end
                 else begin if(data==8'h0d) begin /*en<=0;reset_substate=1; */state<=state+1; count=0; end end
                end
        2'b01://Input oper
            begin
            case(data)
                            8'h2b:opcode_reg<=2'b00; //+
                            8'h2d:opcode_reg<=2'b01; //-
                            8'h2a:opcode_reg<=2'b10;// *
                            8'h2f:opcode_reg<=2'b11; // division
                            8'h0d:begin state<=state+1; end //enter 
            endcase
            end
        2'b10://Input BV
            begin
            if(data==8'h6e) begin is_Bneg=-1; end
            
            if(count<4) begin
            en<=1;
             case(data)
                            8'h30:begin B_reg<=B_reg*tua+0;count=count+1; end
                            8'h31:begin B_reg<=B_reg*tua+1;count=count+1; end
                            8'h32:begin B_reg<=B_reg*tua+2;count=count+1; end
                            8'h33:begin B_reg<=B_reg*tua+3;count=count+1; end
                            8'h34:begin B_reg<=B_reg*tua+4;count=count+1; end
                            8'h35:begin B_reg<=B_reg*tua+5;count=count+1; end
                            8'h36:begin B_reg<=B_reg*tua+6;count=count+1; end
                            8'h37:begin B_reg<=B_reg*tua+7;count=count+1; end
                            8'h38:begin B_reg<=B_reg*tua+8;count=count+1; end
                            8'h39:begin B_reg<=B_reg*tua+9;count=count+1; end
                            //8'h6e:begin B_reg<=B_reg*-1; end//n
                            8'h0d:begin /*en<=0;reset_substate=1;*/state<=state+1;count=0; end //enter 
                            endcase
            end
            else begin if(data==8'h0d) begin /*en<=0;reset_substate=1; */state<=state+1; count=0; end end
            end
        2'b11:// Calc
                begin
                    case(data)
                            8'h0d:begin is_reset<=1;state<=0; end//enter
                    endcase
                end
        
        
        endcase
        end
        end
        /*8'h6e:
            if(state==2'b00)
            A_reg<=A_reg*-1;
            else if(state==2'b10)
            B_reg<=B_reg*-1; //n*/
    
   // is_Aneg==1'b1 ? begin assign A = A_reg*-1; end : begin assign A = A_reg; end
    
    
   // is_Bneg==1'b1 ? begin assign B = B_reg*-1; end : begin assign B = B_reg; end
   /* always @(*) begin
    if(is_Aneg==1) begin 
    assign A = A_reg*-1; 
    end
    else begin assign A = A_reg; end

    if(is_Bneg==1) begin assign B = B_reg*-1;end
    else begin assign B = B_reg; end*/

    assign A = A_reg*is_Aneg;
    assign B = B_reg*is_Bneg;
    assign alu_ops = opcode_reg;
    assign st = state;
    
    //end
endmodule
