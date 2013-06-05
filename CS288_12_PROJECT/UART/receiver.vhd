----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:29:15 04/11/2013 
-- Design Name: 
-- Module Name:    receiver - Behavioral 
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

-- receiver recieves data in serial form and gives 8-bit parallel output after removing the 
-- start and end bits.
entity receiver is
    Port ( serial_input : in  STD_LOGIC; 						-- serial input to the receiver.
           clk : in  STD_LOGIC; 									-- Clock
			  reset :in  STD_LOGIC:='0'; 							-- reset the receiver to idle state
           output : out  STD_LOGIC_VECTOR (7 downto 0)); -- parallel output (8 bits) from the receiver.
			  
end receiver;

architecture Behavioral of receiver is
component Counter is -- generic mod Counter 
	Generic ( overflow_count : integer :=15
				);
    Port ( reset : in  std_ulogic;
           counter_clk : in  std_logic;
			  overflow : out STD_LOGIC := '0');
end component;

component SIPO_reg is
    Port ( serial_input : in  STD_LOGIC:='1';
           parallel_output : out  STD_LOGIC_VECTOR (7 downto 0);
           start : in  STD_LOGIC;
			  send : in STD_LOGIC;
           clk_in : in  STD_LOGIC);
end component;

type state is (idle, start_recieving, recieve_data, stop_recieving); -- The receiver's four states.
signal p_state, n_state : state :=idle; -- signals for storing the present and the next states.
signal sipo_clk: std_logic; 				 -- Clock to SIPO unit which is 16 times slower than the master clock. 
signal sipo_reset: std_logic; 			 -- Signal to reset the SIPO unit.
signal sipo_send: std_logic; 				 -- Signal to get output from the SIPO.

signal counter_overflow : std_logic; 	 -- Flag to detect overflow of mod-7 counter. 
signal counter_reset : std_logic; 		 -- Signal to reset mod-7 counter.

signal memory : std_logic_vector(7 downto 0) := (others => '1'); -- Stores the SIPO output temporarily 
--till it is assigned to the receiver output. 
signal index : integer := 0; 				 -- Keeps a count of how many bits the receiver unit has seen.
begin
	sipo: SIPO_reg -- SIPO converts the 8 bits recieved through the serial input 
	--to parallel output.
	Port Map (
		clk_in => sipo_clk, 
      start => sipo_reset,
		send => sipo_send,
      parallel_output => memory,
      serial_input => serial_input
	);
	
	count: Counter -- The mod-7 counter used to generate the SIPO clock.
	Generic Map ( overflow_count =>7)
	Port Map(
		reset => counter_reset,
      counter_clk => clk,
      overflow => counter_overflow
	);
	
	states:process(clk) -- Process to update the state of the receiver.
	begin
		if (rising_edge(clk)) then
			p_state<=n_state;
		end if;
	end process;
	
	data:process(p_state,serial_input,counter_overflow) -- Process to find  out the next state
	-- and perform operations for each state.
	 
	begin
	if(reset='1') then
		n_state<= idle;
		counter_reset <='1';
		sipo_reset <='1';
	else
		case p_state is
      -- In "idle" state when the serial input becomes 0, i.e, we encounter the
		--start bit, the state chnages to "start_recieving".
		when idle => 	
			if(serial_input='0') then
				n_state<= start_recieving;
				counter_reset<='1';
				sipo_reset<='0';
			end if;
			
			-- In "start_recieving" state when the counter overflows, we
			-- expect to be reading the middle of start bit and if the serial input is 0, then
			-- state changes to "recieve_data" i.e we start recieving data bits
			-- from the serial input and the index is set to zero. We also reset and start the SIPO
			-- clock with initial value 1.
			when start_recieving =>
			if(counter_overflow='1' and serial_input='0') then
				n_state<= recieve_data;
				sipo_clk<='1';
				sipo_reset<='1';
				sipo_send<='0';
				index<=0;
			end if;
		
			-- In "recieve data" state, we generate the SIPO clock using the 
			-- overflow signal of mod-7 counter. We toggle it every 8 master clock pulses resulting in 
			-- the clock being 16 times slower. At each rising edge of SIPO clock, the SIPO unit
			-- recieves the serial input and stores it in its parallel output.	
			when recieve_data =>
			if(counter_overflow= '1' and counter_overflow'event and index /= 17) then
				n_state<= recieve_data;
				index<=index+1;
				if(sipo_clk='1') then
					sipo_clk<='0';
				else sipo_clk<='1';
				end if;
			elsif(counter_overflow='1' and counter_overflow'event and index =17 and serial_input='1') then
			-- When we have read 8 data bits, and are in the middle of the end bit which is
			-- 1, we change the state to "stop recieving" and sends signal to the SIPO unit 
			-- to transfer its output to memory signal.
				n_state<=  stop_recieving;
				counter_reset<='1';
				sipo_send<='1';
			end if;
		
			-- In "stop recieving" state, receiver output(8 bit) is assigned
			--the contents of memory signal and then goes to idle state.
			when  stop_recieving =>
			n_state<=idle;
			counter_reset<='1';
			output <= memory;
			
		end case;
	end if;
		end process;

end Behavioral;

