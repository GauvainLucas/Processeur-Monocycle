LIBRARY ieee;
USE ieee.std_logic_1164.all; 
use IEEE.numeric_std.ALL;

ENTITY top_level is
	PORT
	(
		CLOCK_50 	    :  IN  STD_LOGIC;
		KEY			 	:  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		SW 				:  IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
		HEX0 			:  OUT  STD_LOGIC_VECTOR(0 TO 6);
		HEX1 			:  OUT  STD_LOGIC_VECTOR(0 TO 6);
		HEX2 			:  OUT  STD_LOGIC_VECTOR(0 TO 6);
		HEX3 			:  OUT  STD_LOGIC_VECTOR(0 TO 6)
	);
END entity;

ARCHITECTURE RTL OF top_level IS 
	signal rst, clk, pol, irq0, irq1: std_logic;
    signal afficheur : std_logic_vector(31 downto 0);
BEGIN 
 
rst <= SW(0);
clk <= CLOCK_50; 
pol <= SW(9);
irq0 <= KEY(0);
irq1 <= KEY(1);


Processeur : entity work.processeur(struct)
    port map(clk, rst, irq0, irq1, afficheur);

SEVEN_SEG1: entity work.Sept_Segments(COMB)
	port map(afficheur(3 downto 0), pol, HEX0);

SEVEN_SEG2: entity work.Sept_Segments(COMB)
	port map(afficheur(7 downto 4), pol, HEX1);

SEVEN_SEG3: entity work.Sept_Segments(COMB)
	port map(afficheur(11 downto 8), pol, HEX2);

SEVEN_SEG4: entity work.Sept_Segments(COMB)
	port map(afficheur(15 downto 12), pol, HEX3);

END architecture;