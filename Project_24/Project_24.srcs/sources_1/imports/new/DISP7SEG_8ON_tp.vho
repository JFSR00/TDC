
-- VHDL Component Instantiation Template 
-- Autogenerated from source file DISP7SEG_8ON.vhd with 
-- get_instantiation_template.tcl
-- 
-- Notice:
-- Copy and paste the templates in your destination file(s) and then edit
-- Please if you think there might be a bug contact with us
--

component DISP7SEG_8ON is
    generic (DATA_WIDTH: integer:= 4);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           DATA0_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA1_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA2_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA3_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA4_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA5_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA6_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA7_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           ANODE_o : out STD_LOGIC_VECTOR (7 downto 0);
           CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0));
end component;



my_disp7seg_8on : DISP7SEG_8ON
	generic map(DATA_WIDTH => )
	port map(
		CLK_i => ,
		RST_i => ,
		DATA0_i => ,
		DATA1_i => ,
		DATA2_i => ,
		DATA3_i => ,
		DATA4_i => ,
		DATA5_i => ,
		DATA6_i => ,
		DATA7_i => ,
		ANODE_o => ,
		CATHODE_o => );


	
