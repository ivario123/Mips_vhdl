----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2021 09:00:34
-- Design Name: 
-- Module Name: ARITH_32 - Behavioral
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

entity ARITH_32 is
    port(
        A, B : in std_logic_vector(31 downto 0);
        Sub : in std_logic;
        R : out std_logic_vector(31 downto 0);
        V, C : out std_logic);
end ARITH_32;


architecture Behavioral of ARITH_32 is
    component Adder32 is
        Port ( A,B : in std_logic_vector(31 downto 0);
          Cin : in std_logic;
          R : out std_logic_vector(31 downto 0);
          C,V : out std_logic);
    end component;
    signal InternalC : std_logic_vector(32 downto 0);
    signal XorB : std_logic_vector(31 downto 0);
begin
    InternalC(0) <= Sub;
    adders : for i in 0 to 31 generate
        XorB(i) <= B(i) xor Sub;
     end generate;
     adder_instance : Adder32 port map( A => A , B => XorB , Cin => Sub , V => V , C => C , R => R);
     

end Behavioral;
