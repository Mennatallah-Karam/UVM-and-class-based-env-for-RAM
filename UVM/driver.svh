class my_driver extends uvm_driver #(my_sequence_item);
 `uvm_component_utils(my_driver)
  my_sequence_item seq_item_inst;
  virtual interface intf drv_vif;
  uvm_seq_item_pull_port #(my_sequence_item, my_sequence_item) my_seq_item_port;

    function new(string name = "my_driver" , uvm_component parent = null);
        super.new(name,parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual intf)::get(this, "", "my_vif", drv_vif))
        `uvm_fatal("build_phase", "DRIVER - Unable to get config");
        seq_item_inst = my_sequence_item::type_id::create("seq_item_inst");
        my_seq_item_port = new("my_seq_item_port", this);
        $display("my_driver build");
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
        drv_vif.rst = 1;
         #10;
        drv_vif.rst = 0;
        forever begin
          my_seq_item_port.get_next_item(seq_item_inst);
          @(posedge drv_vif.clk);
          drv_vif.EN <= seq_item_inst.EN;
          drv_vif.Address <= seq_item_inst.Address;
          drv_vif.Data_in <= seq_item_inst.Data_in;
          @(posedge drv_vif.clk); 
          drv_vif.EN <= 0;
          my_seq_item_port.item_done(seq_item_inst);
          $display("driver item done");
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