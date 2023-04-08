library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unite_de_traitement_avance is 
port(
    clk   : in std_logic;
    reset : in std_logic;
    RA    : in std_logic_vector(3 downto 0);
    RB    : in std_logic_vector(3 downto 0);
    RW    : in std_logic_vector(3 downto 0);
    WE    : in std_logic;
    OP    : in std_logic_vector(2 downto 0);
    Com1  : in std_logic;
    Com2  : in std_logic;
    regSel: in std_logic;
    Imm   : in std_logic_vector(7 downto 0);
    WrEN  : in std_logic;
    regAff: in std_logic;
    flag  : out std_logic_vector(3 downto 0);
    Afficheur : out std_logic_vector(31 downto 0)
);
    
END entity ;


ARCHITECTURE struct OF unite_de_traitement_avance IS
   signal A, B, W, AluOut, DataOut, vExtend, sMux1 : std_logic_vector(31 downto 0);
   signal sMuxRb : std_logic_vector(3 downto 0);
BEGIN
    

    banc_registre : entity work.banc_registre(RTL)
      port map(clk, reset, W, RA, sMuxRb, RW, WE, A, B);

    Extender :entity work.sign_extend(behavioral)
        generic map(8)
        port map(Imm, vExtend);
    
    Mux1 : entity work.mux2v1(behavioral)
        generic map(32)
        port map(B, vExtend, Com1, sMux1);
    
    MUXRb : entity work.mux2v1(behavioral)
        generic map(4)
        port map(RB, RW, regSel, sMuxRb);
 
    UAL: entity work.ual(RTL)
        port map(OP, A, sMux1, AluOut, flag(3), flag(2), flag(1), flag(0));

    DataMemory : entity work.data_memory(behavioral)
        port map(clk, reset, WrEN, B, AluOut(5 downto 0), dataout);
    
    Mux2 : entity work.mux2v1(behavioral)
        generic map(32)
        port map(AluOut, DataOut, Com2, W);
    
    Aff : entity work.registreAfficheur(behavioral)
        port map(clk, reset, regAff, B, Afficheur);
END architecture;
