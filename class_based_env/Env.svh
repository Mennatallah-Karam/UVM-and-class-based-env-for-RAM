class Env;
  Sequencer seq;
  Driver drv;
  Monitor mon;
  Subscriber sub;
  Scoreboard sb;
  event done_event;

  virtual mem_if.TEST vif;
  mailbox #(Trans) seq_mbox;
  mailbox #(Trans) mon_to_sb_mbox;
  mailbox #(Trans) mon_to_sub_mbox;
  mailbox #(Trans) exp_mbox;
  event drv_to_mon_evt;
  event mon_to_drv_evt;
  event seq_done_evt;

  function new(virtual mem_if.TEST vif);
    this.vif = vif;
    seq_mbox       = new(1);
    exp_mbox       = new(1);
    mon_to_sb_mbox = new(1);
    mon_to_sub_mbox = new(1);

    drv_to_mon_evt = drv_to_mon_evt;
    mon_to_drv_evt = mon_to_drv_evt;
    seq_done_evt   = seq_done_evt;

    seq = new(done_event);
    seq.seq_mbox = seq_mbox;
    seq.seq_done_evt = seq_done_evt;
    drv = new(vif, seq_mbox, drv_to_mon_evt, mon_to_drv_evt);
    mon = new(vif, mon_to_sb_mbox, mon_to_sub_mbox, drv_to_mon_evt, mon_to_drv_evt);
    sub = new(mon_to_sub_mbox);
    sb = new(mon_to_sb_mbox, exp_mbox, seq_done_evt);
  endfunction

  task run();
    fork
      seq.start(exp_mbox);
      drv.start();
      mon.start();
      sub.start();
      sb.start();
    join_any
      @done_event;         // Wait for sequencer to finish
      disable fork;        // Kill all forked processes
  endtask
endclass
