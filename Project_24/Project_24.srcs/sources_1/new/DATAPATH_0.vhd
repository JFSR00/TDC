----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Juan Francisco Santos Relinque
-- 
-- Create Date: 24.03.2021 12:46:05
-- Design Name: 
-- Module Name: DATAPATH_0 - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DATAPATH_0 is
	generic( DATA_WIDTH : integer := 4;
			 ADDR_WIDTH: integer := 4;
			 CW_WIDTH : integer := 5);
    Port ( ADDR_BUS_i : in STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
           RAM_OUT_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           ALU_OUT_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_A_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_B_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           FZ_o : out STD_LOGIC);
end DATAPATH_0;

architecture Behavioral of DATAPATH_0 is

signal DATA_BUS: std_logic_vector(DATA_WIDTH-1 downto 0);	-- Dummy signal: Bus de datos
signal REG_A : signed (DATA_WIDTH-1 downto 0);	-- Dummy signal: Registro A
signal REG_B : signed (DATA_WIDTH-1 downto 0);	-- Dummy signal: Registro B
signal RESULT : signed (DATA_WIDTH-1 downto 0);	-- Dummy signal: Resultado de la ALU
signal FZ : std_logic;	-- Dummy signal: Flag Zero

-- Declaraci�n de memoria RAM, e inicializaci�n de la misma
type RAM_TYPE is array(2**ADDR_WIDTH-1 downto 0) of std_logic_vector(DATA_WIDTH-1 downto 0);
signal RAM :RAM_TYPE:=
	(0 => X"5",
	 1 => X"F",
	 2 => X"E",
	 3 => X"E",
	 4 => X"E",
	 5 => X"0",
	 6 => X"1",
	 7 => X"2",
	 8 => X"5",
	 9 => X"F",
	 others => X"0");

begin
	----------------------------------
	-- Salidas de los registros A y B, y se�ales de depuraci�n 
	----------------------------------
	REG_A_o <= std_logic_vector(REG_A);
	REG_B_o <= std_logic_vector(REG_B);
	ALU_OUT_o <= std_logic_vector(RESULT);
	RAM_OUT_o <= DATA_BUS;

	----------------------------------
	-- Proceso del registro A
	----------------------------------
	P_REG_A : process(CLK_i,RST_i)
	begin
		if RST_i = '1' then
			REG_A <= (others => '0');
		elsif rising_edge(CLK_i) then
			if CW_i(2) = '1' then
				REG_A <= signed(DATA_BUS);
			end if;
		end if;
	end process;	-- P_REG_A

	----------------------------------
	-- Proceso del registro B
	----------------------------------
	P_REG_B : process(CLK_i,RST_i)
	begin
		if RST_i = '1' then
			REG_B <= (others => '0');
		elsif rising_edge(CLK_i) then
			if CW_i(1) = '1' then
				REG_B <= signed(DATA_BUS);
			end if;
		end if;
	end process;	-- P_REG_B
	
	----------------------------------
	-- Proceso del registro Flag Zero
	----------------------------------
	P_FZ : process(CLK_i, RST_i)
	begin
		if RST_i = '1' then
			FZ_o <= '0';
		elsif rising_edge(CLK_i) then
			if CW_i(0) = '1' then
				FZ_o <= FZ;
			end if;
		end if;
	end process;	-- P_FZ

	----------------------------------
	-- Proceso de la ALU
	----------------------------------
	ALU: process(REG_A, REG_B, CW_i)
	begin
		case CW_i(CW_WIDTH-1 downto CW_WIDTH-2) is
			when "00" => RESULT <= REG_A;
			when "01" => RESULT <= REG_A + 1;
			when "10" => RESULT <= REG_A + REG_B;
			when others => RESULT <= REG_A - REG_B;
		end case;
	end process;	-- ALU
	
	----------------------------------
	-- Activaci�n del Flag Zero
	----------------------------------
	FZ <= '1' when RESULT = 0 else '0';	-- En caso de que la salida de la ALU sea igual a '0', se activa
										-- (se pone a '1') dicho flag. En otro caso, se mantiene a '0'
										
	----------------------------------
	-- Memoria RAM
	----------------------------------
	process(CLK_i)
	begin
		if rising_edge(CLK_i)then	--Operaci�n de LECTURA/ESCRITURA s�ncrona
			if CW_i(3) = '1' then
				RAM(to_integer(unsigned(ADDR_BUS_i))) <= std_logic_vector(RESULT);	--El dato que se lee, es el mismo que se escribe
				DATA_BUS <= std_logic_vector(RESULT);
			else	--Operaci�n de SOLO LECTURAS�NCRONA
				DATA_BUS <= RAM(to_integer(unsigned(ADDR_BUS_i)));
			end if;
		end if;
	end process;

end Behavioral;
