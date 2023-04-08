library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unite_de_traitement is 
port(
    clk   : in std_logic;
    reset : in std_logic;
    RA    : in std_logic_vector(3 downto 0);
    RB    : in std_logic_vector(3 downto 0);
    RW    : in std_logic_vector(3 downto 0);
    WE    : in std_logic;
    OP    : in std_logic_vector(2 downto 0);
    AluOut     : out std_logic_vector(31 downto 0)
);
    
END entity ;


ARCHITECTURE struct OF unite_de_traitement IS
   signal A, B, W : std_logic_vector(31 downto 0);
   signal N, Z, C, V : std_logic;
BEGIN

    AluOut <= W;
    banc_registre : entity work.banc_registre(RTL)
      port map(clk, reset, W, RA, RB, RW, WE, A, B);
 
    UAL: entity work.ual(RTL)
        port map(OP, A, B, W, N, Z, C, V);
       
	
END architecture;
