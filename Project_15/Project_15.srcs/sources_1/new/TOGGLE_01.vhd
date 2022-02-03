----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.03.2021 11:00:06
-- Design Name: 
-- Module Name: TOGGLE_01 - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EDGE_DETECTOR_ 00 is
    Port ( RST_i : in STD_LOGIC;
           PUSH_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           PULSE_o : out STD_LOGIC);
end EDGE_DETECTOR_ 00;

architecture Behavioral of EDGE_DETECTOR_ 00 is

begin
	process(CLK_i, RST_i, PUSH_i)
		signal REG_PUSH : std_logic;
		signal PREV_PUSH : std_logic;
	begin
		if RST_i = '1' then
			REG_PUSH <= '0';
			PREV_PUSH <= '0';
			Q <= '0';
		elsif rising_edge(CLK_i) then
			REG_PUSH <= PUSH_i;
			PREV_PUSH <= REG_PUSH;
			-- Check the rising edge condition in the PUSHBUTTON
			if ( PREV_PUSH = '0' and REG_PUSH = '1') then
				Q <= not Q;
			end if
		end if;
	end process;

end Behavioral;
