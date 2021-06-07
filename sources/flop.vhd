----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2021 08:37:37
-- Design Name: 
-- Module Name: flop - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity flop is
  Port (clk,reset : in std_logic;
  D : in std_logic_vector(31 downto 0);
  Q : out std_logic_vector(31 downto 0) );
end flop;

architecture Behavioral of flop is

begin
    process(clk,reset)
    begin
        if(reset = '1') then
            Q <= X"00000000";
        elsif rising_edge(clk) then
            Q<=D;
        end if;
    end process;

end Behavioral;
