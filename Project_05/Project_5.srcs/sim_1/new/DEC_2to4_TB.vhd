library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity DEC_2to4_tb is
end;

architecture bench of DEC_2to4_tb is

  component DEC_2to4
      Port ( A_i : in STD_LOGIC_VECTOR (1 downto 0);
             ENA_i : in STD_LOGIC;
             Z_o : out STD_LOGIC_VECTOR (3 downto 0));
  end component;

  signal A_i: STD_LOGIC_VECTOR (1 downto 0);
  signal ENA_i: STD_LOGIC;
  signal Z_o: STD_LOGIC_VECTOR (3 downto 0);

begin

  uut: DEC_2to4 port map ( A_i   => A_i,
                           ENA_i => ENA_i,
                           Z_o   => Z_o );

  stimulus: process
  begin
    ENA_i <= '0';
    wait for 40 ns;
    
    ENA_i <= '1';
    
    A_i <= "00";
    wait for 40 ns;
    
    A_i <= "01";
    wait for 40 ns;
    
    A_i <= "10";
    wait for 40 ns;
    
    A_i <= "11";
    wait for 40 ns;

    wait;
  end process;
end;
