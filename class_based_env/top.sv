module tb;
import pack::*;
  bit clk;
  mem_if memif(clk);
  Memory dut(.mem(memif.DUT));
  Env env;

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    env = new(memif.TEST);
    memif.rst = 1;
    #10;
    memif.rst = 0;
    env.run();
    $finish;
  end
endmodule
