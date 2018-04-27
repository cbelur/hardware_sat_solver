`timescale 1ns / 1ps

import common::*;

module top_test();
logic clock, reset, load;
logic[number_literal-1:0] i;
logic ended, sat;
logic[number_literal-1:0] model;

top test1(clock, reset, load, i, ended, sat, model);

always
begin
clock=1'b1; #50; clock=1'b0; #50;
end

initial
begin
reset=1'b1; load <= 1'b0;

#60;
reset=1'b0; load <= 1'b1;

/*i<= 3'b11100; #100; //1 abc
i<= 3'b00000; #100; //2
i<= 3'b00000; #100; //3 a'b'c'
i<= 3'b11100; #100; //4
i<= 3'b00001; #100; //5 d'e
i<= 3'b00010; #100; //6
i<= 3'b00010; #100; //7 a'd
i<= 3'b10000; #100; //8
i<= 5'b01100; #100; //9 bc
i<= 5'b00000; #100; //10
i<= 5'b11011; #100; //11 abc'de
i<= 5'b00100; #100; //12
i<= 5'b01010; #100; //13 bde'
i<= 5'b00001; #100; //14
i<= 5'b00000; #100; //15 
i<= 5'b00000; #100; //16
i<= 5'b00000; #100; //17
i<= 5'b00000; #100; //18
i<= 5'b00000; #100; //19
i<= 5'b00000; #100; //20
load <= 1'b0;*/

i <= 3'b110; #100;

i <= 3'b000; #100;

i <= 3'b101; #100;

i <= 3'b000; #100;

i <= 3'b010; #100;

i <= 3'b101; #100;

i <= 3'b000; #100;

i <= 3'b011; #100;

i <= 3'b011; #100;

i <= 3'b100; #100;

load <= 1'b0; 

end
endmodule