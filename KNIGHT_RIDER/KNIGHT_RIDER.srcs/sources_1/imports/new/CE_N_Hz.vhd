----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Juan Francisco Santos Relinque
-- 
-- Create Date: 24.03.2021 10:52:25
-- Design Name: 
-- Module Name: CE_N_Hz - Behavioral
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

entity CE_N_Hz is
	generic( END_COUNT: integer := 1000000);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           CLK_N_Hz_o : out STD_LOGIC);
end CE_N_Hz;

architecture Behavioral of CE_N_Hz is
--constant END_C: integer := 100;
signal COUNTER: integer range 0 to END_COUNT;

begin

	process(CLK_i, RST_i)
	begin
		---------------------------------------------------
		-- RESET pone a 0 el contador y el puerto de salida
		---------------------------------------------------
		if RST_i='1' then
			COUNTER <= 0;
			CLK_N_Hz_o <= '0';
		-------------------------------------------------------------
		-- Mantiene a 0 la salida hasta que transcurren 10.000 ciclos
		-- Entonces asigna '1' a la salida durante un ciclo de CLK
		-------------------------------------------------------------
		elsif rising_edge(CLK_i) then
			if COUNTER = END_COUNT - 1 then -- Si ya ha contado 100.000 ciclos de CLK
				COUNTER <= 0;				-- Pone el contador a 0
				CLK_N_Hz_o <= '1';			-- Manda un '1' durante un ciclo de CLK
			else
				COUNTER <= COUNTER + 1;		-- Si no ha llegado al final de la cuenta
											-- incrementa la cuenta de ciclo
				CLK_N_Hz_o <= '0';			-- Mantiene la salida a '0', no hay pulso
			end if;
		end if;
	end process;


end Behavioral;
