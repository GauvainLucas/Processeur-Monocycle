library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unite_de_gestion_des_instructions is 
port(
    clk         : in std_logic;
    reset       : in std_logic;
    nPCsel      : in std_logic;
    offset      : in std_logic_vector(23 downto 0);
    irq         : in std_logic;
    vicpc       : in std_logic_vector(31 downto 0);
    irq_end     : in std_logic;
    instruction : out std_logic_vector(31 downto 0);
    irq_serv    : out std_logic);
end entity;

ARCHITECTURE struct OF unite_de_gestion_des_instructions IS
   signal PC, sExtend, sPlusUn , sPlus, LR : std_logic_vector(31 downto 0);
   
BEGIN
    sPlusUn <= std_logic_vector(unsigned(PC) + to_unsigned(1, 32));
    sPlus <= std_logic_vector(unsigned(sExtend) + unsigned(sPlusUn));

    PC_Extend : entity work.sign_extend(behavioral)
        generic map(24)
        port map(offset, sExtend);

    instr : entity work.instruction_memory_IRQ(RTL)
        port map(PC, instruction);
	
    process (clk, reset)
    begin
        if (reset = '1') then
            PC <= (others => '0');
            LR <= (others => '0');
            irq_serv <= '0';
        elsif rising_edge(clk) then
            if (irq = '1') then
                PC <= vicpc;
                LR <= PC;
                irq_serv <= '1';
            else
                irq_serv <= '0';
                if (irq_end = '1') then
                    PC <= std_logic_vector(unsigned(LR) + to_unsigned(1, 32));
                elsif(nPCsel = '1') then
                    PC <= sPlus;
                else
                    PC <= sPlusUn;
                end if;
            end if; 
        end if;
    end process;
END architecture;
