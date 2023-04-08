library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processeur is 
port(
    clk: in std_logic;
    reset: in std_logic;
    Afficheur: out std_logic_vector(31 downto 0)
);
END entity ;


ARCHITECTURE struct OF processeur IS
    signal RegWr, AluSrc, WrSrc, RegSel, MemWr, nPCSel, regAff, PSREn: std_logic;
    signal Aluctr : std_logic_vector(2 downto 0);
    signal flagIn, RA, RB, RW : std_logic_vector(3 downto 0);
    signal Imm8 : std_logic_vector(7 downto 0);
    signal Imm24 : std_logic_vector(23 downto 0);
    signal instruction, flagOut : std_logic_vector(31 downto 0);
BEGIN

    RW <= instruction(15 downto 12);
    RA <= instruction(19 downto 16);
    RB <= instruction(3 downto 0);

    UTA : entity work.unite_de_traitement_avance(struct)
        port map(clk, reset, RA, RB, RW, RegWr, Aluctr, AluSrc, WrSrc, regSel, Imm8, MemWr,RegAff, flagIn, Afficheur);
    
    UGI : entity work.unite_de_gestion_des_instructions(struct)
        port map(clk, reset, nPCSel, Imm24, instruction);

    Decodeur: entity work.decod_instruction(behavioral)
        port map(instruction, flagOut, nPCSel, RegWr, ALUSrc, PSREn, MemWr, WrSrc, RegSel, RegAff, Aluctr, Imm24, Imm8);

    PSR : entity work.registrePSR(behavioral)
        port map(clk, reset, PSREn, flagIn, flagOut);
    
END architecture;