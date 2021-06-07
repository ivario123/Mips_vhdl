----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2021 10:34:28
-- Design Name: 
-- Module Name: Adder32 - Behavioral
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

entity Adder32 is
  Port ( A,B : in std_logic_vector(31 downto 0);
  Cin : in std_logic;
  R : out std_logic_vector(31 downto 0);
  C,V : out std_logic);
end Adder32;

architecture Behavioral of Adder32 is
    component FULL_ADDER is
        port(
            A, B, Cin : in std_logic;
            R, Cout   : out std_logic);
    end component;
    signal InternalC : std_logic_vector(32 downto 0);
begin
    InternalC(0)<=Cin;
    adders : for i in 0 to 31 generate
        adder_instance : FULL_ADDER port map( A => A(i) , B => B(i) , R => R(i) , Cin => InternalC(i) , Cout=> InternalC(i+1) );
     end generate;
     C <= InternalC(32);
     V <= InternalC(31) xor InternalC(32);
end Behavioral;
