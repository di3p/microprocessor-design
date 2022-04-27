library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cpu is
   port ( 
            Reset : in std_logic;          
            clk   : in std_logic 
        );
end cpu;

architecture cpu_behave of cpu is
          signal data_memory_irD_muxdatapath : STD_LOGIC_VECTOR(15 downto 0);
          signal RFs : STD_LOGIC_VECTOR(1 downto 0);
          signal RFwa, OPr1a, OPr2a : STD_LOGIC_VECTOR(3 downto 0);
          signal RFwe, OPr1e, OPr2e : STD_LOGIC;
          signal ALUs : STD_LOGIC_VECTOR(1 downto 0);
          signal ALUz : STD_LOGIC;
          signal Addr_out : STD_LOGIC_VECTOR(15 downto 0);
          signal  data_out : STD_LOGIC_VECTOR(15 downto 0); 
          signal Mre : STD_LOGIC;
          signal Mwe : STD_LOGIC;
          signal Instr_in : STD_LOGIC_VECTOR(15 downto 0);
          signal IRld, PCincr, PCclr, PCld: STD_LOGIC;
          signal memory_select : STD_LOGIC_VECTOR(1 downto 0);
          signal PC_out : STD_LOGIC_VECTOR(15 downto 0);
          signal PCinD : STD_LOGIC_VECTOR(15 downto 0);
          signal addr_out_of_mux_to_mem : STD_LOGIC_VECTOR (15 downto 0);
          signal Instr_in_7_downto_0: std_logic_vector(15 downto 0);
          signal ignore: std_logic_vector(15 downto 0);
begin
  
      Instr_in_7_downto_0 <= "00000000" & Instr_in(7 downto 0);
      PCinD <= "00000000" & Instr_in(7 downto 0);	
programcounter: entity work.PC port map (clk, PCclr, PCincr, PCld, PCinD, PC_out);

controllerunit: entity work.controller port map (reset, clk, ALUz, Instr_in, RFs, RFwa, RFwe, OPr1a, OPr1e, OPr2a,
                                                OPr2e, ALUs, IRld, PCincr, PCclr, PCld, memory_select, Mre, Mwe);

ir_unit: entity work.store_instruction port map (clk, data_memory_irD_muxdatapath, IRld, INSTR_in);

mux4to1unit: entity work.mux3to1 port map (Addr_out, Instr_in_7_downto_0, PC_out, memory_select, addr_out_of_mux_to_mem);

datapath_unit: entity work.datapath 
                  port map (reset, clk, INSTR_in, data_memory_irD_muxdatapath, RFs, RFwa, OPr1a, OPR2a, RFwe,
                        OPr1e, OPr2e, ALUs, ALUz, Addr_out, data_out);

mem_unit: entity work.dpmem port map (clk, reset, addr_out_of_mux_to_mem, Mwe, data_out, Mre, data_memory_irD_muxdatapath);

			

end cpu_behave;




