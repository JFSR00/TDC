----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2021 12:22:17
-- Design Name: 
-- Module Name: ALU_0_N_BITS_TB - Behavioral
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

entity ALU_0_N_BITS_tb is
end;

architecture bench of ALU_0_N_BITS_tb is

  component ALU_0_N_BITS
  	generic(WIDTH: integer:=4);
      Port ( A_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
             B_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
             OP_i : in STD_LOGIC_VECTOR (1 downto 0);
             RESULT_o : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
             ZERO_F_o : out STD_LOGIC);
  end component;

	constant WIDTH: integer:= 4;
	signal A_i: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
	signal B_i: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
	signal OP_i: STD_LOGIC_VECTOR (1 downto 0);
	signal RESULT_o: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
	signal ZERO_F_o: STD_LOGIC;

begin

  -- Insert values for generic parameters !!
  uut: ALU_0_N_BITS generic map ( WIDTH    =>  WIDTH)
                       port map ( A_i      => A_i,
                                  B_i      => B_i,
                                  OP_i     => OP_i,
                                  RESULT_o => RESULT_o,
                                  ZERO_F_o => ZERO_F_o );

stimulus: process
begin
	
	
	
wait;
end process;


end;
