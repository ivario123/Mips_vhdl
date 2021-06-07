----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2021 10:58:10
-- Design Name: 
-- Module Name: DataMemory - Behavioral
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
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataMemory is 
port ( Clk: in std_logic;
        Reset: in std_logic;
        MemWE : in std_logic;
        Address : in std_logic_vector(31 downto 0);
        DataIn : in std_logic_vector(31 downto 0);
        DataOut : out std_logic_vector(31 downto 0);
        dbg_dm_reg : in std_logic_vector(4 downto 0);
        dbg_dm_reg_data : out std_logic_vector(31 downto 0)
    );
end entity;


architecture Behavioral of DataMemory is

type registerfile_type is array(31 downto 0) of std_logic_vector(31 downto 0);
signal Myregisterfile:registerfile_type;
begin
    process(clk,reset)
        begin
            if reset = '1' then
                    Myregisterfile <= (others => (others => '0'));
            elsif conv_integer(Address) < 32 then
                if clk'event and clk='1' then
                    if MemWE='1' and conv_integer(Address) < 31 then
                        Myregisterfile(conv_integer(Address))<=DataIn;
                    end if;
                end if;
            end if;
    end process;
    DataOut<=Myregisterfile(conv_integer(Address)) when conv_integer(Address) < 32 and conv_integer(Address) >= 0  and MemWE = '0' else X"00000000";
    -- Debug port
    dbg_dm_reg_data <= Myregisterfile(conv_integer(dbg_dm_reg));
end Behavioral;
