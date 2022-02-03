----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Juan Francisco Santos Relinque
-- 
-- Create Date: 07.03.2021 19:21:58
-- Design Name: 
-- Module Name: DECO_N_BITS - Behavioral
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

entity DECO_N_BITS is
	generic(N: integer:= 4);
    Port ( A_i : in STD_LOGIC_VECTOR (N-1 downto 0);
           Z_o : out STD_LOGIC_VECTOR ((2**N)-1 downto 0));
end DECO_N_BITS;

architecture Behavioral of DECO_N_BITS is
-- Solucion Mirian
--constant COD_DECO: std_logic_vector((2**N)-1 downto 0):=(0=>'1', others=>'0');
begin
--	Z_o <= std_logic_vector(unsigned(COD_DECO) sll to_integer(unsigned(A_i)));

-- Mi solucion
	main: process(A_i)
	constant ZERO: std_logic_vector((2**N)-1 downto 0):= (others => '0');
	begin
		Z_o <= ZERO;
		Z_o(to_integer(unsigned(A_i))) <= '1';
	end process main;

end Behavioral;
