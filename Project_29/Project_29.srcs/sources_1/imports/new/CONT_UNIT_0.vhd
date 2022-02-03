----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2021 12:39:26
-- Design Name: 
-- Module Name: CONT_UNIT_0 - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CONT_UNIT_0 is
	Generic(COP_WIDTH: integer:= 4;
			CW_WIDTH: integer:= 10);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           PUSH_i : in STD_LOGIC;
           FZ_i : in STD_LOGIC;
           COP_i : in STD_LOGIC_VECTOR (COP_WIDTH-1 downto 0);
           CW_o : out STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0));
end CONT_UNIT_0;

architecture Behavioral of CONT_UNIT_0 is
-------------------------------------------------------
--	DEFINITION of STATES
-------------------------------------------------------
type STATES_FSM is(IDLE, LOAD, DECO, OPE_A, ADDR_B, OPE_B, BRANCH, BR_INST, MOV_A, INC_A, A_ADD_B, A_SUB_B);
signal NEXT_STATE: STATES_FSM;

-------------------------------------------------------
--	DEFINITION of the OUTPUTS for each STATE
-------------------------------------------------------
constant OUTPUT_IDLE: std_logic_Vector(9 downto 0):=	"0000000000";	--000h
constant OUTPUT_LOAD: std_logic_Vector(9 downto 0):=	"0001010000";	--050h
constant OUTPUT_DECO:std_logic_Vector(9 downto 0):=		"0000000000";	--000h
constant OUTPUT_BRANCH:std_logic_Vector(9 downto 0):=	"0011000000";	--0C0h
constant OUTPUT_BR_INST:std_logic_Vector(9 downto 0):=	"0000000000";	--000h
constant OUTPUT_OPE_A:std_logic_Vector(9 downto 0):=	"0000000100";	--004h
constant OUTPUT_ADDR_B:std_logic_Vector(9 downto 0):=	"0000100000";	--020h
constant OUTPUT_OPE_B:std_logic_Vector(9 downto 0):=	"0000100010";	--022h
constant OUTPUT_MOV_A:std_logic_Vector(9 downto 0):=	"0000101001";	--029h
constant OUTPUT_INC_A:std_logic_Vector(9 downto 0):=	"0100101001";	--12Ch
constant OUTPUT_A_ADD_B:std_logic_Vector(9 downto 0):=	"1000101001";	--22Ch
constant OUTPUT_A_SUB_B:std_logic_Vector(9 downto 0):=	"1100101001";	--32Ch

----------------------------------------------------------------
begin
process (CLK_i, RST_i)
begin
	if RST_i = '1' then
		NEXT_STATE <= IDLE;
	elsif rising_edge(CLK_i) then
		--if (PUSH_i = '1') then
		case NEXT_STATE is
		--State"IDLE"-
			when IDLE =>
				NEXT_STATE <= LOAD;
				
		--State"LOAD"
			when LOAD =>
				NEXT_STATE <= DECO;
				
		--State "DECO"
			when DECO =>
				if (COP_i="0100") then
					if (FZ_i = '0') then
						NEXT_STATE <= LOAD;
					else
						NEXT_STATE <= BRANCH;
					end if;
				else
					NEXT_STATE <= OPE_A;
				end if;
		
		--State "BRANCH"
			when BRANCH =>
				NEXT_STATE <= BR_INST;
				
		--State "BR_INST"
			when BR_INST =>
				NEXT_STATE <= LOAD;
				
		--State "OPE_A"
			when OPE_A =>
				if (COP_i="0000") then
					NEXT_STATE <= MOV_A;
				elsif (COP_i="0001") then
					NEXT_STATE <= INC_A;
				else
					NEXT_STATE <= ADDR_B;
				end if;
			
		--State "ADDR_B"
			when ADDR_B =>
				NEXT_STATE <= OPE_B;
				
		--State "OPE_B"
			when OPE_B =>
				if (COP_i="0010") then
					NEXT_STATE <= A_ADD_B;
				else
					NEXT_STATE <= A_SUB_B;
				end if;
				
		--State MOV_A
			when MOV_A =>
				NEXT_STATE <= LOAD;
				
		--State INC_A
			when INC_A =>
				NEXT_STATE <= LOAD;
				
		--State A_SUB_B
			when A_SUB_B =>
				NEXT_STATE <= LOAD;
				
		--State A_ADD_B
			when A_ADD_B =>
				NEXT_STATE <= LOAD;
				
		--State unknown
			when others =>
				NEXT_STATE <= IDLE;
		end case;
		--end if;		-- if (PUSH_i = '1')
	end if;
end process;

with NEXT_STATE select
	CW_o <=	OUTPUT_IDLE when IDLE,
			OUTPUT_LOAD when LOAD,
			OUTPUT_DECO when DECO,
			OUTPUT_BRANCH when BRANCH,
			OUTPUT_BR_INST when BR_INST,
			OUTPUT_OPE_A when OPE_A,
			OUTPUT_ADDR_B when ADDR_B,
			OUTPUT_OPE_B when OPE_B,
			OUTPUT_MOV_A when MOV_A,
			OUTPUT_INC_A when INC_A,
			OUTPUT_A_ADD_B when A_ADD_B,
			OUTPUT_A_SUB_B when A_SUB_B,
			OUTPUT_IDLE when others;

end Behavioral;
