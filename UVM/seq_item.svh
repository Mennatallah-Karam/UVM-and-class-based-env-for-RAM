class my_sequence_item extends uvm_sequence_item;
 `uvm_object_utils(my_sequence_item)
    function new(string name = "my_sequence_item");
        super.new(name);
    endfunction 

    logic EN;
    randc logic [3:0] Address;
    randc logic [31:0] Data_in;
    logic  Valid_out;
    logic  [31:0] Data_out;

    constraint data_range { Data_in inside {[0:255]}; }
    constraint addr_range { Address inside {[0:16]}; }
endclass 