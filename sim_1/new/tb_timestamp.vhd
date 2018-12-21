----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.07.2018 15:52:37
-- Design Name: 
-- Module Name: tb_timestamp - Behavioral
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


entity tb_timestamp is
--  Port ( );
end tb_timestamp;

architecture Behavioral of tb_timestamp is


	 COMPONENT timestamp 
    
        Generic (
                    AXI_LITE_DATA_WIDTH : integer := 32
					
        );
                 
        Port    ( 
                   	clk 		: in STD_LOGIC;
           			reset 		: in STD_LOGIC;
           			en 			: in STD_LOGIC;

           			freq_input_clk_KHz	: in std_logic_vector(AXI_LITE_DATA_WIDTH - 1 downto 0);
           			time_step_us 		: in std_logic_vector(AXI_LITE_DATA_WIDTH - 1 downto 0);
           			timestamp_result 	: out std_logic_vector(AXI_LITE_DATA_WIDTH - 1 downto 0)
        );       
               
    END COMPONENT;


signal MAIN_CLK : std_logic := '1';
signal RESET : std_logic := '1';
signal ENABLE : std_logic := '0';

constant register_0 : std_logic_vector(31 downto 0) := X"0000C350";
constant register_1 : std_logic_vector(31 downto 0) := X"000003E8";


begin


UUT: timestamp 
    
    GENERIC MAP (
                    AXI_LITE_DATA_WIDTH => 32
					
    )
    
    PORT MAP (
    
               		clk 		=> MAIN_CLK,
           			reset 		=> RESET,
           			en 			=> ENABLE,

           			freq_input_clk_KHz	=> register_0,
           			time_step_us 		=> register_1,
           			timestamp_result 	=> open
    );
---------------------------------

---------------------------------

MAIN_CLK <= not MAIN_CLK after 10 ns; --period is 20 ns = 50 MHz
RESET <= '0' after 100 ns;
ENABLE <= '1' after 200 ns;
---------------------------------


end Behavioral;
