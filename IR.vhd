library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity instruction_register  is

    Port (
        clk : in STD_LOGIC;
        IR_in : in STD_LOGIC_VECTOR (16 - 1 downto 0);
        IRld : in STD_LOGIC;
        IR_out : out STD_LOGIC_VECTOR (16 - 1 downto 0)
    );

end instruction_register ;


architecture instruction_registerA of instruction_register  is
signal IRtemp : STD_LOGIC_VECTOR (15 downto 0); begin

    process (clk, IR_in, IRld) begin

        if rising_edge(clk) then
            if IRld = '1' then
                IRtemp <= IR_in;
            end if;
        end if;

    end process;

    IR_out <= IRtemp;

end instruction_registerA;
