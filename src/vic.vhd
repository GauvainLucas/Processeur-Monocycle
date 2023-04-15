library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity VIC is
    Port ( CLK      : in STD_LOGIC;
           RESET    : in STD_LOGIC;
           IRQ_SERV : in STD_LOGIC;
           IRQ0     : in STD_LOGIC;
           IRQ1     : in STD_LOGIC;
           IRQ      : out STD_LOGIC;
           VICPC    : out STD_LOGIC_VECTOR (31 downto 0));
end VIC;

architecture Behavioral of VIC is
    signal IRQ0_memo : STD_LOGIC := '0';
    signal IRQ1_memo : STD_LOGIC := '0';
    signal IRQ0_prev : STD_LOGIC := '0';
    signal IRQ1_prev : STD_LOGIC := '0';
begin
    process (CLK, RESET)
    begin
        if RESET = '1' then
            IRQ <= '0';
            VICPC <= (others => '0');
            IRQ0_memo <= '0';
            IRQ1_memo <= '0';
            IRQ0_prev <= '0';
            IRQ1_prev <= '0';
        elsif rising_edge(CLK) then
            if IRQ0 = '1' and IRQ0_prev = '0' then
                IRQ0_memo <= '1';
            else
                IRQ0_memo <= '0';
            end if;

            if IRQ1 = '1' and IRQ1_prev = '0' then
                IRQ1_memo <= '1';
            else
                IRQ1_memo <= '0';
            end if;

            if IRQ_SERV = '1' then
                IRQ0_memo <= '0';
                IRQ1_memo <= '0';
            end if;

            if IRQ0_memo = '1' then
                VICPC <= x"00000009"; 
            elsif IRQ1_memo = '1' then
                VICPC <= x"00000015"; 
            else
                VICPC <= (others => '0');
            end if;

            IRQ <= IRQ0_memo or IRQ1_memo;
            IRQ0_prev <= IRQ0;
            IRQ1_prev <= IRQ1;
        end if;
    end process;
end Behavioral;