----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2021 13:33:40
-- Design Name: 
-- Module Name: FSM_EX00 - Behavioral
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

entity FSM_EX00 is
	Generic(N_LEDS: integer:= 16);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           LED_o : out STD_LOGIC_VECTOR (15 downto 0));
end FSM_EX00;

architecture Behavioral of FSM_EX00 is

component CE_N_Hz is
	generic( END_COUNT: integer := 1000000);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           CLK_N_Hz_o : out STD_LOGIC);
end component;

component KITT is
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           MSB_i : in STD_LOGIC;
           LSB_i : in STD_LOGIC;
           DIR_o : out STD_LOGIC);
end component;

component ROT_REG is
	Generic(N_LEDS: integer:= N_LEDS);
    Port ( CLK_i : in STD_LOGIC;
    	   RST_i : in STD_LOGIC;
           ENA_i : in STD_LOGIC;
           L_R_i : in STD_LOGIC;
           LED_o : out STD_LOGIC_VECTOR (N_LEDS-1 downto 0));
end component;

signal CLK: std_logic;
signal DIR: std_logic;
signal LEDS: std_logic_vector(N_LEDS-1 downto 0);

begin

my_ce_n_hz : CE_N_Hz
	generic map(END_COUNT => 10000000)
	port map(
		CLK_i => CLK_i,
		RST_i => RST_i,
		CLK_N_Hz_o => CLK); 

my_kitt : KITT
	port map(
		CLK_i => CLK_i,
		RST_i => RST_i,
		MSB_i => LEDS(N_LEDS-1),
		LSB_i => LEDS(0),
		DIR_o => DIR);

my_rot_reg : ROT_REG
	generic map(N_LEDS => N_LEDS)
	port map(
		CLK_i => CLK_i,
		RST_i => RST_i,
		ENA_i => CLK,
		L_R_i => DIR,
		LED_o => LEDS);

LED_o <= LEDS;

end Behavioral;
