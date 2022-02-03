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
			 CW_WIDTH : integer := 5);
    Port ( DATA_BUS_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
           ALU_OUT_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_A_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_B_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           FZ_o : out STD_LOGIC);
end DATAPATH_0;

architecture Behavioral of DATAPATH_0 is

signal REG_A : signed (DATA_WIDTH-1 downto 0);	-- Dummy signal: Registro A
signal REG_B : signed (DATA_WIDTH-1 downto 0);	-- Dummy signal: Registro B
signal RESULT : signed (DATA_WIDTH-1 downto 0);	-- Dummy signal: Resultado de la ALU
signal FZ : std_logic;	-- Dummy signal: Flag Zero

begin
	----------------------------------
	-- Salidas de los registros A y B
	----------------------------------
	REG_A_o <= std_logic_vector(REG_A);
	REG_B_o <= std_logic_vector(REG_B);
	ALU_OUT_o <= std_logic_vector(RESULT);

	----------------------------------
	-- Proceso del registro A
	----------------------------------
	P_REG_A : process(CLK_i,RST_i)
	begin
		if RST_i = '1' then
			REG_A <= (others => '0');
		elsif rising_edge(CLK_i) then
			if CW_i(2) = '1' then
				REG_A <= signed(DATA_BUS_i);
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
				REG_B <= signed(DATA_BUS_i);
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
	-- Activación del Flag Zero
	----------------------------------
	FZ <= '1' when RESULT = 0 else '0';	-- En caso de que la salida de la ALU sea igual a '0', se activa
										-- (se pone a '1') dicho flag. En otro caso, se mantiene a '0'
end Behavioral;
