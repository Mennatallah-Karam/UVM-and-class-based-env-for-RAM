class Sequencer;
  mailbox #(Trans) seq_mbox;
  event seq_done_evt;
  event done_event;

  function new(event done_event);
    seq_mbox = new(1);
    this.done_event = done_event;
  endfunction

  task start(mailbox #(Trans) exp_mbox);
    Trans t;
    for (int i = 0; i < 100; i++) begin
      t = new();
      assert(t.randomize());
      t.EN = 1;
      $display("[SEQUENCER] Generated transaction no. [%0d]: Addr=%0d, Data_in=%0h", i+1, t.Address, t.Data_in);
      seq_mbox.put(t);
      exp_mbox.put(t);
      @seq_done_evt;
      $display("=================================================================================================");
    end
    $display("TEST FINISHED");
    -> done_event; 
  endtask
endclass
