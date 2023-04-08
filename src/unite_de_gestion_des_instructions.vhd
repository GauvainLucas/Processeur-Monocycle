library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unite_de_gestion_des_instructions is 
port(
    clk : in std_logic;
    reset : in std_logic;
    nPCsel : in std_logic;
    offset : in std_logic_vector(23 downto 0);
    instruction : out std_logic_vector(31 downto 0)
);
end entity;

ARCHITECTURE struct OF unite_de_gestion_des_instructions IS
   signal sPC, sMux, sExtend, sPlusUn , sPlus : std_logic_vector(31 downto 0);
   
BEGIN
    sPlusUn <= std_logic_vector(unsigned(sPC) + to_unsigned(1, 32));
    sPlus <= std_logic_vector(unsigned(sExtend) + unsigned(sPlusUn));

    PC_Extend : entity work.sign_extend(behavioral)
        generic map(24)
        port map(offset, sExtend);
    
    PC : entity work.registrePC(behavioral)
        port map(clk, reset, sMux, sPC);

    Mux : entity work.mux2v1(behavioral)
        generic map(32)
        port map(sPlusUn, sPlus, nPCsel, sMux);

    instr : entity work.instruction_memory(RTL)
        port map(SPc, instruction);
	
END architecture;
