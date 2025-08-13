module parity (
    input clk,
    input reset,
    input data_in,     
    input valid,       
    input mode,        
    output reg parity_ok,
    output reg [3:0] counter
    
);
     reg curr_state;
     reg next_state;

parameter EVEN_STATE = 1'b0;
parameter ODD_STATE  = 1'b1;

always @(*)
 begin
  next_state = curr_state;
    if (valid)
     begin
      if(data_in)
         begin 
         case (curr_state)
             EVEN_STATE : begin
                 next_state = ODD_STATE;
             end
             ODD_STATE : begin
                 next_state = EVEN_STATE;
             end
         endcase
       
         end
         else 
         begin
          next_state =curr_state;
         end
     end
 end

always @(posedge clk or posedge reset) 
begin
    if (reset) begin
        curr_state <= EVEN_STATE;
          counter <= 4'd0;
             parity_ok <= 1'b0;
    end else 
       begin
        if (valid) begin
            curr_state <= next_state;

          if (counter < 4'd8)
                counter <=counter + 1;

          if (counter == 4'd8)
             begin 
             counter <= 4'd0;
               case(curr_state)
                 EVEN_STATE: 
                  begin
                     parity_ok <= (mode == 1'b0) ? 1'b1 : 1'b0; 
                  end
                 ODD_STATE: 
                   begin
                     parity_ok <= (mode == 1'b1) ? 1'b1 : 1'b0; 
                   end
               endcase
             end
            
        end
        else
             begin
                parity_ok <= 1'b0;
                counter <= 4'd0;
             end
       end
end

endmodule
