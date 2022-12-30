`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2022 03:09:00 PM
// Design Name: 
// Module Name: numberCounter
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


module numberCounter(input clk,input [15:0]data,output[3:0]D3,D2,D1,D0);

reg [15:0] counter,prevData;
reg [3:0] ones,tens,hundreds,thousands;
reg start=0;

always@(posedge clk) begin
    if(prevData!=data&&!start)begin
        counter <= 0;
        ones <= 0;
        tens <= 0;
        hundreds <= 0;
        thousands <= 0;
        start<=1;
    end
    else if(counter==data||counter==-data) begin
        prevData<=data;
        start<=0;
    end
    else begin
        counter <= counter + 1;
        ones <= ones == 9 ? 0 : ones + 1;
        if(ones == 9) begin
            tens <= tens == 9 ? 0 : tens + 1;
            if(tens == 9) begin
                hundreds <= hundreds == 9 ? 0 : hundreds + 1;
                if(hundreds == 9) begin
                     thousands <= thousands + 1; 
                end
            end
        end
    end
end

assign D3 = thousands;
assign D2 = hundreds;
assign D1 = tens;
assign D0 = ones;

endmodule