LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY unite_de_traitement_tb IS
END ENTITY unite_de_traitement_tb;

ARCHITECTURE bench OF unite_de_traitement_tb IS

    signal AluOut : std_logic_vector(31 downto 0);
    signal RA, RB, RW : std_logic_vector(3 downto 0);
    signal CLK, Reset, WE : std_logic ;
    signal OP : std_logic_vector(2 downto 0) ;

BEGIN
    UDT : entity work.unite_de_traitement(struct)
        port map (CLK, Reset, RA, RB, RW, WE, OP, AluOut);

    clock : process
    begin
        while (now <= 50 ns)loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    UT : process
    begin

        RA <= "1111" ;
        OP <= "011" ;
        WE <= '1' ;
        RW <= "0001" ;
        wait for 10 ns ;

        RA <= "0001" ;
        RB <= "1111" ;
        OP <= "000" ;
        WE <= '1' ;
        RW <= "0001" ;
        wait for 10 ns ;

        RA <= "0001" ;
        RB <= "1111" ;
        OP <= "000" ;
        WE <= '1' ;
        RW <= "0010" ;
        wait for 10 ns ;

        RA <= "0001" ;
        RB <= "1111" ;
        OP <= "010" ;
        WE <= '1' ;
        RW <= "0011" ;
        wait for 10 ns ;

        RA <= "0111" ;
        RB <= "1111" ;
        OP <= "010" ;
        WE <= '1' ;
        RW <= "0101" ;
        wait for 10 ns ;
        wait;
    end process ;

END ARCHITECTURE bench;
