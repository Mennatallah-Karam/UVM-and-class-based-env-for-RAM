module top;
import uvm_pkg::*;
import pack1::*;

bit clk;
intf in1(clk);
Memory dut(.mem(in1.DUT));

initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end 

initial begin
    uvm_config_db#(virtual intf)::set(null,"uvm_test_top", "my_vif", in1);
    run_test("my_test");
end
endmodule