class WR_agent extends uvm_agent;
 `uvm_component_utils(WR_agent)
  my_driver drv_inst;
  WR_monitor mon_inst;
  my_sequencer seqr_inst;
  virtual interface intf agent_vif;
  uvm_analysis_port #(my_sequence_item) my_analysis_port; my_sequence_item seq_item_inst;

    function new(string name = "WR_agent" , uvm_component parent = null);
        super.new(name,parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual intf)::get(this, "", "my_vif", agent_vif))
         `uvm_fatal("build_phase", "AGENT - Unable to get config");
        drv_inst = my_driver::type_id::create("drv_inst", this);
        mon_inst = WR_monitor::type_id::create("mon_inst", this);
        seqr_inst = my_sequencer::type_id::create("seqr_inst", this);
        my_analysis_port = new("my_analysis_port", this);
        uvm_config_db#(virtual intf)::set(this, "drv_inst", "my_vif", agent_vif);
        uvm_config_db#(virtual intf)::set(this, "mon_inst", "my_vif", agent_vif);
        $display("WR_agent build");
    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        mon_inst.my_analysis_port.connect(my_analysis_port);
        drv_inst.my_seq_item_port.connect(seqr_inst.my_seq_item_export);
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
        $display("WR_agent run");
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


class RD_agent extends uvm_agent;
 `uvm_component_utils(RD_agent)
  RD_monitor mon_inst;
  virtual interface intf agent_vif;
  uvm_analysis_port #(my_sequence_item) my_analysis_port; my_sequence_item seq_item_inst;

    function new(string name = "RD_agent" , uvm_component parent = null);
        super.new(name,parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual intf)::get(this, "", "my_vif", agent_vif))
         `uvm_fatal("build_phase", "AGENT - Unable to get config");
        mon_inst = RD_monitor::type_id::create("mon_inst", this);
        my_analysis_port = new("my_analysis_port", this);
        uvm_config_db#(virtual intf)::set(this, "mon_inst", "my_vif", agent_vif);
        $display("RD_agent build");
    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        mon_inst.my_analysis_port.connect(my_analysis_port);
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
        $display("RD_agent run");
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