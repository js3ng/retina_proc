library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

package Library_retina is
----------------------------------------------------------------------------------------------
----------------------------------------- Types ----------------------------------------------
----------------------------------------------------------------------------------------------
type array_8 is array  (natural range <>) of std_logic_vector(7 downto 0);
type array_16 is array (natural range <>) of std_logic_vector(15 downto 0);
type array_32 is array (natural range <>) of std_logic_vector(31 downto 0);
type array_64 is array (natural range <>) of std_logic_vector(63 downto 0);
----------------------------------------------------------------------------------------------
--------------------------------------- Functions --------------------------------------------
----------------------------------------------------------------------------------------------
function log2 ( x : integer ) return integer;
----------------------------------------------------------------------------------------------
--------------------------------------- Components -------------------------------------------
----------------------------------------------------------------------------------------------

------------SIM BLOCKS------------

component LFSR is
	generic (
		LFSR_L : integer );
	port(
		clk_i     : in  std_logic;
		clk_en_i  : in  std_logic;
		seed_i    : in  std_logic_vector(LFSR_L-1 downto 0);
		seed_we_i : in  std_logic;
		LFSR_o    : out std_logic_vector(LFSR_L-1 downto 0)
		);
end component LFSR;

component FILE_READ is
	generic(
		stim_file: string;
		char_n   : natural);
	port(
		clk_i       : in  std_logic;
		reset_i     : in  std_logic;
		clk_en_i    : in  std_logic;
		bin_value_o : out std_logic_vector(char_n-1 downto 0);
		eof_o       : out std_logic
       );
end component FILE_READ;

component FILE_WRITE is
	generic(
		write_file: string;
		char_n    : natural;
		num_elem  : integer);
	port(
		clk_i       : in std_logic;
		reset_i     : in std_logic;
		clk_en_i    : in std_logic;
		bin_value_i : in std_logic_vector(char_n-1 downto 0)
       );
end component FILE_WRITE;

component mac_u is
	generic (
		pix_width 	: integer := 8;
		kern_width	: integer := 4;
		kern_size	: integer := 9
		);
	port(
		clk_i    : 	in  	std_logic;
		x			:	in 	std_logic_vector(kern_size*pix_width-1 downto 0);
		h			:	in		std_logic_vector(kern_size*kern_width-1 downto 0);
		y			:	out	std_logic_vector((log2(kern_size)+pix_width+kern_width)-1 downto 0)
		);
end component mac_u;

component subcmp is
	generic (
		pix_width 	: integer := 8
		);
	port(
		clk_i    	: 	in  	std_logic;
		rst_i			:	in		std_logic;
		x1				:	in 	std_logic_vector((pix_width+1)-1 downto 0);
		x2				:	in 	std_logic_vector((pix_width+1)-1 downto 0);
		thresh1		:	in 	std_logic_vector((pix_width+1)-1 downto 0);
		thresh2		:	in 	std_logic_vector((pix_width+1)-1 downto 0);
		y				:	out	std_logic_vector(pix_width-1 downto 0)
		);
end component subcmp;


end Library_retina;

package body Library_retina is

	-- Base 2 logarithmic function. Number of bits required to represent from 0 to x-1
	function log2 ( x : integer ) return integer is
		variable temp2 : integer:= 0; 
		variable temp  : integer:= x;
		variable n     : integer:= 0;
		begin
			while temp > 1 loop
				temp2 := temp / 2 ;
				if (temp2*2 /= temp) then
					n := n + 1;
				end if;
				temp := temp2;
				n := n + 1 ;
			end loop ;
			if (x = 1) then
				n := 1;
			end if;
		return n ;
	end function log2;


end Library_retina;