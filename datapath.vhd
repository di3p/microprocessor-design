library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity datapath is
    Port(
          reset : in STD_LOGIC;
          clk: in STD_LOGIC;
          data_in1 : in STD_LOGIC_VECTOR(15 downto 0);
          data_in2 : in STD_LOGIC_VECTOR(15 downto 0);
          RFs : in STD_LOGIC_VECTOR(1 downto 0);
          RFwa, OPr1a, OPr2a : in STD_LOGIC_VECTOR(3 downto 0);
          RFwe, OPr1e, OPr2e : in STD_LOGIC;
          ALUs : in STD_LOGIC_VECTOR(1 downto 0);
          ALUz : out STD_LOGIC;
          Addr_out : out STD_LOGIC_VECTOR(15 downto 0);
          data_out : out STD_LOGIC_VECTOR(15 downto 0)
        );
end datapath;

architecture datapath_arch of datapath is
    signal OPr1, OPr2 : STD_LOGIC_VECTOR(15 downto 0);
    signal RFin : STD_LOGIC_VECTOR(15 downto 0);
    Signal data_in0 :  STD_LOGIC_VECTOR(15 downto 0);
    signal port1_of_mux : STD_LOGIC_VECTOR(15 downto 0);
    signal ignore: STD_LOGIC_VECTOR(15 downto 0);
begin
    port1_of_mux <= "00000000" & data_in1(7 downto 0);
    MUX_U : entity work.mux3to1
    port map(data_in0, port1_of_mux, data_in2, RFs, RFin);
    RF_U : entity work.array_rf
    port map(
          clk => clk,
          reset => reset,
          RFin => RFin,
          RFwa => RFwa,
          RFwe => RFwe,
          OPr1a => OPr1a,
          OPr1e => OPr1e,
          OPr2a => OPr2a,
          OPr2e => OPr2e,
          OPr1 => OPr1,
          OPr2 => OPr2
        );
        Addr_out <= OPr2;
     Data_out <= OPR1;
   
     ALU_U: entity  work.ALU
    port map( OPr1 => OPr1,
            OPr2 => OPr2,
            ALUs => ALUs,
            ALUr => data_in0,
            ALUz => ALUz
            );
end datapath_arch;