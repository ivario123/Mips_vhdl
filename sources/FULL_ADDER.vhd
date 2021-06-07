----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.04.2021 09:19:57
-- Design Name: 
-- Module Name: FULL_ADDER - Behavioral
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
entity FULL_ADDER is 
	port(
		A, B, Cin : in std_logic;
		R, Cout   : out std_logic);
end entity;


architecture Behavioral of FULL_ADDER is
    signal InternalXor,InternalAnd : std_logic;
begin
    InternalXor <= A xor B;
    InternalAnd <= InternalXor and Cin;
    R <= InternalXor xor Cin;
    Cout <= (A and B) or InternalAnd;
    


end Behavioral;
