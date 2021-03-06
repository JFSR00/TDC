
-- VHDL Component Instantiation Template 
-- Autogenerated from source file TOP.vhd with 
-- get_instantiation_template.tcl
-- 
-- Notice:
-- Copy and paste the templates in your destination file(s) and then edit
-- Please if you think there might be a bug contact with us
--

component TOP is
    generic( DATA_WIDTH : integer := 4;
			 CW_WIDTH : integer := 5);
    Port ( DATA_BUS_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
           FZ_o : out STD_LOGIC;
           ANODE_o : out STD_LOGIC_VECTOR (7 downto 0);
           CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0));
end component;



my_top : TOP
	generic map(
		DATA_WIDTH => ,
		CW_WIDTH => )
	port map(
		DATA_BUS_i => ,
		RST_i => ,
		CLK_i => ,
		CW_i => ,
		FZ_o => ,
		ANODE_o => ,
		CATHODE_o => );


	
