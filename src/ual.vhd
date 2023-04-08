library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ual is
port (
	OP         : in std_logic_vector(2 downto 0);
    A, B       : in std_logic_vector(31 downto 0);
    S          : out std_logic_vector(31 downto 0);
    N, Z, C, V : out std_logic);
end entity;

architecture RTL of ual is
    signal y : signed(32 downto 0);
    signal A_temp, B_temp : signed(32 downto 0);
begin
    A_temp <= resize(signed(A), y'length);
    B_temp <= resize(signed(B), y'length);
    with OP select
        y <= A_temp + B_temp    when "000",
             B_temp             when "001",
             A_temp - B_temp    when "010",
             A_temp             when "011",
             A_temp or B_temp   when "100",
             A_temp and B_temp  when "101",
             A_temp xor B_temp  when "110",
             A_temp nand B_temp when "111",
             (others => '-')    when others;

    S <= std_logic_vector(y(31 downto 0));
    N <= y(31);
    Z <= '1' when y(31 downto 0) = x"00000000" else '0';
    C <= y(32);
    V <= '1' when (A(31) = B(31)) and (A(31) /= y(31)) else '0';

end architecture;
