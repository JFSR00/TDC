----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2021 10:43:35
-- Design Name: 
-- Module Name: FSM_EX00_TB - Behavioral
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

entity FSM_EX00_tb is
end;

architecture bench of FSM_EX00_tb is

  component FSM_EX00
  	Generic(N_LEDS: integer:= 16);
      Port ( CLK_i : in STD_LOGIC;
             RST_i : in STD_LOGIC;
             LED_o : out STD_LOGIC_VECTOR (15 downto 0));
  end component;
	constant N_LEDS: integer:= 16;
  
    signal CLK_i: STD_LOGIC;
    signal RST_i: STD_LOGIC;
    signal LED_o: STD_LOGIC_VECTOR (N_LEDS-1 downto 0);
  
    constant clock_period: time := 10 ns;
    signal stop_the_clock: boolean;
  
  begin
  
    -- Insert values for generic parameters !!
    uut: FSM_EX00 generic map ( N_LEDS => N_LEDS )
                 port map ( CLK_i  => CLK_i,
                            RST_i  => RST_i,
                            LED_o  => LED_o );
  
    stimulus: process
    begin
    
      -- Put initialisation code here
  
      RST_i <= '1';
      wait for 5 ns;
      RST_i <= '0';
      wait for 5 ns;
  
      -- Put test bench stimulus code here
      wait for 200 ns;
  
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