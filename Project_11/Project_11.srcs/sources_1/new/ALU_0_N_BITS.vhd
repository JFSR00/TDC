----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2021 11:31:15
-- Design Name: 
-- Module Name: ALU_0_N_BITS - Behavioral
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

entity ALU_0_N_BITS is
	generic(WIDTH: integer:=4);
    Port ( A_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           B_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           OP_i : in STD_LOGIC_VECTOR (1 downto 0);
           RESULT_o : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           ZERO_F_o : out STD_LOGIC);
end ALU_0_N_BITS;

architecture Behavioral of ALU_0_N_BITS is

constant ZERO: std_logic_vector(WIDTH-1 downto 0):= (others => '0');
signal RESULT: std_logic_vector(WIDTH-1 downto 0);

begin
	
	with OP_i select
	RESULT <= A_i when "00",
				std_logic_vector(unsigned(A_i) + 1) when "01",
				std_logic_vector(unsigned(A_i) + unsigned(B_i)) when "10",
				std_logic_vector(unsigned(A_i) - unsigned(B_i)) when "11",
				ZERO when others;
	
	RESULT_o <= RESULT;
	
	ZERO_F_o <= '1' when RESULT = ZERO else '0';

end Behavioral;
