
module fifo#(
parameter memory_widht=8,
parameter memory_depth=8
)(
input  clk,
input  rst,
input  [memory_widht-1:0] data_in,
input wire enable_wrt,
input  enable_rd,
output reg [memory_widht-1:0] data_out,
output full,
output empty 
    );
    
    
    
    wire out_wrt,out_rd,out_rst;
    reg wrt=0,rd=0,en_wrt=0,rt=0,rt_f=0,en_rd=0;
   // debouncer s2 (.clk(clk), .din(enable_wrt),.dout(out_wrt));
    debouncer s3 (.clk(clk), .din(enable_rd),.dfinal(out_rd));
   // debouncer s4 (.clk(clk), .din(rst),.dfinal(out_rst));
    
    reg [memory_widht-1:0] memory[memory_depth-1:0];
    reg[$clog2(8)-1:0]write_cnt;
    reg[$clog2(8)-1:0]read_cnt;
    reg[$clog2(8+1)-1:0]element_count;

    
 
    reg [8:0]counter;

    assign empty = (element_count==0);
    assign full = (element_count==8);
    
    /*always@(posedge clk)begin
        wrt<=out_wrt;
            if(out_wrt==1 && wrt==0)
            en_wrt=~en_wrt;
            if (out_wrt==0 && wrt==1)
            en_wrt<=~en_wrt;
        end*/
        
    always@(posedge clk)begin
        rd<=out_rd;
            if(out_rd==1 && rd==0)
            en_rd<=1;
            else begin
            en_rd<=0;
            
           end
        end
       
        always@(posedge clk )begin
        
        if(rst) begin
            write_cnt<=0;
            read_cnt <= 0;
            element_count <= 0;
            data_out <= 0;
            counter <=0 ;
          
        end
        else  begin
       
            if(enable_wrt & ~full)begin
              memory[write_cnt]<= data_in;
              element_count<=element_count+1;
              write_cnt<=write_cnt+1;
            
                if (write_cnt==memory_depth-1) begin
                 write_cnt<=0;
                end 
//                else begin 
//                   write_cnt<=write_cnt+1;
//                 end
            end
            
            if(en_rd & ~empty) begin
               data_out <= memory[read_cnt];
               element_count <= element_count-1;
               read_cnt <= read_cnt+1;
                
               if (read_cnt == (memory_depth-1)) begin 
                read_cnt<=0;
               end
               
//                   else begin 
//                       read_cnt<= read_cnt+1;
//                   end
            end
        end
    end
        
endmodule
