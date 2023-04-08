LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY unite_de_traitement_avance_tb IS
END ENTITY unite_de_traitement_avance_tb;

ARCHITECTURE bench OF unite_de_traitement_avance_tb IS
    signal clk, reset, RegWr, com1, com2, wren, regSel, regAff : std_logic;
    signal OP : std_logic_vector(2 downto 0);
    signal RA, RB, RW : std_logic_vector(3 downto 0);
    signal imm : std_logic_vector(7 downto 0);
    signal afficheur : std_logic_vector(31 downto 0);
    signal flag : std_logic_vector(3 downto 0);
BEGIN
    UDTA : entity work.unite_de_traitement_avance
        port map(
            clk => clk,
            reset => reset,
            RA => RA,
            RB => RB,
            RW => RW,
            WE => RegWr,
            OP => OP,
            com1 => com1,
            com2 => com2,
            regSel => regSel,
            imm => imm,
            wren => wren,
            flag => flag,
            regAff => regAff,
            afficheur => afficheur);

    clock : process
    begin
        while (now <= 90 ns)loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    UTA : Process
    begin

        -- addition de 2 registres
        reset <= '0';
        RegWr <= '1';
        Wren <= '0';
        RegAff <= '1';
        regSel <= '1';
        RA <= "1111";
        RB <= "1111";
        RW <= "0001";
        imm <= "00000001";
        com1 <= '0';
        OP <= "000";
        com2 <= '0';
        wait for 10 ns;

        -- addition d'un registre avec une valeur immédiate
        OP <= "010";
        RA <= "1111";
        imm <= "00000111";
        RW <= "0010";
        com1 <= '1';
        wait for 10 ns;

        -- soustraction de 2 registres
        OP <= "010";
        RA <= "0011";
        RB <= "0010";
        RW <=  "0011";
        com1 <= '0';
        com2 <= '0';
        wait for 10 ns;

        -- soustraction d'un registre avec une valeur immédiate
        OP <= "010";
        RA <= "0011";
        imm <= "00000001";
        RW <= "0100";
        com1 <= '1';
        com2 <= '0';
        wait for 10 ns;

        -- copie de la valeur d'un registre dans un autre
        OP <= "011";
        RA <= "0011";
        RB <= "0010";
        RW <= "0101";
        com1 <= '0';
        com2 <= '0';
        wait for 10 ns;

        -- écriture d'un registre dans la mémoire
        OP <= "011";
        RW <= "0111";
        RA <= "0011";
        RB <= "0010";
        RegWr <= '0';
        com1 <= '0';
        com2 <= '1';
        wren <= '1';
        wait for 10 ns;

        -- lecture d'un registre dans la mémoire
        OP <= "011";
        RA <= "0011";
        RB <= "0010";
        RW <= "1000";
        com1 <= '0';
        com2 <= '1';
        wren <= '0';
        wait;
        
    end process;
end architecture;

