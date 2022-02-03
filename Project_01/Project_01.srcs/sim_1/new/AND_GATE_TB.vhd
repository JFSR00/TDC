----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.02.2021 10:34:52
-- Design Name: 
-- Module Name: AND_GATE_TB - Behavioral
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

entity AND_GATE_tb is
end;

architecture bench of AND_GATE_tb is

  component AND_GATE
      Port ( A_i, B_i : in STD_LOGIC;
             Z_o : out STD_LOGIC);
  end component;

  signal A_i, B_i: STD_LOGIC;
  signal Z_o: STD_LOGIC;

begin
  uut: AND_GATE port map ( A_i => A_i,
                           B_i => B_i,
                           Z_o => Z_o );
  stimulus: process
  begin
        --
        --  Combination 1: It lasts 40ns
        --
        A_i <= '0';
        B_i <= '0';
        wait for 40 ns;
        --
        --  Combination 2: It lasts 40ns
        --
        A_i <= '0';
        B_i <= '1';
        wait for 40 ns;
        --
        --  Combination 3: It lasts 40ns
        --
        A_i <= '1';
        B_i <= '0';
        wait for 40 ns;
        --
        --  Combination 4: It lasts 40ns
        --
        A_i <= '1';
        B_i <= '1';
        wait for 40 ns;
    wait;
  end process;
end;
