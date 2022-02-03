----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2021 11:15:08
-- Design Name: 
-- Module Name: TOP_00_TB - Behavioral
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

entity TOP_00_tb is
end;

architecture bench of TOP_00_tb is

  component TOP_00
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
  end component;
  
  constant DATA_WIDTH : integer := 4;
  constant ADDR_WIDTH: integer := 4;
  constant ROM_WIDTH: integer := 12;
  constant ADDR_ROM_WIDTH: integer := 4;
  constant COP_WIDTH: integer:= 4;
  constant CW_WIDTH : integer := 10;

  signal CLK_i: STD_LOGIC;
  signal RST_i: STD_LOGIC;
  signal ADDR1_o: STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
  signal ADDR2_o: STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
  signal REG_A_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal REG_B_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal INST_o: STD_LOGIC_VECTOR (ROM_WIDTH-1 downto 0);
  signal PC_o: STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
  signal DATA_BUS_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal ALU_OUT_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal FZ_o: STD_LOGIC;
  
  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: TOP_00 generic map ( DATA_WIDTH     => DATA_WIDTH,
                            ADDR_WIDTH     => ADDR_WIDTH,
                            ROM_WIDTH      => ROM_WIDTH,
                            ADDR_ROM_WIDTH => ADDR_ROM_WIDTH,
                            COP_WIDTH      => COP_WIDTH,
                            CW_WIDTH       =>  CW_WIDTH)
                 port map ( CLK_i          => CLK_i,
                            RST_i          => RST_i,
                            ADDR1_o        => ADDR1_o,
                            ADDR2_o        => ADDR2_o,
                            REG_A_o        => REG_A_o,
                            REG_B_o        => REG_B_o,
                            INST_o         => INST_o,
                            PC_o           => PC_o,
                            DATA_BUS_o     => DATA_BUS_o,
                            ALU_OUT_o      => ALU_OUT_o,
                            FZ_o           => FZ_o );

  stimulus: process
  begin
  
  	RST_i <= '1';
  	wait for 5 ns;
  	RST_i <= '0';
  	wait for 5 ns;
  
    -- Put initialisation code here

	wait for 500 ns;

    -- Put test bench stimulus code here

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