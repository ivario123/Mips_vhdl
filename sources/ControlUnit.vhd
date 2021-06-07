


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity ControlUnit is
	port(
        Opcode : in std_logic_vector(5 downto 0);
        funct : in std_logic_vector(5 downto 0);
        Z : in std_logic;
        RegDestination, WriteEnable, ALUSource, Jump, Branch,MemWE,MemToReg : out std_logic;
        ALUControl : out std_logic_vector(2 downto 0)
	);
end ControlUnit;


architecture Behavioral of ControlUnit is

begin
    process(Opcode,funct)
    begin
        if Opcode = "000000" then
            if funct = "100100" then
                ALUControl <=  "000"; MemWE <= '0'; MemToReg <= '0'; Jump <= '0'; Branch <= '0';WriteEnable <= '1';RegDestination<='1';ALUSource <= '0'; -- And
            elsif funct = "100101" then
                ALUControl <= "001"; MemWE <= '0'; MemToReg <= '0'; Jump <= '0'; Branch <= '0';WriteEnable <= '1';RegDestination<='1';ALUSource <= '0'; -- Or
            elsif funct = "100000" then
                ALUControl <= "010"; MemWE <= '0'; MemToReg <= '0'; Jump <= '0'; Branch <= '0';WriteEnable <= '1';RegDestination<='1';ALUSource <= '0'; -- Add
            elsif funct = "100010" then
                ALUControl <= "110"; MemWE <= '0'; MemToReg <= '0'; Jump <= '0'; Branch <= '0';WriteEnable <= '1';RegDestination<='1';ALUSource <= '0'; -- Sub
            elsif funct = "101010" then
                ALUControl <= "111"; MemWE <= '0'; MemToReg <= '0'; Jump <= '0'; Branch <= '0';WriteEnable <= '1';RegDestination<='1';ALUSource <= '0'; -- slt
            end if;
        elsif Opcode = "001000" then
            ALUControl <= "010"; RegDestination <= '0'; ALUSource <= '1';WriteEnable <= '1'; MemWE <= '0'; MemToReg <= '0'; Jump <= '0'; Branch <= '0'; -- addi
        elsif Opcode = "001010" then 
            ALUControl <= "111"; RegDestination <= '0'; ALUSource <= '1';WriteEnable <= '1'; MemWE <= '0'; MemToReg <= '0'; Jump <= '0'; Branch <= '0'; -- slti
        elsif Opcode = "001100" then
            ALUControl <= "000"; RegDestination <= '1'; ALUSource <= '1';WriteEnable <= '1'; MemWE <= '0'; MemToReg <= '0'; Jump <= '0'; Branch <= '0'; -- andi
        elsif Opcode = "001101" then
            ALUControl <= "001"; MemWE <= '0'; MemToReg <= '0'; Jump <= '0'; Branch <= '0'; WriteEnable <= '1'; RegDestination <='1'; ALUSource <= '1'; -- Ori
        elsif Opcode = "000010" then
            ALUControl <= "000"; RegDestination <= '0'; ALUSource <= '0'; WriteEnable <= '0'; MemWE <= '0'; MemToReg <= '0'; Jump <= '1'; Branch <= '0'; -- jump
        elsif Opcode = "000100" then
            ALUControl <= "110"; RegDestination <= '0'; ALUSource <= '0'; WriteEnable <= '0'; MemWE <= '0'; MemToReg <= '0'; Jump <= '0'; Branch <= '1'; -- BEQ
        elsif Opcode = "100011" then
            ALUControl <= "010"; RegDestination <= '0'; ALUSource <= '1'; WriteEnable <= '1'; MemWE <= '0'; MemToReg <= '1'; Jump <= '0'; Branch <= '0'; -- LW
        elsif Opcode = "101011" then
            ALUControl <= "010"; RegDestination <= '0'; ALUSource <= '1'; WriteEnable <= '0'; MemWE <= '1'; MemToReg <= '0'; Jump <= '0'; Branch <= '0'; -- SW
        end if;
    end process;
end Behavioral;
