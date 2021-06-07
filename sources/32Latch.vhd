
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Latch32 is
  Port (S : in std_logic_vector(31 downto 0);
        Clk : in std_logic;
        Reset : in std_logic;
        Q : out std_logic_vector(31 downto 0));
end Latch32;

architecture Behavioral of Latch32 is
    signal internalval : std_logic_vector(31 downto 0);
begin
    internalval <= S;
    process (Clk)
    begin
        if Clk = '1' then
            Q <= internalval;
        end if;
    end process;
end Behavioral;
