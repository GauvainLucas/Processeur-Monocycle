LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

entity banc_registre_tb is
end;

architecture TEST of banc_registre_tb is
    signal clk, reset, WE : std_logic;
    signal W              :  std_logic_vector(31 downto 0);
    signal RA, RB, RW     :  std_logic_vector(3 downto 0);
    signal A, B           : std_logic_vector(31 downto 0);
begin

    BR : entity work.banc_registre(RTL)
    port map (
        clk => clk,
        reset => reset,
        WE => WE,
        W => W,
        RA => RA,
        RB => RB,
        RW => RW,
        A => A,
        B => B
    );

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

    process
    begin
        WE <= '1';
        for i in 0 to 15 loop
            RW <= std_logic_vector(to_unsigned(i, 4));
            W <= std_logic_vector(to_unsigned(i, 32));
            wait for 10 ns;
        end loop;

        for i in 0 to 15 loop
            RA <= std_logic_vector(to_unsigned(i, 4));
            RB <= std_logic_vector(to_unsigned(i, 4));
            
            if A /= std_logic_vector(to_unsigned(i, 32)) then
                report "Error A" severity error;
            end if;
            if B /= std_logic_vector(to_unsigned(i, 32)) then
                report "Error B" severity error;
            end if;
            wait for 10 ns;
        end loop;
        wait;
    end process;

end;


