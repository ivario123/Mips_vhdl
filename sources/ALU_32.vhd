----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2021 09:00:34
-- Design Name: 
-- Module Name: ALU_32 - Behavioral
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

entity ALU_32 is
    port(
        A, B : in std_logic_vector(31 downto 0);
        SUB : in std_logic;
        Op : in std_logic_vector(1 downto 0);
        R : out std_logic_vector(31 downto 0);
        V, C, Z : out std_logic);
end ALU_32;


architecture Behavioral of ALU_32 is
    component ARITH_32 is
        port(
            A, B : in std_logic_vector(31 downto 0);
            Sub : in std_logic;
            R : out std_logic_vector(31 downto 0);
            V, C : out std_logic);
    end component;
    component ZeroExtend is
        port(
            A: in std_logic;
            R: out std_logic_vector(31 downto 0));
    end component;
    component ORcomponent is
       Port (A,B : in std_logic_vector(31 downto 0);
       R : out std_logic_vector(31 downto 0));
    end component;
    component ANDcomponent is
       Port (A,B : in std_logic_vector(31 downto 0);
       R : out std_logic_vector(31 downto 0));
    end component;
    component FOUR_TO_ONE_MUX_32 is
        port(
            A, B, C, D : in std_logic_vector(31 downto 0);
            Op : in std_logic_vector(1 downto 0);
            R : out std_logic_vector(31 downto 0));
    end component;
    component NORcomponent is
        port(A : in std_logic_vector(31 downto 0);
        R : out std_logic);
    end component;
    
        
    signal arithR,ORR,ANDR,ZEROR,MUXR : std_logic_vector(31 downto 0);
    signal ArithC,ArithV,ZeroIn : std_logic;
    
begin
        AndComponent_Instance : ANDcomponent port map( A => A, B => B, R => ANDR);
        OrComponent_Instance : ORcomponent port map(A => A, B => B, R => ORR);
        Arith_instance : ARITH_32 port map( A => A, B => B, Sub => Sub, R => arithR,C=> ArithC, V => ArithV);
        Zero_instance : ZeroExtend port map( A => ZeroIn,R => ZEROR);
        NOR_instance : NORcomponent port map(A => MUXR,R => Z);
        MUX_instance : FOUR_TO_ONE_MUX_32 port map(A=>ANDR,B=> ORR,C=>arithR,D=>ZEROR,R=>MUXR,Op=>Op);
        ZeroIn <= (arithR(31) xor ArithV);
        V<= ArithV;
        C <= ArithC;
        R <= MUXR;
       
end Behavioral;
