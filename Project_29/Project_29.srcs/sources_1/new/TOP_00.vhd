----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Juan Francisco Santos Relinque
-- 
-- Create Date: 19.05.2021 10:53:40
-- Design Name: 
-- Module Name: TOP_00 - Behavioral
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

entity TOP_00 is
	Generic( DATA_WIDTH : integer := 4;
			 ADDR_WIDTH: integer := 4;
			 ROM_WIDTH: integer := 12;
			 ADDR_ROM_WIDTH: integer := 4;
			 COP_WIDTH: integer:= 4;
			 CW_WIDTH : integer := 10);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           ADDR1_o : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           ADDR2_o : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           REG_A_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_B_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           INST_o : out STD_LOGIC_VECTOR (ROM_WIDTH-1 downto 0);
           PC_o : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           DATA_BUS_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           ALU_OUT_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           FZ_o : out STD_LOGIC);
end TOP_00;

architecture Behavioral of TOP_00 is

component CONT_UNIT_0 is
	Generic(COP_WIDTH: integer:= 4;
			CW_WIDTH: integer:= 10);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           PUSH_i : in STD_LOGIC;
           FZ_i : in STD_LOGIC;
           COP_i : in STD_LOGIC_VECTOR (COP_WIDTH-1 downto 0);
           CW_o : out STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0));
end component;

component DATAPATH_0 is
	Generic( DATA_WIDTH : integer := 4;
			 ADDR_WIDTH: integer := 4;
			 ROM_WIDTH: integer := 12;
			 ADDR_ROM_WIDTH: integer := 4;
			 CW_WIDTH : integer := 10;
			 COP_WIDTH: integer := 4);

    Port ( RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
           ADDR_RAM_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           RAM_OUT_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           ALU_OUT_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_A_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_B_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           PC_o : out STD_LOGIC_VECTOR (ADDR_ROM_WIDTH-1 downto 0);
           INST_o : out STD_LOGIC_VECTOR (ROM_WIDTH-1 downto 0);
           FZ_o : out STD_LOGIC);
end component;

signal CW: std_logic_vector (CW_WIDTH-1 downto 0);
signal FZ: std_logic;
signal INST: std_logic_vector (ROM_WIDTH-1 downto 0);

begin

CONTROL_UNIT : CONT_UNIT_0
	generic map(
		COP_WIDTH => COP_WIDTH,
		CW_WIDTH => CW_WIDTH)
	port map(
		CLK_i => CLK_i,
		RST_i => RST_i,
		PUSH_i => '0',
		FZ_i => FZ,
		COP_i => INST(ROM_WIDTH-1 downto ROM_WIDTH-COP_WIDTH),
		CW_o => CW);
		
DIDACOMP : DATAPATH_0
	generic map(
		DATA_WIDTH => DATA_WIDTH,
		ADDR_WIDTH => ADDR_WIDTH,
		ROM_WIDTH => ROM_WIDTH,
		ADDR_ROM_WIDTH => ADDR_ROM_WIDTH,
		CW_WIDTH => CW_WIDTH,
		COP_WIDTH => COP_WIDTH)
	port map(
		RST_i => RST_i,
		CLK_i => CLK_i,
		CW_i => CW,
		ADDR_RAM_o => ADDR1_o,
		RAM_OUT_o => ADDR2_o,
		ALU_OUT_o => ALU_OUT_o,
		REG_A_o => REG_A_o,
		REG_B_o => REG_B_o,
		PC_o => PC_o,
		INST_o => INST,
		FZ_o => FZ);

FZ_o <= FZ;

INST_o <= INST;

end Behavioral;
