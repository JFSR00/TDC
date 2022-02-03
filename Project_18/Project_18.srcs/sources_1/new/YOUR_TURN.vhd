----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Juan Francisco Santos Relinque
-- 
-- Create Date: 17.03.2021 13:57:55
-- Design Name: 
-- Module Name: YOUR_TURN - Behavioral
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

entity YOUR_TURN is
	generic(N : integer := 4);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           INC_i : in STD_LOGIC;
           NUMBER_o : out STD_LOGIC_VECTOR (N-1 downto 0));
end YOUR_TURN;

architecture Behavioral of YOUR_TURN is
	signal COUNTER: unsigned(N-1 downto 0);
	signal REG_PUSH, PREV_PUSH: std_logic;
begin
	process(CLK_i, RST_i)
	begin
		if RST_i = '1' then
			REG_PUSH <= '0';
			PREV_PUSH <= '0';
			COUNTER <= (others =>'0');
		elsif rising_edge(CLK_i) then
			REG_PUSH <= INC_i;
			PREV_PUSH <= REG_PUSH;
			if ( PREV_PUSH = '0' and REG_PUSH = '1') then
				COUNTER <= COUNTER + 1;
			end if;
		end if;
	end process;

	NUMBER_o <= std_logic_vector(COUNTER);

end Behavioral;
