--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:13:54 04/11/2013
-- Design Name:   
-- Module Name:   F:/UART/Counter_tb.vhd
-- Project Name:  UART
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Counter
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Counter_tb IS
END Counter_tb;
 
ARCHITECTURE behavior OF Counter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Counter
    PORT(
         reset : IN  std_logic;
         counter_clk : IN  std_logic;
         overflow : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal counter_clk : std_logic := '0';

 	--Outputs
   signal overflow : std_logic;

   -- Clock period definitions
   constant counter_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Counter PORT MAP (
          reset => reset,
          counter_clk => counter_clk,
          overflow => overflow
        );

   -- Clock process definitions
   counter_clk_process :process
   begin
		counter_clk <= '0';
		wait for counter_clk_period/2;
		counter_clk <= '1';
		wait for counter_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for counter_clk_period*10;
		reset<='1';
		
		wait for 10  ns;
		reset<='0';
      wait;
   end process;

END;
