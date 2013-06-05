----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:50:18 03/11/2013 
-- Design Name: 
-- Module Name:    Counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Counter entity
	
entity Counter is
	-- Generic variable to define overflow count
	Generic ( overflow_count : integer :=15);
	 
   Port ( reset : in  std_ulogic;					-- input to reset the count
          counter_clk : in  std_logic;				-- clock of counter
			 overflow : out STD_LOGIC := '0');		-- overflow bit to indicate the overflow
end Counter;

architecture Behavioral of Counter is

-- signal maintained to store count of pulses
signal count : integer := 0;
	
begin 
	
	process(reset,counter_clk)
	begin
	-- reset the counter on positive edge of counter
	if (reset='1' and reset'event) then
		count<=0;
	
	-- on every positive edge of clock, increment the count till it overflows
	elsif ( counter_clk'event and  counter_clk='1') then
		-- if count equals overflow, then overflow bit=1
		if (count = overflow_count) then
			overflow <= '1';
			count <= 0;
		-- else overflow bit =0
		else 
			overflow<='0';
			count<=count+1;
		end if;
	end if;

	end process;
	
	
	
end Behavioral;


