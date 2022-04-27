library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;
 
entity dpmem_tb is

end dpmem_tb;

architecture behavior of dpmem_tb is

  Constant   CLKTIME   :       time      := 20 ns;
  

  signal clk :       std_logic := '0';
  signal Reset :      std_logic := '0';
  
  signal addr : std_logic_vector( 15 downto 0);
  signal  wen  :       std_logic;
  signal  datain :  std_logic_vector(15 downto 0);
  
  signal  ren :       std_logic;
 
  signal dataout :   std_logic_vector(15 downto 0);

begin
   

   
-- Clock generation
  
  clk <= not clk after CLKTIME/2;
   
-- UUT componenet
  dut:  entity work.dpmem    
    port map (
       
      clk      => clk,
      Reset   => Reset,
      addr     => addr,
      Wen       => wen,
      Datain    => datain,
      
      Ren       => ren,
      
      Dataout   => dataout
      
      );
   
 
-- Read process

  stimuli_proc :  process
  Begin
      -- Reset generation
  
        Reset  <= '1'; REn <= '0'; WEn <= '0'; Addr <= (OTHERS => '0');
        wait for  50 ns;                                         
        Reset  <= '0';
        wait for  10 ns;
        
        Ren <= '1'; -- read enable at address 0
        wait for  20 ns;  Ren <= '0';  wait for  10 ns;
        Addr <= X"0001";  Ren <= '1'; -- read enable at address 1
        wait for  20 ns;  Ren <= '0';  wait for  10 ns;
        
        Addr <= X"0000";  Datain <= X"000E"; Wen <= '1'; -- write enable at address 0
        wait for  20 ns;  Wen <= '0';  wait for  10 ns;
        Addr <= X"0001";  Datain <= X"000F"; Wen <= '1'; -- write enable at address 1
        wait for  20 ns;  Wen <= '0';  wait for  10 ns;
        
        Addr <= X"0000"; Ren <= '1'; -- read enable at address 0
        wait for  20 ns;  Ren <= '0';  wait for  10 ns;
        Addr <= X"0001";  Ren <= '1'; -- read enable at address 1
        wait for  20 ns;  Ren <= '0';  wait for  10 ns;  
        Addr <= X"0002"; Ren <= '1'; -- read enable at address 2
        wait for  20 ns;  Ren <= '0';  wait for  10 ns;
        Addr <= X"0003";  Ren <= '1'; -- read enable at address 3
        wait for  20 ns;  Ren <= '0';  wait for  10 ns; 
  end process stimuli_proc;
   
 

end behavior;