----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Juan Francisco Santos Relinque
-- 
-- Create Date: 05.05.2021 11:01:31
-- Design Name: 
-- Module Name: EdgeDetector_FSM - Behavioral
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

entity EdgeDetector_FSM is
	Generic(END_COUNT: integer:= 30000000);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           PUSH_i : in STD_LOGIC;
           PULSE_o : out STD_LOGIC);
end EdgeDetector_FSM;

architecture Behavioral of EdgeDetector_FSM is

type EdgeDetector_States is (inic, S0, S01, S_WAIT);
signal State: EdgeDetector_States;

signal PUSH: std_logic;
signal COUNTER : integer range 0 to END_COUNT;	-- Contador

begin

process (CLK_i, RST_i)
begin
	if RST_i = '1' then
		State <= inic;
		PUSH <= '0';
		COUNTER <= 0;
	elsif rising_edge(CLK_i) then
		case State is
			when inic =>	if PUSH = '0' then
								State <= S0;
							end if;
			when S0 =>		if PUSH = '1' then
								State <= S01;
							end if;
			when S01 =>		State <= S_WAIT;
			--				COUNTER <= (others =>'0');
			when S_WAIT =>	if COUNTER = END_COUNT then
								State <= inic;
								COUNTER <= 0;
							else
								COUNTER <= COUNTER + 1;
							end if;
			when others => State <= inic;
		end case;
		
		PUSH <= PUSH_i;
		
	end if;
end process;

with State select
	PULSE_o <=	'0' when inic,
				'0' when S0,
				'1' when S01,
				'0' when others;	--catch all

end Behavioral;
