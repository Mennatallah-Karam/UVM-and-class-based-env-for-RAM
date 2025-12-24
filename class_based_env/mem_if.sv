interface mem_if #(parameter ADDR_WIDTH = 4, ADDR_DEPTH = 16, DATA_WIDTH = 32)(clk);
    input bit clk;
    logic rst; 
    logic EN;
    logic [ADDR_WIDTH-1:0] Address;
    logic [DATA_WIDTH-1:0] Data_in;
    logic  Valid_out;
    logic  [DATA_WIDTH-1:0] Data_out;

    modport DUT (input EN, Address, Data_in, rst, clk ,output Data_out, Valid_out);
    modport TEST (input clk ,Data_out, Valid_out,output EN, Address, Data_in, rst); 

endinterface 