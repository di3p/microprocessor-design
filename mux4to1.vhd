library IEEE;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all ;


entity mux4to1 is

    PORT (A, B, C, D: in std_logic_vector (16 - 1 downto 0);
        SEL : in std_logic_vector (1 downto 0);
        Z: out std_logic_vector (16 - 1 downto 0));
        
end mux4to1;


architecture mux4to1_behave of mux4to1 is begin

    with SEL select 
        Z <= A when "00",
             B when "01",
             C when "10",
             D when others;
             
end mux4to1_behave;