----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:41:23 03/30/2013 
-- Design Name: 
-- Module Name:    shift_reg - shift_reg_arch 
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
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;


-- Implementation of parallel in serial out register
-- defining entity for shift register
entity PISO_shift_reg is
port(  
	clk_s,load : in std_logic;            			
	parallel_input : in std_logic_vector(7 downto 0); 		
	serial_output : out std_logic
	);         				
end PISO_shift_reg;

-- architecture of shift register
architecture shift_reg_arch of PISO_shift_reg is
signal temp: std_logic_vector (7 downto 0);  
signal c : INTEGER := 1;
begin
	process(load, clk_s)
	begin
		-- while loading the inputs
		if (load = '1') then
				-- store the input in temp vector
				temp <= parallel_input;		
				-- output is 1
				serial_output <= '1'; 
				-- initialise count of bits
				c <= 1;
		end if;
		if (clk_s'event and clk_s = '0') then  
			-- when load is 0, and output is to be given
			if (load = '0') then 
				-- continue loop till all bits are outputed
				if(c = 9) then 	
					serial_output <= '1'; 					-- high output state after completing output           
				else
					serial_output <= temp(0);   			-- give first bit as the output
					temp <= '0' & temp(7 downto 1); 		-- shift bits to the right
					c <= c + 1;
				end if;	
			end if;
		end if;	
	end process;
end shift_reg_arch;





