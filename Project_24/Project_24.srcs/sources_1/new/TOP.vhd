----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Juan Francisco Santos Relinque
-- 
-- Create Date: 14.04.2021 11:27:11
-- Design Name: 
-- Module Name: TOP - Behavioral
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

entity TOP is
    generic( DATA_WIDTH : integer := 4;
             ADDR_WIDTH: integer := 4;
			 CW_WIDTH : integer := 6);
    Port ( ADDR_BUS_i : in STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
           FZ_o : out STD_LOGIC;
           ANODE_o : out STD_LOGIC_VECTOR (7 downto 0);
           CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0));
end TOP;

architecture Behavioral of TOP is

component DATAPATH_0 is
	generic( DATA_WIDTH : integer := DATA_WIDTH;
			 ADDR_WIDTH : integer := ADDR_WIDTH;
			 CW_WIDTH : integer := CW_WIDTH);
    Port ( ADDR_BUS_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
           RAM_OUT_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           ALU_OUT_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_A_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_B_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           FZ_o : out STD_LOGIC);
end component;

component DISP7SEG_8ON is
    generic (DATA_WIDTH: integer:= DATA_WIDTH);
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
end component;

signal DATA_BUS: std_logic_vector(DATA_WIDTH-1 downto 0);
signal ALU_OUT: std_logic_vector(DATA_WIDTH-1 downto 0);
signal REG_A: std_logic_vector(DATA_WIDTH-1 downto 0);
signal REG_B: std_logic_vector(DATA_WIDTH-1 downto 0);

begin

DATAPATH : DATAPATH_0
	generic map(
		DATA_WIDTH => DATA_WIDTH,
		ADDR_WIDTH => ADDR_WIDTH,
		CW_WIDTH => CW_WIDTH)
	port map(
		ADDR_BUS_i => ADDR_BUS_i,
		RST_i => RST_i,
		CLK_i => CLK_i,
		CW_i => CW_i,
		RAM_OUT_o => DATA_BUS,
		ALU_OUT_o => ALU_OUT,
		REG_A_o => REG_A,
		REG_B_o => REG_B,
		FZ_o => FZ_o);
		
DISPLAY : DISP7SEG_8ON
    generic map(DATA_WIDTH => DATA_WIDTH)
    port map(
        CLK_i => CLK_i,
        RST_i => RST_i,
        DATA0_i => ALU_OUT,
        DATA1_i => REG_B,
        DATA2_i => REG_A,
        DATA3_i => DATA_BUS,
        DATA4_i => ADDR_BUS_i,
        DATA5_i => (others => '0'),
        DATA6_i => (others => '0'),
        DATA7_i => (others => '0'),
        ANODE_o => ANODE_o,
        CATHODE_o => CATHODE_o);

end Behavioral;
