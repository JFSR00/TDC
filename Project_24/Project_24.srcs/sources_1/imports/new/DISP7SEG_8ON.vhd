----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.04.2021 12:57:23
-- Design Name: 
-- Module Name: DISP7SEG_8ON - Behavioral
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

entity DISP7SEG_8ON is
    generic (DATA_WIDTH: integer:= 4);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           DATA0_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA1_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA2_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA3_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA4_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA5_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA6_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA7_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           ANODE_o : out STD_LOGIC_VECTOR (7 downto 0);
           CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0));
end DISP7SEG_8ON;

architecture Behavioral of DISP7SEG_8ON is

component DISP7SEG is
    Port ( BINARY_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DISPLAY_i : in STD_LOGIC_VECTOR (2 downto 0);
           CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0);
           ANODE_o : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component COUNTER_N_bits is
	generic (DATA_WIDTH: integer:=3);
	Port (	CLK_i : in STD_LOGIC;
			RST_i : in STD_LOGIC;
			ENA_i : in STD_LOGIC;
			Q_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0));
			--Q_o : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component CE_N_Hz is
	generic( END_COUNT: integer := 1000);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           CLK_N_Hz_o : out STD_LOGIC);
end component;
----------------------------------------------------------------------
-- Señales usadas para las conexiones
----------------------------------------------------------------------
signal DATA: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);  -- Dígito a mostrar
signal S_DISPLAY: STD_LOGIC_VECTOR (2 downto 0);        -- Posición del dígito
signal ENABLE: STD_LOGIC;                               -- Activación del contador

begin

----------------------------------------------------------------------
-- Controlador del display
----------------------------------------------------------------------
my_disp7seg : DISP7SEG
	port map(
		BINARY_i => DATA,
		DISPLAY_i => S_DISPLAY,
		CATHODE_o => CATHODE_o,
		ANODE_o => ANODE_o);
		
----------------------------------------------------------------------
-- Contador de 3 bits
----------------------------------------------------------------------
my_counter_n_bits : COUNTER_N_bits
    generic map(DATA_WIDTH => 3)
    port map(
        CLK_i => CLK_i,
        RST_i => RST_i,
        ENA_i => ENABLE,
        Q_o => S_DISPLAY);
                
----------------------------------------------------------------------
-- Preescaler a 1KHz
----------------------------------------------------------------------
my_ce_n_hz : CE_N_Hz
    generic map(END_COUNT => 1000)
    port map(
        CLK_i => CLK_i,
        RST_i => RST_i,
        CLK_N_Hz_o => ENABLE);

----------------------------------------------------------------------
-- Selector de entrada de dato
----------------------------------------------------------------------
with S_DISPLAY select
        DATA <= DATA0_i when "000",
               DATA1_i when "001",
               DATA2_i when "010",
               DATA3_i when "011",
               DATA4_i when "100",
               DATA5_i when "101",
               DATA6_i when "110",
               DATA7_i when "111",
               "0000" when others;

end Behavioral;
