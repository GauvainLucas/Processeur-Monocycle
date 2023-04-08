LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

entity tb_ual is
end;

architecture TEST of tb_ual is

    signal OP         : std_logic_vector(2 downto 0);
    signal A, B       : std_logic_vector(31 downto 0);
    signal S          : std_logic_vector(31 downto 0);
    signal N, Z, C, V :  std_logic;
begin

UAL : entity work.ual(RTL)
port map (
    OP => OP,
    A  => A,
    B  => B,
    S  => S,
    N  => N,
    Z  => Z,
    C  => C,
    V  => V
);

process
begin
    OP <= "000"; 
    A <= (others => '0');
    B <= x"00000001";
    wait for 10 ns;
    assert (S /= x"00000001")
        report "Error: S /= x00000001" severity error;
   
    OP <= "001"; 
    A <= (others => '0');
    B <= x"00000001";   
    wait for 10 ns;
    assert (S /= x"00000001")
        report "Error: S /= x00000001" severity error;
    
    OP <= "010";
    A <= x"0000000C";
    B <= x"0000000A";  
    wait for 10 ns;
    assert(S = x"00000002")
        report "Error: S /= x00000002" severity error;

    OP <= "011";
    A <= x"0000000A";
    B <= x"0000000B";
    wait for 10 ns;
    assert (S = x"0000000A")
        report "Error: S /= x0000000A" severity error;

    OP <= "100";
    A <= x"0000000A";
    B <= x"0000000B";
    wait for 10 ns;
    assert (S = (x"0000000A" or x"0000000B") )
        report "Error: S /= x0000000A or x0000000B" severity error;

    OP <= "101";
    A <= x"0000000A";
    B <= x"0000000B";
    wait for 10 ns;
    assert(S = (x"0000000A" and x"0000000B") ) 
        report "Error: S /= x0000000A and x0000000B" severity error;

    OP <= "110";
    A <= x"0000000A";
    B <= x"0000000B";
    wait for 10 ns;
    assert(S = (x"0000000A" xor x"0000000B") )
        report "Error: S /= x0000000A xor x0000000B" severity error;
  

    OP <= "111";
    A <= x"0000000A";
    B <= x"0000000B";
    wait for 10 ns;
    assert (S = (x"0000000A" nand x"0000000B") ) 
        report "Error: S /= x0000000A nand x0000000B" severity error;
    
    report "Testbench finished!, no errors found";
    wait;

   
end process;

end;