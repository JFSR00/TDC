----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.03.2021 12:54:05
-- Design Name: 
-- Module Name: FFD_Basic - Behavioral
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

entity FFD_Basic is
    Port ( D_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           Q_o : out STD_LOGIC);
end FFD_Basic;

architecture Behavioral of FFD_Basic is

begin
	process(CLK_i)
	begin
		if rising_edge(CLK_i) then
			Q_o<= D_i; -- Sentencia s?ncrona
		end if;
	end process;

end Behavioral;
