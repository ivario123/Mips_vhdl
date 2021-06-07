----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2021 08:52:13
-- Design Name: 
-- Module Name: Two_to_one_mux_5 - Behavioral
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

entity Two_to_one_mux_5 is
  Port (A,B : in std_logic_vector(4 downto 0);
      Op : in std_logic;
      R : out std_logic_vector( 4 downto 0) );
end Two_to_one_mux_5;

architecture Behavioral of Two_to_one_mux_5 is

begin
    with Op select
        R<= A  when '0',
            B when '1',
            "00000" when others;

end Behavioral;
