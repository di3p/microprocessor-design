library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dpmem is
  
  port (
    
    Clk              : in  std_logic;          
	  Reset             : in  std_logic; 
    addr              : in  std_logic_vector(15 downto 0);   
	
	  Wen               : in  std_logic;          
    Datain            : in  std_logic_vector(15 downto 0) := (others => '0');   -- Input Data: Initialize to 0
    
    
    Ren               : in  std_logic;          
    Dataout           : buffer std_logic_vector(15 downto 0)   
    
    );
end dpmem;
 



architecture dpmem_arch of dpmem is
   
  type DATA_ARRAY is array (integer range <>) of std_logic_vector(15 downto 0); 

  signal   M       :     DATA_ARRAY(0 to 50) := (others => (others => '0')); 

  constant PM_Size : Integer := 14; -- Size of program memory :(range 255 downto 0 )

  constant PM : DATA_ARRAY(0 to PM_Size-1) := (	


    -- 

    X"0011",	-- 	RF[0] = M[17] = 4 		mov1 	        		0   
    X"1014",	-- 	M[20] = RF[0] = 4 		mov2 				1   
    X"2030",    -- 	M[RF[3]] = RF[0] = 4 		mov3     			2
    X"3218",    -- 	RF[2] = 24  			mov4                  		3
	
    X"4200",    -- 	RF[2] = RF[2] + RF[0]         	add    				4

    X"3403",    --  	RF[4] = 3               					5
    X"3507",    --  	RF[5] = 7                  					6
    X"5540",    -- 	RF[5] = RF[5] - RF[4]  = 4  	sub            			7
	
    X"7450",    -- 	RF[4] = RF[4] OR RF[5] 		or				8
    X"8540",    -- 	RF[5] = RF[5] AND RF[4]        	and				9
    
    X"690C",    -- 	neu R6 = 0 thi di chuyen den cau lenh 17 			10



    X"3605",    --  	RF[6] = 5							11
    X"3705",   	--  	RF[7] = 5							12
    X"A00B" 	--      nhay ve lenh 11

    );
begin 

  RW_Proc : process (clk, Reset)
  begin  
    if Reset = '1' then

                    Dataout <= (others => '0');
                    M(0 to PM_Size-1) <= PM; 
		    M(20) <= (x"0001");
		    M(21) <= (x"0002");
                    M(17 to 19) <= (x"0004", x"0005", x"0006");

    elsif (clk'event and clk = '1') then   
          if Wen = '1' then
                          M(conv_integer(addr)) <= Datain; 
          else
              if Ren = '1' then
                    Dataout <= M(conv_integer(addr));
              else
                    Dataout <= Dataout;
              end if;
          end if;
      end if;
  end process  RW_Proc;
     
end dpmem_arch;