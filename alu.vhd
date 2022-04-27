library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is

    Port (
        OPr1, OPr2 : in STD_LOGIC_VECTOR (16 - 1 downto 0);
        ALUs : in STD_LOGIC_VECTOR (1 downto 0);
        ALUr : out STD_LOGIC_VECTOR (16 - 1 downto 0);
        ALUz : out STD_LOGIC
    );

end ALU;


architecture ALU_be of ALU is
signal result : STD_LOGIC_VECTOR(16 - 1 downto 0); begin
    
    process(ALUs, Opr1, Opr2) begin
        
        case(ALUs) is
            when "00" => result <= OPr1 + OPr2;
            when "01" => result <= OPr1 - OPr2;
            when "10" => result <= OPr1 or OPr2; 
            when "11" => result <= OPr1 and OPr2; 
            when others => result <= (others => '0');
        end case;
        
    end process;
    
    ALUr <= result;
    ALUz <=  '1' when OPr1 = x"0000" else '0';
    
end ALU_be;