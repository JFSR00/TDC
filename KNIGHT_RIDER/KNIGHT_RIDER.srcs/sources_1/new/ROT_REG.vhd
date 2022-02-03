----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2021 14:05:04
-- Design Name: 
-- Module Name: ROT_REG - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROT_REG is
	Generic(N_LEDS: integer:= 16);
    Port ( CLK_i : in STD_LOGIC;
    	   RST_i : in STD_LOGIC;
           ENA_i : in STD_LOGIC;
           L_R_i : in STD_LOGIC;
           LED_o : out STD_LOGIC_VECTOR (N_LEDS-1 downto 0));
end ROT_REG;

architecture Behavioral of ROT_REG is

signal LED: std_logic_vector(N_LEDS-1 downto 0);

begin

process (CLK_i, RST_i)
begin
	if RST_i = '1' then
		LED(N_LEDS-1 downto 1) <= (others => '0');
		LED(0) <= '1';
	elsif rising_edge(CLK_i) then
		if ENA_i = '1' then
			if L_R_i = '1' then
				LED <= std_logic_vector(shift_left(unsigned(LED),1));
			else
				LED <= std_logic_vector(shift_right(unsigned(LED),1));
			end if;
		end if;
	end if;
end process;

LED_o <= LED;

end Behavioral;
