module key_register(
input clk,
input reg  [79:0]key_register,
output reg [63:0]round_key
);
reg [79:0]master_key;
reg [3:0]s;
always @(posedge clk)begin

key_register<=master_key;
    for (i=0;i<=25;i++) begin
    
     key_register <<< 13;
     [3:0]<=s[3:0];
     [63:59]<=[63:59]^i;
     round_key[i]= key_register[0:63];
     
    end
end
endmodule
