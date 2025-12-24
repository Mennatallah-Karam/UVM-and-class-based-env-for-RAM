class Trans;
  rand bit [3:0] Address;
  rand bit [31:0] Data_in;
  bit [31:0] Data_out;
  bit Valid_out;
  bit EN;
  
  constraint addr_range { Address inside {[0:15]}; }
  function void display(string tag = "");
    $display("[%0s] Addr=%0d, Data_in=%0h, Data_out=%0h, EN=%b, Valid_out=%b", 
             tag, Address, Data_in, Data_out, EN, Valid_out);
  endfunction
endclass
