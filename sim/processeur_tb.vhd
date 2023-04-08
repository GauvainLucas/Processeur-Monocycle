LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY processeur_tb IS
END ENTITY processeur_tb;

ARCHITECTURE bench OF processeur_tb IS
signal clk : std_logic;
signal reset : std_logic := '1';
signal afficheur : std_logic_vector(31 downto 0);
BEGIN
    processeur : entity work.processeur
        port map(
            clk => clk,
            reset => reset,
            afficheur => afficheur
        );
       

    clock : process
    begin
        reset <= '0';
        while (now <= 10 us)loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;
end architecture;

