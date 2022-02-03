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
	Generic( DATA_WIDTH : integer := 4;
			 ADDR_WIDTH: integer := 4;
			 ROM_WIDTH: integer := 12;
			 ADDR_ROM_WIDTH: integer := 4;
			 CW_WIDTH : integer := 10;
			 COP_WIDTH: integer := 4);

    Port ( RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
           ADDR_RAM_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           RAM_OUT_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           ALU_OUT_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_A_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_B_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           PC_o : out STD_LOGIC_VECTOR (ADDR_ROM_WIDTH-1 downto 0);
           INST_o : out STD_LOGIC_VECTOR (ROM_WIDTH-1 downto 0);
           FZ_o : out STD_LOGIC);
end DATAPATH_0;

architecture Behavioral of DATAPATH_0 is

signal DATA_BUS: std_logic_vector(DATA_WIDTH-1 downto 0);		-- Dummy signal: Bus de datos
signal ADDR_RAM: std_logic_vector(ADDR_WIDTH-1 downto 0);		-- Dummy signal: Bus de direcciones memoria RAM

signal ADDR_ROM: std_logic_vector(ADDR_ROM_WIDTH-1 downto 0);	-- Dummy signal: Bus de direcciones memoria ROM
signal DATA_ROM: std_logic_vector(ROM_WIDTH-1 downto 0);		-- Dummy signal: Bus de ROM

signal PC: std_logic_vector(ADDR_ROM_WIDTH-1 downto 0);			-- Dummy signal: Registro de Contador de Programa (Program Counter)
signal REG_PC: std_logic_vector(ADDR_ROM_WIDTH-1 downto 0);		-- Dummy signal: Registro Contador de Programa incrementado en 1

signal REG_INST: std_logic_vector(ROM_WIDTH-1 downto 0);		-- Dummy signal: Registro de instrucción
signal REG_A : signed (DATA_WIDTH-1 downto 0);					-- Dummy signal: Registro A
signal REG_B : signed (DATA_WIDTH-1 downto 0);					-- Dummy signal: Registro B
signal RESULT : signed (DATA_WIDTH-1 downto 0);					-- Dummy signal: Resultado de la ALU
signal FZ : std_logic;											-- Dummy signal: Flag Zero

-- Declaración de memoria RAM, e inicialización de la misma
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

-- Declaración de memoria ROM de programa, e inicialización de la misma
type ROM_TYPE is array(2**ADDR_ROM_WIDTH-1 downto 0) of std_logic_vector(ROM_WIDTH-1 downto 0);
signal ROM :ROM_TYPE :=
	(0 => B"0010_1000_0011",		-- RAM(8) + RAM(3) -> RAM(3)
	 1 => B"0000_0001_0100",		-- RAM(1) -> RAM(4)
	 2 => B"0001_0000_1001",		-- RAM(0) + 1 -> RAM(0)
	 3 => B"0011_0001_0001",		-- RAM(1) - RAM(1) -> RAM(1)
	 4 => B"0100_0011_0000",		-- When FZ = 1, DirSalto -> PC
	 5 => B"0000_0100_0000",
	 others => B"0000_0000_0000");

begin
	------------------------------------------------------------------------------------------------------
	-- Salidas de los registros A y B, y señales de depuración 
	------------------------------------------------------------------------------------------------------
	REG_A_o <= std_logic_vector(REG_A);
	REG_B_o <= std_logic_vector(REG_B);
	ALU_OUT_o <= std_logic_vector(RESULT);
	RAM_OUT_o <= DATA_BUS;
	FZ_o <= FZ;
	ADDR_RAM_o <= ADDR_RAM;
	PC_o <= PC;
	INST_o <= REG_INST;

	------------------------------------------------------------------------------------------------------
	-- Proceso de actualización de registros
	------------------------------------------------------------------------------------------------------
	P_REG : process(CLK_i,RST_i)
	begin
		if RST_i = '1' then
			FZ <= '0';
			REG_B <= (others => '0');
			REG_A <= (others => '0');
			REG_INST <= (others => '0');
			PC <= (others => '0');
		elsif rising_edge(CLK_i) then
			if CW_i(0) = '1' then			-- Actualizamos registro Flag Zero
				if RESULT = 0 then
					FZ <= '1';				-- En caso de que la salida de la ALU sea igual a '0', se activa
				else						-- (se pone a '1') dicho flag. En otro caso, se mantiene a '0'
					FZ <= '0';
				end if;
			end if;
			if CW_i(1) = '1' then			-- Actualizamos registro B
				REG_B <= signed(DATA_BUS);
			end if;
			if CW_i(2) = '1' then			-- Actualizamos registro A
				REG_A <= signed(DATA_BUS);
			end if;
			if CW_i(4) = '1' then			-- Actualizamos registro de instrucción
				REG_INST <= DATA_ROM;
			end if;
			if CW_i(6) = '1' then			-- Actualizamos Program Counter
				PC <= REG_PC;
			end if;
		end if;
	end process;	-- P_REG

	------------------------------------------------------------------------------------------------------
	-- Proceso de la ALU
	------------------------------------------------------------------------------------------------------
	RESULT <= 	REG_A 			when CW_i(CW_WIDTH-1 downto CW_WIDTH-2) = "00" else
				REG_A + 1 		when CW_i(CW_WIDTH-1 downto CW_WIDTH-2) = "01" else
				REG_A + REG_B 	when CW_i(CW_WIDTH-1 downto CW_WIDTH-2) = "10" else
				REG_A - REG_B;
						
	------------------------------------------------------------------------------------------------------
	-- Memoria RAM
	------------------------------------------------------------------------------------------------------
	process(CLK_i)
	begin
		if rising_edge(CLK_i)then	--Operación de LECTURA/ESCRITURA síncrona
			if CW_i(3) = '1' then
				RAM(to_integer(unsigned(ADDR_RAM))) <= std_logic_vector(RESULT);	--El dato que se lee, es el mismo que se escribe
				DATA_BUS <= std_logic_vector(RESULT);
			else	--Operación de SOLO LECTURA SÍNCRONA
				DATA_BUS <= RAM(to_integer(unsigned(ADDR_RAM)));
			end if;
		end if;
	end process;

	------------------------------------------------------------------------------------------------------
	-- Memoria ROM
	------------------------------------------------------------------------------------------------------
	process(CLK_i)
	begin
		if rising_edge(CLK_i) then
			DATA_ROM <= ROM(to_integer(unsigned(ADDR_ROM)));
		end if;
	end process;
	
	------------------------------------------------------------------------------------------------------
	-- Multiplexor direcciones REG_INST
	------------------------------------------------------------------------------------------------------
	ADDR_RAM <= REG_INST((2*ADDR_WIDTH)-1 downto ADDR_WIDTH) when CW_i(5) = '0' else
				REG_INST(ADDR_WIDTH-1 downto 0);

	------------------------------------------------------------------------------------------------------
	-- Multiplexor Contador de Programa
	------------------------------------------------------------------------------------------------------
	REG_PC <= std_logic_vector(unsigned(ADDR_ROM) + 1) when CW_i(7) = '0' else
				REG_INST(ADDR_ROM_WIDTH-1 downto 0);

	------------------------------------------------------------------------------------------------------
	-- Salida del Contador de Programa
	------------------------------------------------------------------------------------------------------
	ADDR_ROM <= PC;
	
end Behavioral;
