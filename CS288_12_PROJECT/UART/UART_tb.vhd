--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:36:53 04/11/2013
-- Design Name:   
-- Module Name:   F:/UART/UART_tb.vhd
-- Project Name:  UART
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UART
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
 
ENTITY UART_tb IS
END UART_tb;
 
ARCHITECTURE behavior OF UART_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UART
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         send : IN  std_logic;
         uart_input : IN  std_logic_vector(7 downto 0);
         uart_output : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal send : std_logic := '0';
   signal uart_input : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal uart_output : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UART PORT MAP (
          clk => clk,
          reset => reset,
          send => send,
          uart_input => uart_input,
          uart_output => uart_output
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
      wait for 100 ns;	

      wait for clk_period*10;

      -- first 8 bits 

		uart_input<="10111001";
		send<='1';
		wait for 10 ns;
		send <= '0';
      wait for 1000 us;

		-- next 8 bits
		uart_input<="01001101";
		send<='1';
		wait for 10 ns;
		send <= '0';
      wait for 1000 us;
		
		-- next 8 bits
		uart_input<="10101010";
		send<='1';
		wait for 10 ns;
		send <= '0';
      wait for 1000 us;
		
		-- next 8 bits
		uart_input<="10001000";
		send<='1';
		wait for 10 ns;
		send <= '0';
      wait for 1000 us;
		
		-- next 8 bits
		uart_input<="00101010";
		send<='1';
		wait for 10 ns;
		send <= '0';
      wait ;
   end process;

END;
