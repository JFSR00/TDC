----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Juan Francisco Santos Relinque
-- 
-- Create Date: 02.05.2021 19:53:37
-- Design Name: 
-- Module Name: DATAPATH_0_TB - Behavioral
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
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity DATAPATH_0_tb is
end;

architecture bench of DATAPATH_0_tb is

  component DATAPATH_0
  	Generic( DATA_WIDTH : integer := 4;
  			 ADDR_WIDTH: integer := 4;
  			 ROM_WIDTH: integer := 11;
  			 ADDR_ROM_WIDTH: integer := 4;
  			 CW_WIDTH : integer := 10);
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
  
	constant DATA_WIDTH : integer := 4;
	constant ADDR_WIDTH: integer := 4;
	constant ROM_WIDTH: integer := 11;
	constant ADDR_ROM_WIDTH: integer := 4;
	constant CW_WIDTH : integer := 10;

  signal RST_i: STD_LOGIC;
  signal CLK_i: STD_LOGIC;
  signal CW_i: STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
  signal ADDR_RAM_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal RAM_OUT_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal ALU_OUT_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal REG_A_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal REG_B_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal PC_o: STD_LOGIC_VECTOR (ADDR_ROM_WIDTH-1 downto 0);
  signal INST_o: STD_LOGIC_VECTOR (ROM_WIDTH-1 downto 0);
  signal FZ_o: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: DATAPATH_0 generic map ( DATA_WIDTH     => DATA_WIDTH,
                                ADDR_WIDTH     => ADDR_WIDTH,
                                ROM_WIDTH      => ROM_WIDTH,
                                ADDR_ROM_WIDTH => ADDR_ROM_WIDTH,
                                CW_WIDTH       =>  CW_WIDTH)
                     port map ( RST_i          => RST_i,
                                CLK_i          => CLK_i,
                                CW_i           => CW_i,
                                ADDR_RAM_o     => ADDR_RAM_o,
                                RAM_OUT_o      => RAM_OUT_o,
                                ALU_OUT_o      => ALU_OUT_o,
                                REG_A_o        => REG_A_o,
                                REG_B_o        => REG_B_o,
                                PC_o           => PC_o,
                                INST_o         => INST_o,
                                FZ_o           => FZ_o );

stimulus: process
begin

	RST_i <= '1';
	wait for 5 ns;
	RST_i <= '0';
	wait for 5 ns;
	
	-- INSTRUCCION 1 ---------------------------------------------------------------------------
	CW_i <= B"00_01_010_000";	-- C1 Cargamos instruccion en registro de instruccion
	wait for 10 ns;
	CW_i <= B"00_00_000_000";	-- C2 Esparemos la actualizacion de la direccion de la RAM
	wait for 10 ns;
	CW_i <= B"00_00_000_100";	-- C3 Cargamos el registro A
	wait for 10 ns;
	CW_i <= B"00_00_100_000";	-- C4 Seleccionamos segunda direccion RAM
	wait for 10 ns;
	CW_i <= B"00_00_100_010";	-- C5 Cargamos el registro B
	wait for 10 ns;
	CW_i <= B"10_00_101_001";	-- C6 Realizamos add en ALU, actualizmos FZ y guargamos en memoria (direccion 1) el resultado
	wait for 10 ns;
	
	-- INSTRUCCION 2 ---------------------------------------------------------------------------
	CW_i <= B"00_01_010_000";	-- C1 Cargamos instruccion en registro de instruccion
	wait for 10 ns;
	CW_i <= B"00_00_000_000";	-- C2 Esparemos la actualizacion de la direccion de la RAM
	wait for 10 ns;
	CW_i <= B"00_00_000_100";	-- C3 Cargamos el registro A
	wait for 10 ns;
	CW_i <= B"00_00_101_001";	-- C6 Realizamos mov en ALU, actualizmos FZ y guargamos en memoria (direccion 1) el resultado
	wait for 10 ns;
	
	-- INSTRUCCION 3 ---------------------------------------------------------------------------
	CW_i <= B"00_01_010_000";	-- C1 Cargamos instruccion en registro de instruccion
	wait for 10 ns;
	CW_i <= B"00_00_000_000";	-- C2 Esparemos la actualizacion de la direccion de la RAM
	wait for 10 ns;
	CW_i <= B"00_00_000_100";	-- C3 Cargamos el registro A
	wait for 10 ns;
	CW_i <= B"01_00_001_001";	-- C6 Realizamos inc en ALU, actualizmos FZ y guargamos en memoria (direccion 0) el resultado
	wait for 10 ns;
	
	-- INSTRUCCION 4 ---------------------------------------------------------------------------
	CW_i <= B"00_01_010_000";	-- C1 Cargamos instruccion en registro de instruccion
	wait for 10 ns;
	CW_i <= B"00_00_000_000";	-- C2 Esparemos la actualizacion de la direccion de la RAM
	wait for 10 ns;
	CW_i <= B"00_00_000_100";	-- C3 Cargamos el registro A
	wait for 10 ns;
	CW_i <= B"00_00_100_000";	-- C4 Seleccionamos segunda direccion RAM
	wait for 10 ns;
	CW_i <= B"00_00_100_010";	-- C5 Cargamos el registro B
	wait for 10 ns;
	CW_i <= B"11_00_101_001";	-- C6 Realizamos sub en ALU, actualizmos FZ y guargamos en memoria el resultado
	wait for 10 ns;
	
	-- INSTRUCCION 5 ---------------------------------------------------------------------------
	CW_i <= B"00_01_010_000";	-- C1 Cargamos instruccion en registro de instruccion
	wait for 10 ns;
	CW_i <= B"00_11_000_000";	-- C2 Actualizamos PC desde direccion de salto de la instruccion
	wait for 10 ns;
	
	stop_the_clock <= true;
	wait;
end process;

clocking: process
begin
	while not stop_the_clock loop
		CLK_i <= '0', '1' after clock_period / 2;
		wait for clock_period;
	end loop;
	wait;
end process;

end;
