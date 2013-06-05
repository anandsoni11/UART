--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:27:59 04/11/2013
-- Design Name:   
-- Module Name:   /home/anand/cs288/receiver/receiver_tb.vhd
-- Project Name:  receiver
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: receiver
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
 
ENTITY receiver_tb IS
END receiver_tb;
 
ARCHITECTURE behavior OF receiver_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT receiver
    PORT(
         serial_input : IN  std_logic;
         clk : IN  std_logic;
         output : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal serial_input : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal output : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: receiver PORT MAP (
          serial_input => serial_input,
          clk => clk,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		serial_input<='1';
		
		
      wait for 10 ns;	
		serial_input<='0';
		wait for 16*clk_period;
		
		serial_input<='1';
		wait for 16*clk_period;
		
		serial_input<='0';
		wait for 16*clk_period;
		
		serial_input<='1';
		wait for 16*clk_period;
		
		serial_input<='0';
		wait for 16*clk_period;
		
		serial_input<='1';
		wait for 16*clk_period;
		
		serial_input<='0';
		wait for 16*clk_period;
		
		serial_input<='1';
		wait for 16*clk_period;
		
		serial_input<='0';
		wait for 16*clk_period;

		serial_input<='1';
		wait for 16*clk_period;
		
		serial_input<='1';
		
      wait;
   end process;

END;
