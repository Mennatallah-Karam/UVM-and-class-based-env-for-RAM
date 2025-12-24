class Monitor;
  virtual mem_if.TEST vif;
  mailbox #(Trans) sb_mbox;  
  mailbox #(Trans) sub_mbox;
  event drv_to_mon_evt;
  event mon_to_drv_evt;

  function new(virtual mem_if vif, mailbox #(Trans) sb_mbox, mailbox #(Trans) sub_mbox, event drv_evt, event mon_evt);
    this.vif = vif;
    this.sb_mbox = sb_mbox;
    this.sub_mbox = sub_mbox;
    this.drv_to_mon_evt = drv_evt;
    this.mon_to_drv_evt = mon_evt;
  endfunction

  task start();
    Trans t;
    forever begin
      @drv_to_mon_evt;        
      @(posedge vif.clk);     
      @(negedge vif.clk);     
      if (vif.Valid_out) begin
        t = new();
        t.Data_in = vif.Data_in;
        t.Address = vif.Address;
        t.Data_out = vif.Data_out;
        t.Valid_out = vif.Valid_out;
        sb_mbox.put(t);
        sub_mbox.put(t);
        $display("[MONITOR] Captured from VIF: Addr=%0d, Data_out=%0h (Valid_out=%0b)", t.Address, t.Data_out, t.Valid_out);
      end
      -> mon_to_drv_evt;     
    end
  endtask
endclass
