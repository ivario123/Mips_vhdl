


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SignExtend is
	port(
		A : in std_logic_vector(15 downto 0);
		B : out std_logic_vector(31 downto 0)
		);
end SignExtend;


architecture Behavioral of SignExtend is

begin
    CopyValues : for i in 14 downto 0 generate
        B(i) <= A(i);
    end generate;
    SigExt : for i in 31 downto 15 generate
        B(i) <= A(15);
    end generate;

end Behavioral;
