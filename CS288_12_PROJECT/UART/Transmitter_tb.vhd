--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:33:26 04/11/2013
-- Design Name:   
-- Module Name:   F:/UART/Transmitter_tb.vhd
-- Project Name:  UART
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Transmitter
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
 
ENTITY Transmitter_tb IS
END Transmitter_tb;
 
ARCHITECTURE behavior OF Transmitter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Transmitter
    PORT(
         input : IN  std_logic_vector(7 downto 0);
         output : OUT  std_logic;
         clk_in : IN  std_logic;
         send : IN  std_logic;
         data_sent : OUT  std_logic;
         reset : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic_vector(7 downto 0) := (others => '0');
   signal clk_in : std_logic := '0';
   signal send : std_logic := '0';
   signal data_sent : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal output : std_logic;

   -- Clock period definitions
   constant clk_in_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Transmitter PORT MAP (
          input => input,
          output => output,
          clk_in => clk_in,
          send => send,
          data_sent => data_sent,
          reset => reset
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

      input<="10101010";
		send<='1';
		wait for 10 ns;
		send<='0';
		
		wait for 100 ns;
		input<="00001100";
		send<='1';
		wait for 10 ns;
		send<='0';
		
		wait for 100 ns;
		input<="10001100";
		send<='1';
		wait for 10 ns;
		send<='0';
      wait;
   end process;

END;
