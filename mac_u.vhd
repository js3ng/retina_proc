library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use work.Library_retina.all;

entity mac_u is
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
end entity mac_u;

architecture behav of mac_u is

begin

mac: process(clk_i)
	variable sum : integer := 0;
begin
	if rising_edge(clk_i) then 
		for ii in 0 to kern_size-1 loop
			sum := sum + to_integer(unsigned(x((ii+1)*pix_width-1 downto ii*pix_width))) * to_integer(unsigned(h((ii+1)*kern_width-1 downto ii*kern_width)));
		end loop;
		y <= std_logic_vector(to_unsigned(sum,y'length));
		sum := 0;
	end if;
end process;

end  behav;