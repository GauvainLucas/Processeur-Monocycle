library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is 
port(
    clk    : in std_logic;
    reset  : in std_logic;
    we     : in std_logic;
    datain : in std_logic_vector(31 downto 0);
    addr   : in std_logic_vector(5 downto 0);
    dataout: out std_logic_vector(31 downto 0)
);

end data_memory;

ARCHITECTURE behavioral OF data_memory IS
        TYPE memory IS ARRAY (0 TO 63) OF std_logic_vector(31 downto 0);
        
-- Fonction d'Initialisation du Banc de Registres
function init_banc return memory is
variable result : memory;
begin
    for i in 62 downto 0 loop
        result(i) := std_logic_vector(to_unsigned(i, 32));
    end loop;
    result(63) := X"00000030";
    return result;
end init_banc;

-- Déclaration et Initialisation du Banc de Registres 16x32 bits
signal Banc: memory := init_banc;

BEGIN
    process(clk, reset)
    begin
        if reset = '1' then
            banc <= init_banc;
        elsif rising_edge(clk) then
            if we = '1' then
                banc(to_integer(unsigned(addr))) <= datain;
            end if;
        end if;
    end process;
dataout <= banc(to_integer(unsigned(addr)));
END behavioral;


