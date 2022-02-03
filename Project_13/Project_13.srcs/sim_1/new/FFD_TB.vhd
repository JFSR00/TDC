----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.03.2021 13:41:31
-- Design Name: 
-- Module Name: FFD_TB - Behavioral
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

entity FFD_tb is
end;

architecture bench of FFD_tb is

  component FFD
      Port ( D_i : in STD_LOGIC;
             ENA_i : in STD_LOGIC;
             RST_i : in STD_LOGIC;
             CLK_i : in STD_LOGIC;
             Q_o : out STD_LOGIC);
  end component;

  signal D_i: STD_LOGIC;
  signal ENA_i: STD_LOGIC;
  signal RST_i: STD_LOGIC;
  signal CLK_i: STD_LOGIC;
  signal Q_o: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: FFD port map ( D_i   => D_i,
                      ENA_i => ENA_i,
                      RST_i => RST_i,
                      CLK_i => CLK_i,
                      Q_o   => Q_o );

  stimulus: process
  begin
  
    -- Put initialisation code here

    RST_i <= '1';
    wait for 10 ns;
    RST_i <= '0';
    wait for 10 ns;

	D_i<='0';
  	wait for 40ns;
  	D_i<='1';
  	wait for 10ns;
  	ENA_i<='1';
  	wait for 50ns;
  	D_i<='0';
  	wait for 40ns;

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
