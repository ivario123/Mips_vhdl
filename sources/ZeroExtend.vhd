----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2021 09:00:34
-- Design Name: 
-- Module Name: ZeroExtend - Behavioral
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

entity ZeroExtend is
    port(
        A: in std_logic;
        R: out std_logic_vector(31 downto 0));
end ZeroExtend;


architecture Behavioral of ZeroExtend is
    
begin
    GenerateLabel :for I in 1 to 31 generate
        R(I)<='0';
    end generate;
    R(0)<= A;
    

end Behavioral;
