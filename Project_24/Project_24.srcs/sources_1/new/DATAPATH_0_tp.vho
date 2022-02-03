
-- VHDL Component Instantiation Template 
-- Autogenerated from source file DATAPATH_0.vhd with 
-- get_instantiation_template.tcl
-- 
-- Notice:
-- Copy and paste the templates in your destination file(s) and then edit
-- Please if you think there might be a bug contact with us
--

component DATAPATH_0 is
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
end component;



my_datapath_0 : DATAPATH_0
	generic map(
		DATA_WIDTH => ,
		CW_WIDTH => )
	port map(
		DATA_BUS_i => ,
		RST_i => ,
		CLK_i => ,
		CW_i => ,
		ALU_OUT_o => ,
		REG_A_o => ,
		REG_B_o => ,
		FZ_o => );


	
