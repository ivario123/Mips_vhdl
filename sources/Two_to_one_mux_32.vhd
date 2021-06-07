
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Two_to_one_mux_32 is
  Port (A,B : in std_logic_vector(31 downto 0);
  Op : in std_logic;
  R : out std_logic_vector( 31 downto 0) );
end Two_to_one_mux_32;

architecture Behavioral of Two_to_one_mux_32 is

begin
    with Op select
        R<= A  when '0',
            B when '1',
            x"00000000" when others;
        

end Behavioral;
