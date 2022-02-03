----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Juan Francisco Santos Relinque
-- 
-- Create Date: 03.03.2021 13:44:18
-- Design Name: 
-- Module Name: ALU_1_N_BITS_TB - Behavioral
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

entity ALU_1_N_BITS_tb is
end;

architecture bench of ALU_1_N_BITS_tb is

  component ALU_1_N_BITS
  	generic(WIDTH: integer:=4);
      Port ( A_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
             B_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
             OP_i : in STD_LOGIC_VECTOR (2 downto 0);
             RESULT_o : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
             ZERO_F_o : out STD_LOGIC;
             CARRY_F_o : out STD_LOGIC);
  end component;

	constant WIDTH: integer:= 4;
	signal A_i: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
	signal B_i: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
	signal OP_i: STD_LOGIC_VECTOR (2 downto 0);
	signal RESULT_o: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
	signal ZERO_F_o: STD_LOGIC;
	signal CARRY_F_o: STD_LOGIC;

begin

  -- Insert values for generic parameters !!
  uut: ALU_1_N_BITS generic map ( WIDTH     => WIDTH)
                       port map ( A_i       => A_i,
                                  B_i       => B_i,
                                  OP_i      => OP_i,
                                  RESULT_o  => RESULT_o,
                                  ZERO_F_o  => ZERO_F_o,
                                  CARRY_F_o => CARRY_F_o );

stimulus: process
begin
	A_i <= "1111";
	B_i <= "1111";
	
	OP_i <= "000";
	wait for 50 ns;
	OP_i <= "001";
	wait for 50 ns;
	OP_i <= "010";
	wait for 50 ns;
	OP_i <= "011";
	wait for 50 ns;
	OP_i <= "100";
	wait for 50 ns;
	OP_i <= "101";
	wait for 50 ns;
	OP_i <= "110";
	wait for 50 ns;
	OP_i <= "111";
	wait for 50 ns;

end process;

end;
