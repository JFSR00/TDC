----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.02.2021 13:54:19
-- Design Name: 
-- Module Name: XOR_GATE_TB - Behavioral
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

entity XOR_GATE_tb is
end;

architecture bench of XOR_GATE_tb is

  component XOR_GATE
      generic (WIDTH: integer:= 2);
      Port ( A_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
             B_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
             Z_o : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
  end component;

  constant WIDTH: integer:= 2;

  signal A_i: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
  signal B_i: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
  signal Z_o: STD_LOGIC_VECTOR (WIDTH-1 downto 0);

begin

  -- Insert values for generic parameters !!
  uut: XOR_GATE generic map ( WIDTH => WIDTH )
                   port map ( A_i   => A_i,
                              B_i   => B_i,
                              Z_o   => Z_o );

  A_B: process
    begin
        A_i <= "00";
        B_i <= "11";
        wait for 80 ns;
        
        A_i <= "01";
        B_i <= "10";
        wait for 80 ns;
        
        A_i <= "00";
        B_i <= "00";
        wait for 80 ns;
    end process;
end architecture bench;
