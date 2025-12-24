class my_test extends uvm_test;
 `uvm_component_utils(my_test)
  my_env env;
  write_sequence_1 write_seq_1;
  write_sequence_2 write_seq_2;
  read_sequence_1 read_seq_1;
  read_sequence_2 read_seq_2;

  virtual interface intf config_virtual;
    function new(string name = "my_test" , uvm_component parent = null);
        super.new(name,parent);
    endfunction  

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = my_env::type_id::create("env",this);
        write_seq_1 = write_sequence_1::type_id::create("write_seq_1");
        write_seq_2 = write_sequence_2::type_id::create("write_seq_2");
        read_seq_1 = read_sequence_1::type_id::create("read_seq_1");
        read_seq_2 = read_sequence_2::type_id::create("read_seq_2");
        if (!uvm_config_db#(virtual intf)::get(this, "", "my_vif", config_virtual))
                    `uvm_fatal("build_phase", "TEST - Unable to get config");

            uvm_config_db#(virtual intf)::set(this, "env.wr_agent_inst", "my_vif", config_virtual);
            uvm_config_db#(virtual intf)::set(this, "env.rd_agent_inst", "my_vif", config_virtual);
        $display("my_test build");
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
        fork
        phase.raise_objection(this);
        write_seq_1.start(env.wr_agent_inst.seqr_inst); 
        write_seq_2.start(env.wr_agent_inst.seqr_inst);
        read_seq_1.start(env.wr_agent_inst.seqr_inst);
        read_seq_2.start(env.wr_agent_inst.seqr_inst);   
        join
        
        phase.drop_objection(this);
        $display("my_test run");
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