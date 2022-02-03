----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.02.2021 13:04:41
-- Design Name: 
-- Module Name: MUX2_1bit - Behavioral
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

entity MUX2_1bit is
    Port ( A_i : in STD_LOGIC;
           B_i : in STD_LOGIC;
           SEL_i : in STD_LOGIC;
           Y_o : out STD_LOGIC);
end MUX2_1bit;

architecture Behavioral of MUX2_1bit is

begin

    -- Multiplexer description by means of
    -- a conditional concurrent assignment statement
    
    Y_o <= A_i when SEL_i = '0' else B_i;

end Behavioral;
