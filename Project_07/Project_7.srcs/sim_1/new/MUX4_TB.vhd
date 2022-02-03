library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity MUX4_tb is
end;

architecture bench of MUX4_tb is

  component MUX4
      generic (WIDTH: integer:= 4);
      Port ( A_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
             B_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
             C_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
             D_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
             Z_o : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
             SEL_i : in STD_LOGIC_VECTOR (1 downto 0));
  end component;

  constant WIDTH: integer:= 4;
  signal A_i: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
  signal B_i: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
  signal C_i: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
  signal D_i: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
  signal Z_o: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
  signal SEL_i: STD_LOGIC_VECTOR (1 downto 0);

begin

  -- Insert values for generic parameters !!
  uut: MUX4 generic map ( WIDTH => WIDTH )
               port map ( A_i   => A_i,
                          B_i   => B_i,
                          C_i   => C_i,
                          D_i   => D_i,
                          Z_o   => Z_o,
                          SEL_i => SEL_i );

  stimulus: process
  begin
    A_i <= "0001";
    B_i <= "0010";
    C_i <= "0100";
    D_i <= "1000";
    
    SEL_i <= "00";
    wait for 50 ns;
    
    SEL_i <= "01";
    wait for 50 ns;
    
    SEL_i <= "10";
    wait for 50 ns;
    
    SEL_i <= "11";
    wait for 50 ns;

    wait;
  end process;


end;