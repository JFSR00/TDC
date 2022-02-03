----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.04.2021 14:17:25
-- Design Name: 
-- Module Name: DISP7SEG_8ON_TB - Behavioral
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

entity DISP7SEG_8ON_tb is
end;

architecture bench of DISP7SEG_8ON_tb is

  component DISP7SEG_8ON
      generic (DATA_WIDTH: integer:= 4);
      Port ( CLK_i : in STD_LOGIC;
             RST_i : in STD_LOGIC;
             DATA0_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             DATA2_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             DATA4_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             DATA7_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             ANODE_o : out STD_LOGIC_VECTOR (7 downto 0);
             CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0));
  end component;

  signal CLK_i: STD_LOGIC;
  signal RST_i: STD_LOGIC;
  signal DATA0_i: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal DATA2_i: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal DATA4_i: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal DATA7_i: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal ANODE_o: STD_LOGIC_VECTOR (7 downto 0);
  signal CATHODE_o: STD_LOGIC_VECTOR (6 downto 0);

begin

  -- Insert values for generic parameters !!
  uut: DISP7SEG_8ON generic map ( DATA_WIDTH =>  4)
                       port map ( CLK_i      => CLK_i,
                                  RST_i      => RST_i,
                                  DATA0_i    => DATA0_i,
                                  DATA2_i    => DATA2_i,
                                  DATA4_i    => DATA4_i,
                                  DATA7_i    => DATA7_i,
                                  ANODE_o    => ANODE_o,
                                  CATHODE_o  => CATHODE_o );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    wait;
  end process;


end;
