----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2021 09:00:34
-- Design Name: 
-- Module Name: FOUR_TO_ONE_MUX_32 - Behavioral
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

entity FOUR_TO_ONE_MUX_32 is
    port(
        A, B, C, D : in std_logic_vector(31 downto 0);
        Op : in std_logic_vector(1 downto 0);
        R : out std_logic_vector(31 downto 0));
end FOUR_TO_ONE_MUX_32;


architecture Behavioral of FOUR_TO_ONE_MUX_32 is

begin
    with Op select
         R<= A  when "00",
            B when "01",
            C when "10",
            D when "11",
            "00000000000000000000000000000000" when others;

end Behavioral;
