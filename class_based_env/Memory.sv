module Memory #(parameter ADDR_WIDTH = 4, ADDR_DEPTH = 16, DATA_WIDTH = 32)
(
    mem_if.DUT mem
);
    reg [DATA_WIDTH-1:0] mem_array [0:ADDR_DEPTH-1];
    integer i;

    always @(posedge mem.clk) begin
        if (mem.rst) begin
            for (i = 0; i < ADDR_DEPTH; i = i + 1)
                mem_array[i] <= 0;
            mem.Data_out <= 0;
            mem.Valid_out <= 0;
        end else begin
            if (mem.EN) begin
                mem_array[mem.Address] <= mem.Data_in;
            end
            mem.Data_out <= mem_array[mem.Address];
            mem.Valid_out <= ~mem.EN;
        end
    end
endmodule
