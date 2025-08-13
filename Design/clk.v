module clockdivider(clk,clk_in,reset);

    output reg clk;
    input clk_in,reset;
    reg [27:0]count;
    
    always @(posedge clk_in or posedge reset)
    begin
        if(reset)begin
            clk<=0;
            count<=0;
        end
        else if( count==100000000 )begin
            count<=0;
            clk<=~clk;
        end
        else begin
            count<=count+1;
        
        end 
    end
    
    endmodule
