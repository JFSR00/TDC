----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Juan Francisco Santos Relinque
-- 
-- Create Date: 23.05.2021 18:31:40
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
  			 CW_WIDTH : integer := 10;
  			 END_COUNT: integer:= 30000000);
      Port ( CLK_i : in STD_LOGIC;
             RST_i : in STD_LOGIC;
             PUSH_i : in STD_LOGIC;
             INST_o : out STD_LOGIC_VECTOR (ROM_WIDTH-1 downto 0);
             FZ_o : out STD_LOGIC;
             ANODE_o : out STD_LOGIC_VECTOR (7 downto 0);
             CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0));
  end component;
  constant DATA_WIDTH : integer := 4;
  constant ADDR_WIDTH: integer := 4;
  constant ROM_WIDTH: integer := 12;
  constant ADDR_ROM_WIDTH: integer := 4;
  constant COP_WIDTH: integer:= 4;
  constant CW_WIDTH : integer := 10;
  constant END_COUNT: integer:= 3;			-- I set this at 3 for making easy to see the simulation 

  signal CLK_i: STD_LOGIC;
  signal RST_i: STD_LOGIC;
  signal PUSH_i: STD_LOGIC;
  signal INST_o: STD_LOGIC_VECTOR (ROM_WIDTH-1 downto 0);
  signal FZ_o: STD_LOGIC;
  signal ANODE_o: STD_LOGIC_VECTOR (7 downto 0);
  signal CATHODE_o: STD_LOGIC_VECTOR (6 downto 0);
  
  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: TOP_00 generic map ( DATA_WIDTH     => DATA_WIDTH,
                            ADDR_WIDTH     => ADDR_WIDTH,
                            ROM_WIDTH      => ROM_WIDTH,
                            ADDR_ROM_WIDTH => ADDR_ROM_WIDTH,
                            COP_WIDTH      => COP_WIDTH,
                            CW_WIDTH       => CW_WIDTH,
                            END_COUNT      =>  END_COUNT)	-- I set this at 3 for making easy to see the simulation 
                 port map ( CLK_i          => CLK_i,
                            RST_i          => RST_i,
                            PUSH_i         => PUSH_i,
                            INST_o         => INST_o,
                            FZ_o           => FZ_o,
                            ANODE_o        => ANODE_o,
                            CATHODE_o      => CATHODE_o );

  stimulus: process
  begin
  
  	RST_i <= '1';
  	wait for 5 ns;
  	RST_i <= '0';
  	wait for 5 ns;
  
-- First iteration
    PUSH_i <= '1';
    wait for 60 ns;
    
    PUSH_i <= '0';
    wait for 10 ns;
    
--  Second iteration
    PUSH_i <= '1';
    wait for 10 ns;
    
    PUSH_i <= '0';
    wait for 30 ns;

-- Third iteration
    PUSH_i <= '1';
	wait for 10 ns;
	
	PUSH_i <= '0';
	wait for 30 ns;

-- Fourth iteration
	PUSH_i <= '1';
	wait for 10 ns;
	
	PUSH_i <= '0';
	wait for 30 ns;

-- Fifth iteration
	PUSH_i <= '1';
	wait for 10 ns;
	
	PUSH_i <= '0';
	wait for 30 ns;

-- Sixth iteration
	PUSH_i <= '1';
	wait for 10 ns;
	
	PUSH_i <= '0';
	wait for 30 ns;

-- Seventh iteration
	PUSH_i <= '1';
	wait for 10 ns;
	
	PUSH_i <= '0';
	wait for 30 ns;

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