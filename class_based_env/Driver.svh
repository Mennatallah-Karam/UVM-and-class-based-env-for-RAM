class Driver;
  virtual mem_if.TEST vif;
  mailbox #(Trans) seq_mbox;
  event drv_to_mon_evt;
  event mon_to_drv_evt;

  function new(virtual mem_if.TEST vif, mailbox #(Trans) mbox, event drv_to_mon_evt, event mon_to_drv_evt);
    this.vif = vif;
    this.seq_mbox = mbox;
    this.drv_to_mon_evt = drv_to_mon_evt;
    this.mon_to_drv_evt = mon_to_drv_evt;
  endfunction

  task start();
    Trans t;
    vif.EN <= 0;
    vif.Address <= 0;
    vif.Data_in <= 0;
    forever begin
      seq_mbox.get(t);
      @(posedge vif.clk);
      vif.EN <= t.EN;
      vif.Address <= t.Address;
      vif.Data_in <= t.Data_in;
      $display("[DRIVER] Driving : EN=%0b, Addr=%0d, Data_in=%0h", t.EN, t.Address, t.Data_in);
      @(posedge vif.clk); 
      vif.EN <= 0;
      -> drv_to_mon_evt;   
      @mon_to_drv_evt;     
    end
  endtask
endclass
