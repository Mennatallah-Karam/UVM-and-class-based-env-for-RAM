class my_subscriber extends uvm_subscriber#(my_sequence_item);
 `uvm_component_utils(my_subscriber)
  my_sequence_item seq_item_inst;
  uvm_analysis_imp #(my_sequence_item, my_subscriber) my_analysis_imp;

    function new(string name = "my_subscriber" , uvm_component parent = null);
        super.new(name,parent);
    endfunction 

    function void write(my_sequence_item t);
        seq_item_inst = t;
        //$display("my_subscriber write");
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seq_item_inst = my_sequence_item::type_id::create("seq_item_inst");
        my_analysis_imp = new("my_analysis_imp", this);
        $display("my_subscriber build");
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
        $display("my_subscriber run");
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
