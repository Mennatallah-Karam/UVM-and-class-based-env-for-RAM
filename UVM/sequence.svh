class write_sequence_1 extends uvm_sequence#(my_sequence_item);
  `uvm_object_utils(write_sequence_1)
  my_sequence_item seq_item;

  function new(string name = "write_sequence_1");
    super.new(name);
  endfunction

  task pre_body;
    seq_item = my_sequence_item::type_id::create("seq_item");
  endtask

  task body;
    repeat (5) begin
      start_item(seq_item);
      if (!seq_item.randomize() with {
        Data_in inside {[0:199]};
        Address inside {[0:15]};
      }) `uvm_error("RANDOMIZE", "Randomization failed in write_sequence_1")
      seq_item.EN = 1; 
      $display("[write_sequence_1] WRITE: Data_in = %0h, Address = %0d",
               seq_item.Data_in, seq_item.Address);
      finish_item(seq_item);
    end
  endtask
endclass


class read_sequence_1 extends uvm_sequence#(my_sequence_item);
  `uvm_object_utils(read_sequence_1)
  my_sequence_item seq_item;

  function new(string name = "read_sequence_1");
    super.new(name);
  endfunction

  task pre_body;
    seq_item = my_sequence_item::type_id::create("seq_item");
  endtask

  task body;
    repeat (5) begin
      start_item(seq_item);
      if (!seq_item.randomize() with {
        Address inside {[0:15]};
      }) `uvm_error("RANDOMIZE", "Randomization failed in read_sequence_1")
      seq_item.EN = 0; // Enable read
      $display("[read_sequence_1] READ: Address = %0h", seq_item.Address);
      finish_item(seq_item);
    end
  endtask
endclass

class write_sequence_2 extends uvm_sequence#(my_sequence_item);
  `uvm_object_utils(write_sequence_2)
  my_sequence_item seq_item;

  function new(string name = "write_sequence_2");
    super.new(name);
  endfunction

  task pre_body;
    seq_item = my_sequence_item::type_id::create("seq_item");
  endtask

  task body;
    repeat (5) begin
      start_item(seq_item);
      if (!seq_item.randomize() with {
        Data_in inside {[200:399]};
        Address inside {[8:16]};
      }) `uvm_error("RANDOMIZE", "Randomization failed in write_sequence_2")
      seq_item.EN = 1;
      $display("[write_sequence_2] WRITE: Data_in = %0h, Address = %0d",
               seq_item.Data_in, seq_item.Address);
      finish_item(seq_item);
    end
  endtask
endclass


class read_sequence_2 extends uvm_sequence#(my_sequence_item);
  `uvm_object_utils(read_sequence_2)
  my_sequence_item seq_item;

  function new(string name = "read_sequence_2");
    super.new(name);
  endfunction

  task pre_body;
    seq_item = my_sequence_item::type_id::create("seq_item");
  endtask

  task body;
    repeat (5) begin
      start_item(seq_item);
      if (!seq_item.randomize() with {
        Address inside {[8:16]};
      }) `uvm_error("RANDOMIZE", "Randomization failed in read_sequence_2")
      seq_item.EN = 0;
      $display("[read_sequence_2] READ: Address = %0d", seq_item.Address);
      finish_item(seq_item);
    end
  endtask
endclass




