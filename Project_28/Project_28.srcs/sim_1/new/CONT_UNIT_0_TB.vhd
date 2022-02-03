----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2021 19:38:42
-- Design Name: 
-- Module Name: CONT_UNIT_0_TB - Behavioral
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

entity CONT_UNIT_0_tb is
end;

architecture bench of CONT_UNIT_0_tb is

  component CONT_UNIT_0
  	Generic(COP_WIDTH: integer:= 4;
  			CW_WIDTH: integer:= 10);
      Port ( CLK_i : in STD_LOGIC;
             RST_i : in STD_LOGIC;
             PUSH_i : in STD_LOGIC;
             FZ_i : in STD_LOGIC;
             COP_i : in STD_LOGIC_VECTOR (COP_WIDTH-1 downto 0);
             CW_o : out STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0));
  end component;

  constant COP_WIDTH: integer:= 4;
  constant CW_WIDTH: integer:= 10;

  signal CLK_i: STD_LOGIC;
  signal RST_i: STD_LOGIC;
  signal PUSH_i: STD_LOGIC;
  signal FZ_i: STD_LOGIC;
  signal COP_i: STD_LOGIC_VECTOR (COP_WIDTH-1 downto 0);
  signal CW_o: STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: CONT_UNIT_0 generic map ( COP_WIDTH => COP_WIDTH,
                                 CW_WIDTH  => CW_WIDTH )
                      port map ( CLK_i     => CLK_i,
                                 RST_i     => RST_i,
                                 PUSH_i    => PUSH_i,
                                 FZ_i      => FZ_i,
                                 COP_i     => COP_i,
                                 CW_o      => CW_o );

  stimulus: process
  begin
  
    -- Put initialisation code here

    RST_i <= '1';
    wait for 5 ns;
    RST_i <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here
    PUSH_i <= '0';
    FZ_i <= '0';
    COP_i <= "0000";	-- MOV A
    wait for 40 ns;
    
    COP_i <= "0010";	-- ADD A, B
    wait for 60 ns;
    
    COP_i <= "0100";	-- JMP
    wait for 30 ns;
    
    FZ_i <= '1';
    COP_i <= "0100";	-- BEZ
    wait for 50 ns;

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
