library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux3to1 is
    
    port( 
          A, B, C : in STD_LOGIC_VECTOR(15 downto 0);
          sel : in STD_LOGIC_VECTOR(1 downto 0);
          data_out : out STD_LOGIC_VECTOR(15 downto 0)
    );
    
end mux3to1;

architecture mux3to1_arch of mux3to1 is

begin
    
    with sel select
                data_out <=  A when "00",
                             B when "01",
                             C when others;
    
end mux3to1_arch;