----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2021 13:16:20
-- Design Name: 
-- Module Name: BitShift - Behavioral
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

entity BitShift is
    Port ( Num : in std_logic_vector(31 downto 0);
           R : out std_logic_vector(31 downto 0) );
end BitShift;

architecture Behavioral of BitShift is

begin
    R(0) <= '0';
    R(1) <= '0';
    Gen : for i in 29 downto 0 generate
        R(i+2) <= Num(i);
    end generate;

end Behavioral;
