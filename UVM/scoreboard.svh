class my_scoreboard extends uvm_scoreboard;
 `uvm_component_utils(my_scoreboard)
  my_sequence_item seq_item_inst;
  uvm_analysis_imp #(my_sequence_item, my_scoreboard) my_analysis_imp;
  bit [31:0] ref_mem [0:15]; 
  int error_count = 0;

    function new(string name = "my_scoreboard" , uvm_component parent = null);
        super.new(name,parent);
    endfunction  

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seq_item_inst = my_sequence_item::type_id::create("seq_item_inst");
        my_analysis_imp = new("my_analysis_imp", this);
        foreach (ref_mem[i])
            ref_mem[i] = 32'h0;
        $display("my_scoreboard build");
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
        $display("my_scoreboard run");
    endtask 
    
    function void extract_phase(uvm_phase phase);
        super.extract_phase(phase);
    endfunction
    function void check_phase(uvm_phase phase);
        super.check_phase(phase);
    endfunction
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        if (error_count == 0)
      `uvm_info("SB", "All transactions passed!", UVM_NONE)
         else
      `uvm_error("SB", $sformatf("There were %0d mismatches", error_count))
    endfunction
    function void final_phase(uvm_phase phase);
        super.final_phase(phase);
    endfunction
    
    function void write(my_sequence_item t);
        //$display("my_scoreboard write");
        if (t.EN) begin
        ref_mem[t.Address] = t.Data_in;
        `uvm_info("SB", $sformatf("WRITE: Addr=%0d, Data_in=%0h", t.Address, t.Data_in), UVM_LOW)
        end else begin
         bit [31:0] expected = ref_mem[t.Address];
         bit [31:0] actual   = t.Data_out;

        if (actual !== expected) begin
            error_count++;
            `uvm_error("SB", $sformatf("READ [MISMATCH] at Addr=%0d: Expected=%0h, Got=%0h",
                                    t.Address, expected, actual))
        end else begin
         `uvm_info("SB", $sformatf("READ [PASS] at Addr=%0d: Data_out=%0h",
                                   t.Address, actual), UVM_LOW)
        end
        end
    endfunction
endclass 