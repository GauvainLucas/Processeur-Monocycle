library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decod_instruction is 
port(
   instruction : in std_logic_vector(31 downto 0);
   flags: in std_logic_vector(31 downto 0);
   nPCSel, RegWr, ALUSrc, PSREn, MemWr, WrRsc, RegSel, RegAff: out std_logic;
   ALUctr : out std_logic_vector(2 downto 0);
   Imm24 : out std_logic_vector(23 downto 0);
   imm8 : out std_logic_vector(7 downto 0)
);
    
END entity ;


ARCHITECTURE behavioral OF decod_instruction IS
    type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);
    signal instr_courante: enum_instruction;
BEGIN

    process(instruction)
    begin
        case instruction(31 downto 20) is
            when "111000101000" => instr_courante <= ADDi;
            when "111000001000" => instr_courante <= ADDr;
            when "111000111010" => instr_courante <= MOV;
            when "111000110101" => instr_courante <= CMP;
            when "111001100000" => instr_courante <= STR;
            when "111001100001" => instr_courante <= LDR;
            when others => null;
        end case;

        case instruction (31 downto 24) is
            when "11101010" => instr_courante <= BAL;
            when "10111010" => instr_courante <= BLT;
            when others => null;
        end case;
        
    end process;
    
    process(instr_courante, instruction)
    begin
        case(instr_courante)is 
            when ADDi => 
                nPCSel <= '0';
                RegWr <= '1';
                ALUSrc <= '1';
                ALUctr <= "000";
                PSREn <= '1';
                MemWr <= '0';
                WrRsc <= '0';
                RegSel <= '0';
                RegAff <= '0';
                imm8 <= instruction(7 downto 0);
                imm24 <= (others => '0');


            when ADDr => 
                nPCSel <= '0';
                RegWr <= '1';
                ALUSrc <= '0';
                ALUctr <= "000";
                PSREn <= '1';
                MemWr <= '0';
                WrRsc <= '0';
                RegSel <= '0';
                RegAff <= '0';
                imm8 <= (others => '0');
                imm24 <= (others => '0');
                
            when BAL => 
                nPCSel <= '1';
                RegWr <= '0';
                ALUSrc <= '0';
                ALUctr <= "000";
                PSREn <= '0';
                MemWr <= '0';
                WrRsc <= '0';
                RegSel <= '0';
                RegAff <= '0';
                imm8 <= (others => '0');
                imm24 <= instruction(23 downto 0);
                
            when BLT => 
                if flags(31) = '1' then
                    nPCSel <= '1';
                    RegWr <= '0';
                    ALUSrc <= '0';
                    ALUctr <= "000";
                    PSREn <= '0';
                    MemWr <= '0';
                    WrRsc <= '0';
                    RegSel <= '0';
                    RegAff <= '0';
                    imm8 <= (others => '0');
                    imm24 <= instruction(23 downto 0);
                else
                    nPCSel <= '0';
                    RegWr <= '0';
                    ALUSrc <= '0';
                    ALUctr <= "000";
                    PSREn <= '0';
                    MemWr <= '0';
                    WrRsc <= '0';
                    RegSel <= '0';
                    RegAff <= '0';
                    imm8 <= (others => '0');
                    imm24 <= (others => '0');
                end if;
                
                
            when CMP => 
                nPCSel <= '0';
                RegWr <= '0';
                ALUSrc <= '1';
                ALUctr <= "010";
                PSREn <= '1';
                MemWr <= '0';
                WrRsc <= '0';
                RegSel <= '0';
                RegAff <= '0';
                imm8 <= instruction(7 downto 0);
                imm24 <= (others => '0');
                
            when LDR => 
                nPCSel <= '0';
                RegWr <= '1';
                ALUSrc <= '1';
                ALUctr <= "000";
                PSREn <= '0';
                MemWr <= '0';
                WrRsc <= '1';
                RegSel <= '0';
                RegAff <= '0';
                imm8 <= (others => '0');
                imm24 <= (others => '0');
                
            when MOV => 
                nPCSel <= '0';
                RegWr <= '1';
                ALUSrc <= '1';
                ALUctr <= "001";
                PSREn <= '1';
                MemWr <= '0';
                WrRsc <= '0';
                RegSel <= '0';
                RegAff <= '0';
                imm8 <= instruction(7 downto 0);
                imm24 <= (others => '0');

            when STR => 
                nPCSel <= '0';
                RegWr <= '0';
                ALUSrc <= '1';
                ALUctr <= "000";
                PSREn <= '0';
                MemWr <= '1';
                WrRsc <= '0';
                RegSel <= '1';
                RegAff <= '1';
                imm8 <= (others => '0');
                imm24 <= (others => '0');

            when others => 
                nPCSel <= '0';
                RegWr <= '0';
                ALUSrc <= '0';
                ALUctr <= "000";
                PSREn <= '0';
                MemWr <= '0';
                WrRsc <= '0';
                RegSel <= '0';
                RegAff <= '0';
                imm8 <= (others => '0');
                imm24 <= (others => '0');
        end case;
    end process;
END architecture;