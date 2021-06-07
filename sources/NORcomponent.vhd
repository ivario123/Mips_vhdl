----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2021 09:21:01
-- Design Name: 
-- Module Name: NORcomponent - Behavioral
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

entity NORcomponent is
  Port (A :in  std_logic_vector(31 downto 0);
  R : out std_logic );
end NORcomponent;

architecture Behavioral of NORcomponent is
    signal intern : std_logic_vector(31 downto 0);
begin
    intern(0) <= A(0);
    gen : for i in 1 to 31 generate
        intern(i) <= A(i) nor intern(i-1);
    end generate;
    R <= intern(31);

end Behavioral;
