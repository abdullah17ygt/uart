module s_box_layer(
input [3:0]p,
output wire [3:0]s_out
);

wire x0,x1,x2,x3;
wire y1,y2,y3,y0;

assign x0 = p[0];
assign x1 = p[1];
assign x2 = p[2];
assign x3 = p[3];



assign y0 =  (!x3&!x2&x1)  | (!x2&x1&x0)   | (!x3&x2&!x1) | (x2&!x1&x0)  | (x3&!x2&!x1&!x0) | (x3&x2&x1&!x0); 
assign y1 =  (!x3&!x2&!x0) | (!x3&!x1&!x0) | (x2&x1&x0)   | (x3&!x2&x0)  | (x3&x2&x1); 
assign y2 =  (!x3&!x2&!x1) | (!x2&!x1&!x0) | (!x3&x2&!x0) | (x3&x1&x0)   | (x3&x2&x0); 
assign y3 =  (!x3&!x2&!x0) | (!x3&x1&!x0)  | (!x3&x2&x0)  | (x3&!x1&!x0) | (x3&!x2&x1&x0); 


assign s_out[0] = y0;
assign s_out[1] = y1;
assign s_out[2] = y2;
assign s_out[3] = y3;


endmodule