module MealyPattern(
	input        clock,
	input        i,
	output [1:0] o
);
	reg q1, q2;
	reg [1:0] tmp;
	reg [1:0]delay = 2'b10;
//	always@ (*)
	initial begin
		delay = 2;
		q1 = 1'b0;
		q2 = 1'b0;
	end
	// TODO: delay auf 2 setzten
	always @(posedge clock)
		begin
			if (delay ==0) begin
				assign tmp[0]= ~(q1 | q2) &i;
				assign tmp[1]= q1 & q2 & i;
			end else begin
				assign tmp[0]= 1'b0;
				assign tmp[1]= 1'b0;
				delay = delay - 1;
				$display("wait");
			end
			
			q2 <= q1;
			q1 <= i;
			$display("q2, q1, i");
			$display(q2, q1, i);
		end
	assign o[0] = tmp[0]; 
	assign o[1] = tmp[1];

	
// TODO Implementierung

endmodule



module MealyPatternTestbench();
	reg i;
	wire [1:0] out;
	reg clk;
	// TODO Input Stimuli

	MealyPattern machine(.clock(clk), .i(i), .o(out));
	
	// TODO Überprüfe Ausgaben
	//1110011001
	initial begin
		clk <=1;
	end
	always  
	    #5  clk =  ! clk;
	initial begin // sequential block a=0;b=0;c=0; #10;//applyinputs,wait10ns
	clk <=1;
	i <= 1'b1; #5;
	$monitor("%d, \t%d", out[0], out[1]);
	i <= 1'b1; #5;
	$monitor("%d, \t%d", out[0], out[1]);
	i = 1'b1; #10;
	$monitor("%d, \t%d", out[0], out[1]);
	// should be 1
	$display("should be 1");
	i <= 1'b0; #10;
	$monitor("%d, \t%d", out[0], out[1]);
	i <= 1'b0; #10;
	$monitor("%d, \t%d", out[0], out[1]);
	i <= 1'b1; #10;
	$monitor("%d, \t%d", out[0], out[1]);
	// should be 1
	$display("should be 1");
	i <= 1'b1; #10;
	$monitor("%d, \t%d", out[0], out[1]);
	i <= 1'b0; #10;
	$monitor("%d, \t%d", out[0], out[1]);
	i <= 1'b0; #10; 
	$monitor("%d, \t%d", out[0], out[1]);
	i <= 1'b1; #10;
	$monitor("%d, \t%d", out[0], out[1]);
	// should be 1
	$display("should be 1");
	$finish;
	end
endmodule

