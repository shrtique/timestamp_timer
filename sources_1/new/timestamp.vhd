----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.07.2018 15:01:21
-- Design Name: 
-- Module Name: timestamp - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity timestamp is

	Generic (
                AXI_LITE_DATA_WIDTH : integer := 32
				
    );


    Port ( 

    		clk 		: in STD_LOGIC;
           	reset 		: in STD_LOGIC;
           	en 			: in STD_LOGIC;

           	--freq_input_clk_KHz	: in std_logic_vector(AXI_LITE_DATA_WIDTH - 1 downto 0);
           	--time_step_us 		: in std_logic_vector(AXI_LITE_DATA_WIDTH - 1 downto 0);
           	period_counter_reg		: in std_logic_vector(AXI_LITE_DATA_WIDTH - 1 downto 0);
           	timestamp_result 	: out std_logic_vector(AXI_LITE_DATA_WIDTH - 1 downto 0)

    );
end timestamp;

architecture Behavioral of timestamp is

--Signals--

signal clk_counter : integer range 0 to 2147483647;
signal period_counter : integer range 0 to 2147483647;
signal timestamp_result_tmp : integer range 0 to 2147483647;

signal int_freq_input_clk_KHz : integer range 0 to 2147483647;
signal int_time_step_us : integer range 0 to 2147483647;
-----------	

begin

--P0 limit for clk_division--
eval_LIMIT : process (clk)
begin

	if (rising_edge(clk)) then

		if (reset = '1') then
			period_counter <= 0;
		else
			
			period_counter <= (to_integer(unsigned (period_counter_reg)));
			--int_freq_input_clk_KHz <= (to_integer(unsigned (freq_input_clk_KHz)));
			--int_time_step_us <=	(to_integer(unsigned (time_step_us)));
			--period_counter <= ((to_integer(unsigned (freq_input_clk_KHz))) * (to_integer(unsigned (time_step_us))))/1000;
		end if;			

	end if;

end process eval_LIMIT;	


--------------------------------------


--P1: clock division--
CLOCK_DIVISION : process (clk)
begin

	if (rising_edge(clk)) then

		if (reset = '1') then

			clk_counter <= 0;	
			timestamp_result_tmp <= 0;

		else				
			if (en = '1') then

				if (clk_counter < period_counter) then

					clk_counter <= clk_counter + 1;
				else
					clk_counter <= 1;
					timestamp_result_tmp <= timestamp_result_tmp + 1;	

				end if;	
			end if;	
		end if;
	end if;	

end process CLOCK_DIVISION;	
--------------------------------------

timestamp_result <= (std_logic_vector (to_unsigned(timestamp_result_tmp, 32)));

end Behavioral;
