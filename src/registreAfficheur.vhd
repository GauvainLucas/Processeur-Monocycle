library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registreAfficheur is
port (
    clk, reset, we : in std_logic;
    DataIn : in std_logic_vector(31 downto 0);
    DataOut: out std_logic_vector(31 downto 0)
);
end entity;

architecture behavioral of registreAfficheur is
begin
    process(clk, reset, we, DataIn)
    begin
        if (reset = '1') then
            DataOut <= (others => '0');
        elsif (rising_edge(clk)) then
            if (we = '1') then
                dataOut <= DataIn;
            end if;
        end if;
    end process;
end architecture;
