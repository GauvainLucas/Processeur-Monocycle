library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registrePC is
port (
    clk, reset : in std_logic;
    E : in std_logic_vector(31 downto 0);
    S: out std_logic_vector(31 downto 0)
);
end entity;

architecture behavioral of registrePC is
begin
    process(clk, reset)
    begin
        if (reset = '1') then
            S <= (others => '0');
        elsif (rising_edge(clk)) then
            S <= E;
        end if;
    end process;
end architecture;
