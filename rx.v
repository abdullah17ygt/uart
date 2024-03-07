module rx#(parameter BAUDRATE = 434)(


input  clk,
input  in,
input rst,
output reg print,

output reg [7:0]out

);


localparam [1:0] 
idle = 2'b000,
start = 2'b001,
write = 2'b010,
stop = 2'b011;

reg [7:0]index=0;
reg [1:0]state = idle;
reg [7:0]data;

//reg a;
reg [8:0]counter;



//   always @(posedge clk)begin
//        y<=y+1;
       
          
//            if (y < 217) begin
//                a=1;
                
//                end
//                else if (y <= 434) begin
                   
//                   a=0;
//                end
//                else if (y >= 434) begin
//                    y<=0;
//                end
//            end   
    
    always @(posedge clk) begin
    if (rst) begin
      print<=0;
      counter<=0; 
      index<=0;
      out<=0;
   end 
   
   else begin
    counter<=counter+1;
            case(state)    
               idle: begin
              
                print<=0;
                index<=0;
                data<=0;
                state<=idle;
                counter<=0;    
                 
                if(in == 1'b0)begin
                 state<=start;
                end 
              end
                start : begin                 
//                 if (counter == ((BAUDRATE/2)-1))  begin
//                 counter <=0 ;
                     if(in == 1'b0)begin
                        state <= write;
                       end
                       else begin
                            state<= idle;                      
                       end
//                       end
//                 else begin
//                   counter<=counter+1;
//                   state <= start;
//                 end
                   end
                     
                  
                write: begin    
                   if (counter == BAUDRATE)  begin
                      counter <=0 ;
                        if (index < 8'h08 ) begin
                            data[index] <= in;
                            index <= index + 1;
                            state <= write;                            
                        end
                        else begin
                         state <= stop;
                         index <= 0;
                        end
                    end
                    else begin
                      counter <= counter +1 ;          
                        state <= write;
                        
                        end 
                end
                
                stop : begin
                if (counter == ((BAUDRATE/2)-1))  begin
                    out <= data;                   
                    index <= 0;                   
                    print <= 1;
                    state <= idle;
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