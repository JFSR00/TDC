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
			 CW_WIDTH : integer := 10;
			 END_COUNT: integer:= 30000000);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           PUSH_i : in STD_LOGIC;
           INST_o : out STD_LOGIC_VECTOR (ROM_WIDTH-1 downto 0);
           FZ_o : out STD_LOGIC;
           ANODE_o : out STD_LOGIC_VECTOR (7 downto 0);
           CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0));
end TOP_00;

architecture Behavioral of TOP_00 is

-------------------------------------------------------------------------------------------
------------------------| Components declarations |-----------------------------------------
-------------------------------------------------------------------------------------------

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

component DISP7SEG_8ON is
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
end component;

component EdgeDetector_FSM is
	Generic(END_COUNT: integer:= END_COUNT);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           PUSH_i : in STD_LOGIC;
           PULSE_o : out STD_LOGIC);
end component;

-------------------------------------------------------------------------------------------
------------------------| Signals definitions |--------------------------------------------
-------------------------------------------------------------------------------------------

signal CW: std_logic_vector (CW_WIDTH-1 downto 0);
signal CW4: std_logic;
signal CW6: std_logic;
signal CW_CONCAT: std_logic_vector (CW_WIDTH-1 downto 0);

signal PUSH: std_logic;

-- Signals for displays inputs-----------------------
signal ADDR_RAM: STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
signal REG_A: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
signal REG_B: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
signal INST: std_logic_vector (ROM_WIDTH-1 downto 0);
signal PC: STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
signal DATA_BUS: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
signal ALU_OUT: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
signal FZ: std_logic;

begin
-------------------------------------------------------------------------------------------
------------------------| Component definitions |------------------------------------------
-------------------------------------------------------------------------------------------

DEBOUNCE_0 : EdgeDetector_FSM
	generic map(END_COUNT => END_COUNT)
	port map(
		CLK_i => CLK_i,
		RST_i => RST_i,
		PUSH_i => PUSH_i,
		PULSE_o => PUSH);

CONTROL_UNIT : CONT_UNIT_0
	generic map(
		COP_WIDTH => COP_WIDTH,
		CW_WIDTH => CW_WIDTH)
	port map(
		CLK_i => CLK_i,
		RST_i => RST_i,
		PUSH_i => PUSH,
		FZ_i => FZ,
		COP_i => INST(ROM_WIDTH-1 downto ROM_WIDTH-COP_WIDTH),
		CW_o => CW);
		
CW_4 : EdgeDetector_FSM
	generic map(END_COUNT => END_COUNT)
	port map(
		CLK_i => CLK_i,
		RST_i => RST_i,
		PUSH_i => CW(4),
		PULSE_o => CW4);

CW_6 : EdgeDetector_FSM
	generic map(END_COUNT => END_COUNT)
	port map(
		CLK_i => CLK_i,
		RST_i => RST_i,
		PUSH_i => CW(6),
		PULSE_o => CW6);
		
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
		CW_i => CW_CONCAT,
		ADDR_RAM_o => ADDR_RAM,
		RAM_OUT_o => DATA_BUS,
		ALU_OUT_o => ALU_OUT,
		REG_A_o => REG_A,
		REG_B_o => REG_B,
		PC_o => PC,
		INST_o => INST,
		FZ_o => FZ);
		
my_disp7seg_8on : DISP7SEG_8ON
	generic map(DATA_WIDTH => DATA_WIDTH)
	port map(
		CLK_i => CLK_i,
		RST_i => RST_i,
		DATA0_i => ALU_OUT,
		DATA1_i => DATA_BUS,
		DATA2_i => REG_B,
		DATA3_i => REG_A,
		DATA4_i => ADDR_RAM,
		DATA5_i => PC,
		DATA6_i => (others => '0'),
		DATA7_i => (others => '0'),
		ANODE_o => ANODE_o,
		CATHODE_o => CATHODE_o);
		
CW_CONCAT <= CW(CW_WIDTH-1 downto 7) & CW6 & CW(5) & CW4 & CW(3 downto 0);

FZ_o <= FZ;

INST_o <= INST;

end Behavioral;
