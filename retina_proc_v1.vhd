library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use work.Library_retina.all;

entity retina_proc is
	generic (
		pix_width 	: integer := 8;
		kern_width	: integer := 4;
		kern_size	: integer := 9
		);
	port(
		clk_i    : 	in  	std_logic;
		rst_i		:	in		std_logic;
		store_i	:	in		std_logic;
		smp_i		:	in		std_logic;
		mode_i	:	in		std_logic_vector(1 downto 0);
		patch_i	:	in		std_logic_vector(kern_size*pix_width-1 downto 0);
		kern_i	:	in		std_logic_vector(kern_size*kern_width-1 downto 0);
		thresh1_i:	in		std_logic_vector((pix_width+1)-1 downto 0);
		thresh2_i:	in		std_logic_vector((pix_width+1)-1 downto 0);
		spat_o	:	out	std_logic_vector((pix_width)-1 downto 0);
		temp_o	:	out	std_logic_vector((pix_width)-1 downto 0)
		);
end entity retina_proc;

architecture behav of retina_proc is
signal kern_reg : std_logic_vector(kern_size*kern_width-1 downto 0);
signal patch_reg : std_logic_vector(kern_size*pix_width-1 downto 0);
signal in_reg, temp_res : std_logic_vector(pix_width-1 downto 0);
signal conv_res : std_logic_vector((log2(kern_size)+pix_width+kern_width)-1 downto 0);
signal pad : std_logic_vector(log2(kern_size)-1 downto 0);
signal spat_res, cat_res : std_logic_vector((log2(kern_size)+pix_width)-1 downto 0);
signal spat_reg : std_logic_vector(2*(log2(kern_size)+pix_width)-1 downto 0);
signal s_spat1 : std_logic_vector((pix_width+1)-1 downto 0);
signal s_spat2 : std_logic_vector((pix_width+1)-1 downto 0);
signal sub_in	: signed((log2(kern_size)+pix_width)-1 downto 0);
--signal smp_cnt : std_logic_vector(2 downto 0);
--signal smp : std_logic;
begin

store_proc: process(clk_i)
begin
	if rising_edge(clk_i) then
		if rst_i = '1' then 
			patch_reg <= (others=>'0');
			kern_reg <= (others=>'0');
			in_reg <= (others=>'0');
		else
			if store_i = '1' then 
				patch_reg <= patch_i;
				kern_reg	<= kern_i;
				in_reg <= patch_i(pix_width*(kern_size/2+1)-1 downto pix_width*(kern_size/2));
			end if;		
		end if;
	end if;
end process store_proc;

Inst_mac_u: mac_u port map(
		clk_i => clk_i,
		x => patch_reg,
		h => kern_reg,
		y => conv_res
	);

pad <= (others=>'0');
cat_res <= pad&in_reg;
sub_in <= signed(conv_res(conv_res'high downto kern_width))-signed(cat_res);

mux_proc: process(clk_i)
begin
	if rising_edge(clk_i) then
		if rst_i = '1' then
			spat_res <= (others=>'0');
		else
			if mode_i = "00" then 
				spat_res <= cat_res;
			elsif mode_i = "01" then
				spat_res <= conv_res(conv_res'high downto kern_width);
			elsif mode_i = "10" then 
				spat_res <= std_logic_vector(sub_in);
			else 
				spat_res <= (others=>'0');
			end if;
		end if;
	end if;
end process mux_proc;

shift_proc: process(clk_i)
begin
	if rising_edge(clk_i) then 
		if rst_i = '1' then 
			spat_reg <= (others=>'0');
		else
			spat_reg(spat_reg'high downto spat_reg'high/2+1) <= spat_reg(spat_reg'high/2 downto 0);
			spat_reg(spat_reg'high/2 downto 0) <= spat_res;
		end if;
	end if;
end process shift_proc;

s_spat1 <= '0'&spat_reg(spat_reg'high/2 - log2(kern_size) downto 0) when mode_i = "00" else '0'&spat_reg(spat_reg'high/2 downto log2(kern_size));
s_spat2 <= '0'&spat_reg(spat_reg'high - log2(kern_size) downto spat_reg'high/2+1) when mode_i = "00" else '0'&spat_reg(spat_reg'high downto spat_reg'high/2+1+log2(kern_size));

Inst_subcmp: subcmp port map(
		clk_i => clk_i,
		rst_i => rst_i,
		x1 => s_spat1,
		x2 => s_spat2,
		thresh1 => thresh1_i,
		thresh2 => thresh2_i,
		y => temp_res
	);

--smp_proc: process(clk_i)
--begin
--	if rising_edge(clk_i) then 	
--		if rst_i = '1' then 
--			smp_cnt <= (others=>'0');
--		else
--			smp_cnt <= std_logic_vector(unsigned(smp_cnt)+1);
--		end if;
--		if rst_i = '1' then 
--			smp <= '0';
--		else
--			if smp_cnt = "101" then
--				smp <= '1';
--			end if;
--		end if;
--	end if;
--end process smp_proc;

out_proc: process(clk_i)
begin
	if rising_edge(clk_i) then 
		if rst_i = '1' then 
			temp_o <= (others=>'0');
		else
			if smp_i = '1' then 
				temp_o <= temp_res;
			end if;
		end if;
	end if;
end process;

spat_o <= spat_res(spat_res'high-log2(kern_size) downto 0) when mode_i = "00" else spat_res(spat_res'high downto log2(kern_size));	
	
end  behav;