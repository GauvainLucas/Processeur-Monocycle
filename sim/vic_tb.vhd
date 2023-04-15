LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY vic_tb IS
END ENTITY vic_tb;

ARCHITECTURE bench OF vic_tb IS
   signal clk, reset, irq_serv, irq0, irq1, irq: std_logic;
   signal vicpc : std_logic_vector(31 downto 0);
BEGIN
    VIC : entity work.vic
    port map(clk, reset, irq_serv, irq0, irq1, irq, vicpc);

    clock : process
    begin
        while (now <= 300 ns)loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    test : Process
    begin
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;
        irq_serv <= '0';
        irq0 <= '0';
        irq1 <= '0';
        wait for 10 ns;
        irq_serv <= '1';
        irq0 <= '1';
        irq1 <= '0';
        wait for 10 ns;
        irq_serv <= '1';
        irq0 <= '0';
        irq1 <= '1';
        wait for 10 ns;
        irq_serv <= '0';
        irq0 <= '1';
        irq1 <= '1';
        wait for 10 ns;
        irq_serv <= '1';
        irq0 <= '1';
        irq1 <= '0';
        wait for 10 ns;
        irq_serv <= '0';
        irq0 <= '0';
        irq1 <= '1';
        wait for 10 ns;
        irq_serv <= '1';
        irq0 <= '1';
        irq1 <= '1';
        wait for 10 ns;
        wait;
    end process;
end architecture;

