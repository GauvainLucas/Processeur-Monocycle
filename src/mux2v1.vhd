library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mux2v1 is 
generic(
    N : positive := 32
);
port(
    A     : in std_logic_vector(N-1 downto 0);
    B     : in std_logic_vector(N-1 downto 0);
    COM   : in std_logic;
    S     : out std_logic_vector(N-1 downto 0)
);
end entity;

ARCHITECTURE behavioral OF Mux2v1 IS
BEGIN
    S <= A when COM = '0' else B;
END behavioral;


