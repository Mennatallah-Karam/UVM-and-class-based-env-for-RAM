class Subscriber;
  mailbox #(Trans) mon_mbox;

  rand bit [31:0] trans_data;
  rand bit [3:0] trans_addr;
  rand bit       trans_en;
  rand bit       trans_valid;

  covergroup covgrp;
    
    coverpoint trans_data {
      bins zero_data     = {32'h00};
      bins all_range     = {[32'h01 : 32'hFFFFFFFE]};
      bins full_ones     = {32'hFF};
    }

    coverpoint trans_addr {
      bins base_addr     = {4'd0};
      bins all_range     = {[0 : 15]};
      bins all_ones = {4'd16};
    }

    coverpoint trans_valid {
      bins valid_0 = {0};
      bins valid_1 = {1};
    }

    coverpoint trans_en {
      bins en_0 = {0};
      bins en_1 = {1};
    }

  endgroup

  function new(mailbox #(Trans) mon_mbox);
    this.mon_mbox = mon_mbox;
    covgrp = new(); 
  endfunction

  task start();
    Trans t;
    forever begin
      mon_mbox.get(t);
      $display("[SUBSCRIBER] Subscriber Received: Addr = %0d, Data_out = %0h, Valid = %0b",
               t.Address, t.Data_out, t.Valid_out);
      covgrp.sample();
    end
  endtask
endclass
