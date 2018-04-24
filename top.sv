`timescale 1ns / 1ps

module top(input clock, reset, load,
           input[number_literal-1:0] i,
           output logic ended,
           output logic sat,
           output logic[number_literal-1:0] model);
           
typedef enum logic[4:0] {IDLE, BEFORE_INP, INPING, BACKTRACK_POPDB_STACK, BACKTRACK_POPLIT_STACK, NEGATE_BEFORE_PROP, BEFORE_POPULATE_STACK, 
                         POPULATE_STACK, BEFORE_PROP, PROPAGATING, AFTER_PROP, BEFORE_KERNELIZE, KERNELIZING, AFTER_KERNELIZE,
                         BEFORE_DB, DBING, AFTER_DB, UNSAT, RETURN_MODEL, FILL_VECT, SAT_RETURN, PROPAGATE} state;
           
state present_state;

logic Kernel_find;
formula Kernel_in_formula;
logic Kernel_ended;
formula Kernel_out_formula;
logic Kernel_sat;
logic Kernel_unsat;
logic Kernel_propagating;
lit Kernel_out_lit;

logic DB_find;
formula DB_formula_in;
logic DB_ended;
lit DB_lit_out;

logic Prop_find;
formula Prop_in_formula;
lit Prop_in_lit;
logic Prop_ended;
logic Prop_empty_clause;
logic Prop_empty_formula;
formula Prop_out_formula;

logic Lit_St_wr_en;
logic Lit_St_pop;
lit Lit_St_din;
lit Lit_St_dout;
lit Lit_St_front;
logic Lit_St_full;
logic Lit_St_empty;

logic DV_St_wr_en;
logic DV_St_pop;
lit DV_St_din;
lit DV_St_dout;
lit DV_St_front;
logic DV_St_full;
logic DV_St_empty;
           
logic Formula_St_wr_en;
logic Formula_St_pop;
formula Formula_St_din;
formula Formula_St_dout;
formula Formula_St_front;
logic Formula_St_full;
logic Formula_St_empty; 

logic Backtrack_St_wr_en;
logic Backtrack_St_pop;
logic Backtrack_St_din;
logic Backtrack_St_dout;
logic Backtrack_St_front;
logic Backtrack_St_full;
logic Backtrack_St_empty;

logic IP_load;
logic[number_literal-1:0] IP_i;
formula IP_formula_res;
logic IP_ended;

formula F;
lit C;
lit to_populate;
logic[number_literal-1:0] output_vect;
logic temp_sat;
logic temp_unsat;
logic next_Backtrack;
logic wait_delay;

DB_kernel dbkernel(.clock(clock), 
                   .reset(reset),
                   .find(Kernel_find),
                   .in_formula(Kernel_in_formula),
                   .ended(Kernel_ended),
                   .out_formula(Kernel_out_formula),
                   .sat(Kernel_sat),
                   .unsat(Kernel_unsat),
                   .propagating(Kernel_propagating),
                   .out_lit(Kernel_out_lit));
         
decide_branch decidebranch(.clock(clock),
                           .reset(reset),
                           .find(DB_find),
                           .formula_in(DB_formula_in),
                           .ended(DB_ended),
                           .lit_out(DB_lit_out));

Propagate_literal propagateliteral(.clock(clock),
                                   .reset(reset),
                                   .find(Prop_find),
                                   .in_formula(Prop_in_formula),
                                   .in_lit(Prop_in_lit),
                                   .ended(Prop_ended),
                                   .empty_clause(Prop_empty_clause),
                                   .empty_formula(Prop_empty_formula),
                                   .out_formula(Prop_out_formula));
                                   
Stack_integer stackinteger(.clock(clock),
                           .reset(reset),
                           .wr_en(DV_St_wr_en),
                           .pop(DV_St_pop),
                           .din(DV_St_din),
                           .dout(DV_St_dout),
                           .front(DV_St_front),
                           .full(DV_St_full),
                           .empty(DV_St_empty));

Stack_formula stackformula(.clock(clock),
                           .reset(reset),
                           .wr_en(Formula_St_wr_en),
                           .pop(Formula_St_pop),
                           .din(Formula_St_din),
                           .dout(Formula_St_dout),
                           .front(Formula_St_front),
                           .full(Formula_St_full),
                           .empty(Formula_St_empty));
                           
Stack_bool stackbool(.clock(clock),
                     .reset(reset),
                     .wr_en(Backtrack_St_wr_en),
                     .pop(Backtrack_St_pop),
                     .din(Backtrack_St_din),
                     .dout(Backtrack_St_dout),
                     .front(Backtrack_St_front),
                     .full(Backtrack_St_full),
                     .empty(Backtrack_St_empty));
                     
read_store readstore(.clock(clock),
                     .reset(reset),
                     .load(load),
                     .i(i),
                     .formula_res(IP_formula_res),
                     .ended(IP_ended));
                     
always_ff@(posedge clock or posedge reset)
if (reset)
    begin
    ended <= 1'b0;
    sat <= 1'b0;
    model <= 1'b0;
    F <= zero_formula;
    C <= zero_lit;
    to_populate <= zero_lit;
    output_vect <= 1'b0;
    temp_sat <= 1'b0;
    temp_unsat <= 1'b0;
    next_Backtrack <= 1'b0;
    Kernel_find <= 1'b0;
    Kernel_in_formula <= zero_formula;
    DB_find <= 1'b0;
    DB_formula_in <= zero_formula;
    Prop_find <= 1'b0;
    Prop_in_formula <= zero_formula;
    Prop_in_lit <= zero_lit;
    Lit_St_wr_en <= 1'b0;
    Lit_St_pop <= 1'b0;
    Lit_St_din <= 1'b0;
    Formula_St_wr_en <= 1'b0;
    Formula_St_pop <= 1'b0;
    Formula_St_din <= zero_formula;
    Backtrack_St_wr_en <= 1'b0;
    Backtrack_St_pop <= 1'b0;
    Backtrack_St_din <= 1'b0;
    present_state <= BEFORE_INP;
    wait_delay <= 1'b0;
    end
else if (clock)
    begin
    Kernel_find <= 1'b0;
    DB_find <= 1'b0;
    Prop_find <= 1'b0;
    Lit_St_wr_en <= 1'b0;
    Lit_St_pop <= 1'b0;
    DV_St_wr_en <= 1'b0;
    DV_St_pop <= 1'b0;
    Formula_St_wr_en <= 1'b0;
    Formula_St_pop <= 1'b0;
    Backtrack_St_wr_en <= 1'b0;
    Backtrack_St_pop <= 1'b0;
    if (wait_delay == 1'b0)
        begin
        case(present_state)
            BEFORE_INP:
                begin
                if (load == 1'b1)
                    present_state <= INPING;
                end
            
            INPING:
                begin
                if (IP_ended == 1'b1)
                    begin
                    F <= IP_formula_res;
                    present_state <= BEFORE_KERNELIZE;
                    end
                end
            
            BEFORE_KERNELIZE:
                begin
                Kernel_in_formula <= F;
                Kernel_find <= 1'b1;
                present_state <= KERNELIZING;
                end
            
            KERNELIZING:
                begin
                if (Kernel_ended == 1'b1)
                    begin
                    F <= Kernel_out_formula;
                    temp_sat <= Kernel_sat;
                    temp_unsat <= Kernel_unsat;
                    present_state <= AFTER_KERNELIZE;
                    end
                else if (Kernel_propagating == 1'b1)
                    begin
                    Lit_St_din <= Kernel_out_lit;
                    Lit_St_wr_en <= 1'b1;
                    end
                end
            
            AFTER_KERNELIZE:
                begin
                if (temp_sat == 1'b1)
                    present_state <= RETURN_MODEL;
                else if (temp_unsat == 1'b1)
                    present_state <= BACKTRACK_POPDB_STACK;
                else
                    present_state <= BEFORE_DB;
                end
                
            BACKTRACK_POPDB_STACK:
                begin
                if (Backtrack_St_empty == 1'b1)
                    present_state <= UNSAT;
                else if (Backtrack_St_front == 1'b1)
                    begin
                    Backtrack_St_pop <= 1'b1;
                    DV_St_pop <= 1'b1;
                    Formula_St_pop <= 1'b1;
                    wait_delay <= 1'b1;
                    end
                else
                    present_state <= BACKTRACK_POPLIT_STACK;
                end
            
            BACKTRACK_POPLIT_STACK:
                begin
                if (Lit_St_front.num != DV_St_front.num)
                    begin
                    Lit_St_pop <= 1'b1;
                    wait_delay <= 1'b1;
                    end
                else
                    begin
                    Lit_St_pop <= 1'b1;
                    DV_St_pop <= 1'b1;
                    Backtrack_St_pop <= 1'b1;
                    Formula_St_pop <= 1'b1;
                    F <= Formula_St_front;
                    C <= DV_St_front;
                    present_state <= NEGATE_BEFORE_PROP;
                    wait_delay <= 1;
                    end
                end
                
            NEGATE_BEFORE_PROP:
                begin
                C.val <= ~(C.val);
                next_Backtrack <= 1'b1;
                present_state <= PROPAGATE;
                end
                
            PROPAGATE:
                begin
                to_populate <= C;
                present_state <= BEFORE_POPULATE_STACK;
                end
                
            BEFORE_POPULATE_STACK:
                begin
                Formula_St_din <= F;
                Backtrack_St_din <= next_Backtrack;
                DV_St_din <= to_populate;
                Lit_St_din <= to_populate;
                present_state <= POPULATE_STACK;
                end
                
            POPULATE_STACK:
                begin
                DV_St_wr_en <= 1'b1;
                Lit_St_wr_en <= 1'b1;
                Backtrack_St_wr_en <= 1'b1;
                Formula_St_wr_en <= 1'b1;
                C <= to_populate;
                present_state <= BEFORE_PROP;
                end
                
            BEFORE_PROP:
                begin
                Prop_find <= 1'b1;
                Prop_in_formula <= F;
                Prop_in_lit <= C;
                present_state <= PROPAGATING;
                end
                
            PROPAGATING:
                begin
                if (Prop_ended == 1'b1)
                    begin
                    F <= Prop_out_formula;
                    temp_sat <= Prop_empty_formula;
                    temp_unsat <= Prop_empty_clause;
                    present_state <= AFTER_PROP;
                    end
                end
                
            AFTER_PROP:
                begin
                if (temp_sat == 1'b1)
                    present_state <= RETURN_MODEL;
                else if (temp_unsat == 1'b1)
                    present_state <= BACKTRACK_POPDB_STACK;
                else
                    present_state <= BEFORE_KERNELIZE;
                end
                
            BEFORE_DB:
                begin
                DB_formula_in <= F;
                DB_find <= 1'b1;
                present_state <= DBING;
                end
                
            DBING:
                begin
                if (DB_ended == 1'b1)
                    begin
                    C <= DB_lit_out;
                    next_Backtrack <= 1'b0;
                    present_state <= AFTER_DB;
                    end
                end
            
            AFTER_DB:
                begin
                to_populate <= C;
                present_state <= BEFORE_POPULATE_STACK;
                end
                
            UNSAT:
                begin
                ended <= 1'b1;
                sat <= 1'b0;
                end
                
            RETURN_MODEL:
                begin
                output_vect <= 1'b0;
                present_state <= FILL_VECT;
                end
                
            FILL_VECT:
                begin
                if (Lit_St_empty == 1'b0)
                    begin
                    output_vect[Lit_St_front.num - 1] <= Lit_St_front.val;
                    Lit_St_pop <= 1'b1;
                    wait_delay <= 1'b1;
                    end
                else
                    present_state <= SAT_RETURN;
                end
                
            SAT_RETURN:
                begin
                ended <= 1'b1;
                sat <= 1'b1;
                model <= output_vect;
                end
                
            
        endcase
        end
    else
        wait_delay <= wait_delay - 1'b1;
    end     
endmodule
