library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend is 
    generic
    (
        N : integer := 8
    );
    port(
        E : in std_logic_vector(N-1 downto 0);
        S : out std_logic_vector(31 downto 0)
    );
end sign_extend;

ARCHITECTURE behavioral OF sign_extend IS
BEGIN
    process(E)
    begin
        if E(N-1) = '1' then
            S <= (others => '1');
        else
            S <= (others => '0');
        end if;
        S(N-1 downto 0) <= E;
    end process;
END behavioral;


