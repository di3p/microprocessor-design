library IEEE;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity program_counter is
    Port ( 
        clk : in STD_LOGIC;
        PCclr : in STD_LOGIC;
        PCincr : in STD_LOGIC;
        PCld : in STD_LOGIC;
        PC_in : in STD_LOGIC_VECTOR (15 downto 0);
        PC_out : buffer STD_LOGIC_VECTOR (15 downto 0)
    );
end program_counter ;


architecture program_counterA of program_counter is begin

    process(clk) begin
       if PCclr = '1' then
            PC_out <= x"0000";
            elsif rising_edge(clk) then


            if PCld = '1' then
                PC_out <= PC_in;


            elsif PCincr = '1' then
                PC_out <= PC_out + 1; 
            end if;

        end if;

    end process;

end program_counterA;