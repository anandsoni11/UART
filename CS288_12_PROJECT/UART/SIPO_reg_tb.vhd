--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:56:58 04/11/2013
-- Design Name:   
-- Module Name:   F:/UART/SIPO_reg_tb.vhd
-- Project Name:  UART
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SIPO_reg
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
 
ENTITY SIPO_reg_tb IS
END SIPO_reg_tb;
 
ARCHITECTURE behavior OF SIPO_reg_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SIPO_reg
    PORT(
         serial_input : IN  std_logic;
         parallel_output : OUT  std_logic_vector(7 downto 0);
         start : IN  std_logic;
         send : IN  std_logic;
         clk_in : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal serial_input : std_logic := '0';
   signal start : std_logic := '0';
   signal send : std_logic := '0';
   signal clk_in : std_logic := '0';

 	--Outputs
   signal parallel_output : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_in_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SIPO_reg PORT MAP (
          serial_input => serial_input,
          parallel_output => parallel_output,
          start => start,
          send => send,
          clk_in => clk_in
        );

   -- Clock process definitions
   clk_in_process :process
   begin
		clk_in <= '0';
		wait for clk_in_period/2;
		clk_in <= '1';
		wait for clk_in_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_in_period*10;

      -- insert stimulus here 
		
		start <= '1';
		serial_input<='0';
		wait for clk_in_period;
		
		serial_input<='1';
		wait for clk_in_period;
		
		serial_input<='0';
		wait for clk_in_period;
		
		serial_input<='1';
		wait for clk_in_period;
		
		serial_input<='1';
		wait for clk_in_period;
		
		serial_input<='1';
		wait for clk_in_period;
		
		serial_input<='0';
		wait for clk_in_period;
		
		serial_input<='1';
		wait for clk_in_period;

		send <='1';
		wait for 10 ns;
		send <='0';
      wait;
		
   end process;

END;
