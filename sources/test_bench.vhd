LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY test_bench IS
END test_bench;
 
ARCHITECTURE behavior OF test_bench IS 

-- First, declare the lower-level entity (Component).
component SecondMipsVersion is
  port(
    Clk : in std_logic;
    Reset : in std_logic;
    dbg_reg : in std_logic_vector(4 downto 0);
    dbg_reg_data : out std_logic_vector(31 downto 0);
    dbg_dm_reg : in std_logic_vector(4 downto 0);
    dbg_dm_reg_data : out std_logic_vector(31 downto 0)
  );
end component;
-- Next, declare some local signals to assign values to and observe...
-- Delete the signal below and make your own, it is only there to show you the structure of the test bench.
    signal dbg_dm_reg_data,dbg_reg_data : std_logic_vector(31 downto 0);
    signal dbg_reg,dbg_dm_reg : std_logic_vector(4 downto 0);
    signal Clk,Reset : std_logic;
     
     
    begin
-- Create an instance of the component under test (Port map).
    mipsInstance : SecondMipsVersion port map(
    Clk => Clk,
    Reset => Reset,
    dbg_reg => dbg_reg,
    dbg_reg_data => dbg_reg_data,
    dbg_dm_reg => dbg_dm_reg,
    dbg_dm_reg_data => dbg_dm_reg_data
  );
-- Now define a process to apply some stimulus over time...
	process
	constant PERIOD: time := 40 ns;
	
    begin
        
        -- Testing the mips
        Reset <= '1';
        Clk <= '0';
        dbg_reg <= "00000";
        dbg_dm_reg <= "00000";
        wait for PERIOD;
        -- High pulse
        Clk <= '1';
        wait for PERIOD;
        
        Reset <= '0';
        for i in 0 to 12 loop --26 loop
            -- Low pulse
            Clk <= '0';
            wait for PERIOD;

            -- High pulse
            Clk <= '1';
            wait for PERIOD;
            -- Tests for the devider program
--            if i = 1 then
--                dbg_reg <= "00100";
--            elsif i = 2 then
--                dbg_reg <= "00101";
--                wait for 1 ns;
--            elsif i = 3 then
--            -- Printing the store 1 for the beq operation
--                dbg_reg <= "00110";
--                wait for 1 ns;
--                assert dbg_reg_data = x"00000001" report "Store 1 failed";
--            elsif i = 4 then
--            -- Printing the q = 0 result
--                dbg_reg <= "00010";
--                wait for 1 ns;
--                assert dbg_reg_data = x"00000000" report "Init q failed";
--            elsif i = 5 then
--            -- Printing the R = N result
--               dbg_reg <= "00011";
--               wait for 1 ns;
--            elsif i = 6 then
--            -- Printing the R < D result
--               dbg_reg <= "01000";
--            else
--               dbg_reg <= "00010";  
--            end if;
            -- Tests for the base program
            dbg_reg <= std_logic_vector(to_unsigned(i, dbg_reg'length));
            wait for 1 ns;
            if i = 0 then
                assert dbg_reg_data = x"FFFFFFF8" report "First Addi failed";
            elsif i = 1 then
                assert dbg_reg_data = x"00000003" report "Second Addi failed";
            elsif i = 2 then
                assert dbg_reg_data = x"00000003" report "Add failed";
            elsif i = 3 then
                assert dbg_reg_data = x"00000003" report "Sub failed";
            elsif i = 4 then
                assert dbg_reg_data = x"00000000" report "first Slt failed";
            elsif i = 5 then
                assert dbg_reg_data = x"00000000" report "Slti failed";
            elsif i = 6 then
                assert dbg_reg_data = x"00000000" report "second Slt failed";
            elsif i = 7 then
                assert dbg_reg_data = x"00000000" report "Or failed";
            elsif i = 8 then
                assert dbg_reg_data = x"00000000" report "And failed";
            elsif i = 9 then
                dbg_dm_reg <= "00000";
                assert dbg_dm_reg_data <= X"00000003" report "First sw failed";
            elsif i = 10 then
                dbg_reg <= "00100";
                assert dbg_reg_data <= X"00000003" report "Second sw failed";
            elsif i = 11 then
                dbg_dm_reg <= "00100";
                assert dbg_dm_reg_data <= X"00000003" report "Second sw failed";
            elsif i = 12 then
                dbg_reg <= "00100";
                assert dbg_reg_data <= X"00000003" report "Second sw failed";
            end if;
        end loop;
        wait;
    end process;

END architecture;