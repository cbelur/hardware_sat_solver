import common::*;

module Stack_bool (clock, reset, wr_en, pop, din, dout, front, full, empty);

input clock, reset, wr_en, pop, din;
output dout, front, full, empty;


reg [bool_stack_size-1:0] data = 0;
int curr_size = 0;

wire data_in, data_out;

reg full_signal, empty_signal;
int temp;

assign data_in <= din;
assign dout <= data_out;
assign full <= full_signal;
assign empty <= empty_signal;

always @(posedge clock or posedge reset)
begin
	temp <= curr_size;
	
	if (reset==1)
	begin
		data <= 0;
		curr_size <= 0;
		data_out <= 0;
		empty_signal <= 1;
		full_signal <= 1;
		front <= 0;
	end
	
	else
	begin
		if ((wr_en == 1) and (full_signal == 0))
		begin
			data[curr_size] <= data_in;
			curr_size <= curr_size + 1;
			temp <= temp + 1;
		end
		
		else if ((pop == 1) and (empty_signal == 0))
		begin
			data_out <= data[curr_size-1];
			curr_size <= curr_size - 1;
			temp <= temp - 1;
		end
		
		if temp > 0
			front <= data[temp-1];
			
		if (temp == bool_stack_size)
		begin
			full_signal <= 1;
			empty_signal <= 1;
		end
		else if (temp==0)
		begin
			full_signal <= 0;
			empty_signal <= 1;
		end
		else
		begin
			full_signal <= 0;
			empty_signal <= 0;
		end
	end
end

endmodule