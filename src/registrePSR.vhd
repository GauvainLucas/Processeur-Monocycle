library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registrePSR is
port (
    clk, reset, we : in std_logic;
    DataIn : in std_logic_vector(3 downto 0);
    DataOut: out std_logic_vector(31 downto 0)
);
end entity;

architecture behavioral of registrePSR is
begin
    process(clk, reset)
    begin
        if (reset = '1') then
            DataOut <= (others => '0');
        elsif (rising_edge(clk)) then
            if (we = '1') then
                DataOut <= x"00000000";
                DataOut(31 downto 28) <= DataIn;
            end if;
        end if;
    end process;
end architecture;
