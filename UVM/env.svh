class my_env extends uvm_env;
 `uvm_component_utils(my_env)
  WR_agent wr_agent_inst;
  RD_agent rd_agent_inst;
  my_subscriber sub_inst;
  my_scoreboard sb_inst;
    function new(string name = "my_env" , uvm_component parent = null);
        super.new(name,parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        wr_agent_inst = WR_agent::type_id::create("wr_agent_inst",this);
        rd_agent_inst = RD_agent::type_id::create("rd_agent_inst",this);
        sub_inst = my_subscriber::type_id::create("sub_inst",this);
        sb_inst = my_scoreboard::type_id::create("sb_inst",this);
        $display("my_env build");
    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        wr_agent_inst.my_analysis_port.connect(sb_inst.my_analysis_imp);
        wr_agent_inst.my_analysis_port.connect(sub_inst.my_analysis_imp);
        rd_agent_inst.my_analysis_port.connect(sb_inst.my_analysis_imp);
        rd_agent_inst.my_analysis_port.connect(sub_inst.my_analysis_imp);
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
        $display("my_env run");
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