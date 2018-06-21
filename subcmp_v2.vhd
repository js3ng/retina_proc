library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use work.Library_retina.all;

entity subcmp is
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
end entity subcmp;

architecture behav of subcmp is
signal sub: signed(pix_width downto 0);
begin

sub_proc: process(clk_i)
begin
	if rising_edge(clk_i) then 
		if rst_i = '1' then 
			sub <= (others=>'0');
		else
			sub <= signed(x1)-signed(x2);
		end if;
	end if;
end process;

cmp_proc: process(clk_i) 
begin
	if rising_edge(clk_i) then 
		if rst_i = '1' then 	
			y <= (others=>'0');
		else 
			if sub >= signed(thresh1) then 
				y <= std_logic_vector(to_unsigned(255,pix_width));
			elsif sub <= signed(thresh2) then
				y <= std_logic_vector(to_unsigned(122,pix_width)); 
			else
				y <= (others=>'0');
			end if;
		end if;
	end if;
end process;


end  behav;