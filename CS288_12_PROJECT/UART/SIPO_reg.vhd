----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:33:08 04/11/2013 
-- Design Name: 
-- Module Name:    SIPO_reg - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- entity for SIPO register
entity SIPO_reg is
    Port ( serial_input : in  STD_LOGIC;									-- The serial input to SIPO
           parallel_output : out  STD_LOGIC_VECTOR (7 downto 0);	-- Parallel output give by PISO
           start : in  STD_LOGIC;											-- to indicate the start of reception
			  send : in STD_LOGIC;												-- send bit to indicate when the output is to be shown
           clk_in : in  STD_LOGIC);											-- Input clock
end SIPO_reg;

-- Architecture of SIPO
architecture Behavioral of SIPO_reg is

signal temp: std_logic_vector (7 downto 0) :="00000000"; 			-- Variable to store input of SIPO
signal c:integer :=0;															-- signal to maintain count

begin
	
	process(clk_in, start, send)
	begin
		-- when send bit is high, after/before transmiission
		if (send='1') then
			 parallel_output <= temp;
		end if;
	
		-- when we indicate starting of sampling
		if (start='1' and start'event) then
			c<=0;
			temp<="00000000";
		end if;
		
		-- count till 8 bits are seen as input
		-- increment the count variable
		if (rising_edge(clk_in)) then
			if (c < 8) then
				temp(c)<=serial_input;
				c<=c+1;
			end if;
			
		end if;
	
	end process;

end Behavioral;

