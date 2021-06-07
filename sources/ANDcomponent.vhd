----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2021 11:48:00
-- Design Name: 
-- Module Name: ANDcomponent - Behavioral
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

entity ANDcomponent is
   Port (A,B : in std_logic_vector(31 downto 0);
   R : out std_logic_vector(31 downto 0));
end ANDcomponent;

architecture Behavioral of ANDcomponent is

begin
    GenerateLabel :for I in 0 to 31 generate
        R(I)<=A(I) and B(I);
    end generate;

end Behavioral;
