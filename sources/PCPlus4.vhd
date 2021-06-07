----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2021 09:03:33
-- Design Name: 
-- Module Name: PCPlus4 - Behavioral
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

ENTITY PCPlus4 IS
    PORT(
        Clk: in std_logic;
        Reset: in std_logic;
        Q: out std_logic_vector(31 downto 0)
        );
END PCPlus4;


architecture Behavioral of PCPlus4 is
    component Adder32 is
        port(
            A, B : in std_logic_vector(31 downto 0);
            Cin : in std_logic;
            R : out std_logic_vector(31 downto 0);
            V, C : out std_logic);
    end component;
    component flop is
      Port (clk,reset : in std_logic;
      D : in std_logic_vector(31 downto 0);
      Q : out std_logic_vector(31 downto 0) );
    end component;
    signal adderIn, adderOut : std_logic_vector(31 downto 0);
begin
        flop_instance : flop port map(clk => clk, reset => Reset, Q => adderIn , D => adderOut);
        adder_instance : Adder32 port map( A => "00000000000000000000000000000100"
        , B =>adderIn ,Cin => '0' , R => adderOut );
        Q <= adderIn;
end Behavioral;
