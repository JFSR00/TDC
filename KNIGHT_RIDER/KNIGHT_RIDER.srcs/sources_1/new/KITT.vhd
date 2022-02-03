----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2021 13:37:47
-- Design Name: 
-- Module Name: KITT - Behavioral
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

entity KITT is
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           MSB_i : in STD_LOGIC;
           LSB_i : in STD_LOGIC;
           DIR_o : out STD_LOGIC);
end KITT;

architecture Behavioral of KITT is

type FSM_States is (DCH, IZQ); 
signal State: FSM_States;

begin

process (CLK_i, RST_i)
begin
	if RST_i = '1' then
		State <= IZQ;
	elsif rising_edge(CLK_i) then
		case State is
			when DCH => if LSB_i = '1' then
							State <= IZQ;
						end if;
			when IZQ => if MSB_i = '1' then
							State <= DCH;
						end if;
			when others => State <= IZQ;
		end case;
	end if;
end process;

DIR_o <= '1' when State = IZQ else '0';

end Behavioral;
