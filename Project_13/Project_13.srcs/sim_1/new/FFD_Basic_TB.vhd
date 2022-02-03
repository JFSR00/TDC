----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.03.2021 12:56:57
-- Design Name: 
-- Module Name: FFD_Basic_TB - Behavioral
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

entity FFD_Basic_tb is
end;

architecture bench of FFD_Basic_tb is

  component FFD_Basic
      Port ( D_i : in STD_LOGIC;
             CLK_i : in STD_LOGIC;
             Q_o : out STD_LOGIC);
  end component;

  signal D_i: STD_LOGIC;
  signal CLK_i: STD_LOGIC;
  signal Q_o: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: FFD_Basic port map ( D_i   => D_i,
                            CLK_i => CLK_i,
                            Q_o   => Q_o );

  stimulus: process
  begin
  	D_i<='0';
  	wait for 40ns;
  	D_i<='1';
  	wait for 60ns;
  	D_i<='0';
  	wait for 40ns;

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
