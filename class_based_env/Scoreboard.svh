class Scoreboard;
  mailbox #(Trans) mon_mbox;
  mailbox #(Trans) exp_mbox;
  event seq_done_evt;

  bit [31:0] expected_mem [bit[3:0]];

  function new(mailbox #(Trans) mon_mbox, mailbox #(Trans) exp_mbox, event seq_done_evt);
    this.mon_mbox = mon_mbox;
    this.exp_mbox = exp_mbox;
    this.seq_done_evt = seq_done_evt;
  endfunction

  task track_expected();
    Trans t;
    forever begin
      exp_mbox.get(t);
      expected_mem[t.Address] = t.Data_in;
    end
  endtask

  task check_observed();
    Trans t;
    forever begin
      mon_mbox.get(t);
      if (t.Valid_out) begin
        bit [31:0] exp = expected_mem[t.Address];
        if (t.Data_out !== exp) begin
          $error("[SCOREBOARD][---FAIL---] Addr = %0d: Expected = %0h, Got = %0h", t.Address, exp, t.Data_out);
        end else begin
          $display("[SCOREBOARD][---PASS---] Addr = %0d: Data matched = %0h", t.Address, t.Data_out);
        end
        -> seq_done_evt;
      end
    end
  endtask

  task start();
    fork
      track_expected();
      check_observed();
    join_none
  endtask
endclass
