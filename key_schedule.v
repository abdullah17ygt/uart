module key_schedule(
input [4:0]tur_number,
input rst,
input [79:0]key_register,
output reg [79:0]round_key

);
reg [79:0]master_key;

wire [3:0]b,d;
reg  [79:0]a;
reg  [4:0]c;

s_box_layer dut (.p(a[3:0]),.s_out(b));



always @(*)begin
    if(rst) begin
        round_key = 0;
    end else begin
        master_key = key_register;
        a = {master_key[66:0],master_key[79:67]};
        c = a[63:59]^tur_number;
        round_key = {a[79:64],c,a[58:4],b};
    end
end
endmodule
