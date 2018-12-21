library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AXI_timestamp_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 4
	);
	port (
		-- Users to add ports here
		clk_timestamp   : in std_logic;
	    reset_timestamp : in std_logic;
	    en_timestamp	: in std_logic;
	    timestamp_result_out_port : out std_logic_vector (C_S00_AXI_DATA_WIDTH-1 downto 0);

		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic
	);
end AXI_timestamp_v1_0;

architecture arch_imp of AXI_timestamp_v1_0 is

	-- component declaration
	component AXI_timestamp_v1_0_S00_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (

		slv_reg0_out : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		slv_reg1_out : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		slv_reg2_out : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		slv_reg3_in : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);	




		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component AXI_timestamp_v1_0_S00_AXI;


	COMPONENT timestamp 
    
        Generic (
                    AXI_LITE_DATA_WIDTH : integer := 32
					
        );
                 
        Port    ( 
                   	clk 		: in STD_LOGIC;
           			reset 		: in STD_LOGIC;
           			en 			: in STD_LOGIC;

           			--freq_input_clk_KHz	: in std_logic_vector(AXI_LITE_DATA_WIDTH - 1 downto 0);
           			--time_step_us 		: in std_logic_vector(AXI_LITE_DATA_WIDTH - 1 downto 0);
           			period_counter_reg		: in std_logic_vector(AXI_LITE_DATA_WIDTH - 1 downto 0);
           			timestamp_result 	: out std_logic_vector(AXI_LITE_DATA_WIDTH - 1 downto 0)
        );       
               
		end component;


		signal sig_freq_input_clk_KHz_reg0 : STD_LOGIC_VECTOR (C_S00_AXI_DATA_WIDTH - 1 downto 0);
		signal sig_time_step_us_reg1 : STD_LOGIC_VECTOR (C_S00_AXI_DATA_WIDTH - 1 downto 0);
		signal sig_timestamp_result_reg3 : STD_LOGIC_VECTOR (C_S00_AXI_DATA_WIDTH - 1 downto 0);
		signal sig_period_counter_reg : STD_LOGIC_VECTOR (C_S00_AXI_DATA_WIDTH - 1 downto 0);

		--signal sig_timestamp_result :  STD_LOGIC_VECTOR (C_S00_AXI_DATA_WIDTH - 1 downto 0);


begin

-- Instantiation of Axi Bus Interface S00_AXI
AXI_timestamp_v1_0_S00_AXI_inst : AXI_timestamp_v1_0_S00_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
	)
	port map (

		slv_reg0_out => sig_period_counter_reg,
		slv_reg1_out => open,--sig_time_step_us_reg1,
		slv_reg2_out => open,
		slv_reg3_in => sig_timestamp_result_reg3,


		S_AXI_ACLK	=> s00_axi_aclk,
		S_AXI_ARESETN	=> s00_axi_aresetn,
		S_AXI_AWADDR	=> s00_axi_awaddr,
		S_AXI_AWPROT	=> s00_axi_awprot,
		S_AXI_AWVALID	=> s00_axi_awvalid,
		S_AXI_AWREADY	=> s00_axi_awready,
		S_AXI_WDATA	=> s00_axi_wdata,
		S_AXI_WSTRB	=> s00_axi_wstrb,
		S_AXI_WVALID	=> s00_axi_wvalid,
		S_AXI_WREADY	=> s00_axi_wready,
		S_AXI_BRESP	=> s00_axi_bresp,
		S_AXI_BVALID	=> s00_axi_bvalid,
		S_AXI_BREADY	=> s00_axi_bready,
		S_AXI_ARADDR	=> s00_axi_araddr,
		S_AXI_ARPROT	=> s00_axi_arprot,
		S_AXI_ARVALID	=> s00_axi_arvalid,
		S_AXI_ARREADY	=> s00_axi_arready,
		S_AXI_RDATA	=> s00_axi_rdata,
		S_AXI_RRESP	=> s00_axi_rresp,
		S_AXI_RVALID	=> s00_axi_rvalid,
		S_AXI_RREADY	=> s00_axi_rready
	);

	-- Add user logic here

		timestamp_inst: timestamp 
	    
	    GENERIC MAP (
	                    AXI_LITE_DATA_WIDTH => C_S00_AXI_DATA_WIDTH
						
	    )
	    
	    PORT MAP (
	    
	               		clk 		=> clk_timestamp,
	           			reset 		=> reset_timestamp,
	           			en 			=> en_timestamp,

	           			--freq_input_clk_KHz	=> sig_freq_input_clk_KHz_reg0,
	           			--time_step_us 		=> sig_time_step_us_reg1,
	           			period_counter_reg	=> sig_period_counter_reg,
	           			timestamp_result 	=> sig_timestamp_result_reg3
	    );
	---------------------------------
	timestamp_result_out_port <= sig_timestamp_result_reg3;

	-- User logic ends

end arch_imp;
