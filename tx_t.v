module tx_t#(parameter BAUDRATE = 434)(


input  clk,
input  rst,
input  fin,
input  ein,
output reg out

);
localparam [1:0] 
idle = 2'b00,
start = 2'b01,
write = 2'b10,
stop = 2'b11;

reg [7:0]f= 8'b01100110;
reg [7:0]e= 8'b01100101;
reg [7:0]index=0;

reg [1:0]state = idle;
reg [1:0]state2 = idle;

reg [7:0]data;
reg full2;
reg empty2;
reg full3;
reg empty3;
reg [8:0]counter=0;
wire empty;
wire full;
    debouncer s3 (.clk(clk), .din(ein),.dfinal(empty));
    debouncer s4 (.clk(clk), .din(fin),.dfinal(full));

//always@(posedge clk)begin
   
//        empty2 <= empty;
//        full2 <= full;
//            if(full==1 && full2==0)
//            full3<=1;
//            else begin
//            full3<=0; 
//           end
//           end
           
//       always@(posedge clk)begin
       
//            if(empty==1 && empty2==0)
//            empty3<=1;
//            else begin
//            empty3<=0;
//            end    
//        end
       




always @(posedge clk) begin 
    if (rst) begin
       
        out<=0;
        data<=0;
        counter<=0;
    end
    else begin
     case(state)    
       idle: begin
                index<=0;
                data<=0;                    
                counter<=0;    
                if (fin) begin               
                  state<= start;
                end 
                if (ein) begin
                  state<= start;
                end                        
            end 
          
            start : begin
                if (counter == (BAUDRATE-1)/2)  begin
                 counter <=0 ;
                 
                     if (full3) begin
                        out <=0;
                        data<=f;
                        state<=write;
                    end
                     else if (empty3) begin
                        out <=0;
                        data<=e;
                        state<=write;
                    end
                end
                else begin                         
             counter <=counter+1 ;
                end
            end
         write: begin
                 if (counter == BAUDRATE)  begin
                 counter <=0 ;
                    if (index < 8'h08 ) begin
                      out<= data[index];
                      index<=index+1;
                      state <= write;
                    end
                    else begin
                     state <= stop;
                    end
                 end   
              else begin                         
                 counter <=counter+1 ;
                 state<=write;
                end 
            end
                         
            stop : begin
               if (counter == ((BAUDRATE/2)-1))  begin
                    data<=0;
                    index<=0;
                    counter<=1;
                    state<=idle;
                    out<=1;
                 end
            else begin
                  counter <= counter +1 ;
            end 
            end 
            
           default : begin
           
            state <= idle;
            end
        endcase
            end
end
endmodule
