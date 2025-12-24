class my_sequencer extends uvm_sequencer #(my_sequence_item);;
 `uvm_component_utils(my_sequencer)
  my_sequence_item seq_item_inst;
  uvm_seq_item_pull_imp #(my_sequence_item, my_sequence_item, my_sequencer) my_seq_item_export;

    function new(string name = "my_sequencer" , uvm_component parent = null);
        super.new(name,parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seq_item_inst = my_sequence_item::type_id::create("seq_item_inst");
        my_seq_item_export = new("my_seq_item_export", this);
        $display("my_sequencer build");
    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction
    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
    endfunction
    function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
    endfunction

    task reset_phase(uvm_phase phase);
        super.reset_phase(phase);
    endtask 
    task configure_phase(uvm_phase phase);
        super.configure_phase(phase);
    endtask 
    task shutdown_phase(uvm_phase phase);
        super.shutdown_phase(phase);
    endtask 
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        $display("sequencer run");
    endtask 
    
    function void extract_phase(uvm_phase phase);
        super.extract_phase(phase);
    endfunction
    function void check_phase(uvm_phase phase);
        super.check_phase(phase);
    endfunction
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction
    function void final_phase(uvm_phase phase);
        super.final_phase(phase);
    endfunction
endclass 