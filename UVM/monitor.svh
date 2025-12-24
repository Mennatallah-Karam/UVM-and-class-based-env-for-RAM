class WR_monitor extends uvm_monitor;
 `uvm_component_utils(WR_monitor)
  my_sequence_item seq_item_inst;
  virtual interface intf mon_vif;

    uvm_analysis_port #(my_sequence_item) my_analysis_port; 
    function new(string name = "WR_monitor" , uvm_component parent = null);
        super.new(name,parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual intf)::get(this, "", "my_vif", mon_vif))
            `uvm_fatal("build_phase", "MONITOR - Unable to get config");
        seq_item_inst = my_sequence_item::type_id::create("seq_item_inst");
        my_analysis_port = new("my_analysis_port", this);
        $display("WR_monitor build");
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
    forever begin
       // phase.raise_objection(this);    
      @(negedge mon_vif.clk);
      if (mon_vif.EN) begin
        seq_item_inst.EN         = mon_vif.EN;
        seq_item_inst.Address    = mon_vif.Address;
        seq_item_inst.Data_in    = mon_vif.Data_in; 
        $display("[WR_MON] Write: Addr = %0d, Data = %0h", seq_item_inst.Address, seq_item_inst.Data_in);
        my_analysis_port.write(seq_item_inst);
      //phase.drop_objection(this);
      end 
    end
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


class RD_monitor extends uvm_monitor;
 `uvm_component_utils(RD_monitor)
  my_sequence_item seq_item_inst;
  virtual interface intf mon_vif;

    uvm_analysis_port #(my_sequence_item) my_analysis_port; 
    function new(string name = "RD_monitor" , uvm_component parent = null);
        super.new(name,parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual intf)::get(this, "", "my_vif", mon_vif))
            `uvm_fatal("build_phase", "MONITOR - Unable to get config");
        seq_item_inst = my_sequence_item::type_id::create("seq_item_inst");
        my_analysis_port = new("my_analysis_port", this);
        $display("RD_monitor build");
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
    
    forever begin
       // phase.raise_objection(this);    
      @(negedge mon_vif.clk);
      if (!mon_vif.EN && mon_vif.Valid_out) begin
        seq_item_inst.Address    = mon_vif.Address;
        seq_item_inst.Data_out   = mon_vif.Data_out;
        seq_item_inst.Valid_out  = mon_vif.Valid_out;
        $display("[RD_MON] read: Addr=%0d, Data_out=%0h", mon_vif.Address, mon_vif.Data_out);
        my_analysis_port.write(seq_item_inst);
      end
      //phase.drop_objection(this);
    end
    
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