--------------------------------------------------------------------------------
-- Company: JHU
-- Engineer: JONAH SENGUPTA	
--
-- Create Date:   16:11:15 05/18/2018
-- Design Name:   RETINA PROC 1
-- Module Name:   /LinuxRAID/home/jonahs/projects/ReImagine/models/retina/hdl/tb/tb_retina_proc1.vhd
-- Project Name:  v2
-- Target Device:  SPARTAN-3

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.Library_retina.all;
USE STD.textio.all;
USE ieee.std_logic_textio.all;
USE ieee.numeric_std.ALL;
 
 
ENTITY tb_retina_proc1 IS
END tb_retina_proc1;
 
ARCHITECTURE behavior OF tb_retina_proc1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT retina_proc
    PORT(
         clk_i : IN  std_logic;
         rst_i : IN  std_logic;
         store_i : IN  std_logic;
			smp_i : IN std_logic;
         mode_i : IN  std_logic_vector(1 downto 0);
         patch_i : IN  std_logic_vector(71 downto 0);
         kern_i : IN  std_logic_vector(35 downto 0);
         thresh1_i : IN  std_logic_vector(8 downto 0);
         thresh2_i : IN  std_logic_vector(8 downto 0);
         spat_o : OUT  std_logic_vector(7 downto 0);
         temp_o : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal rst_i : std_logic := '0';
   signal store_i : std_logic := '0';
	signal smp_i : std_logic := '0';
   signal mode_i : std_logic_vector(1 downto 0) := (others => '0');
   signal patch_i : std_logic_vector(71 downto 0) := (others => '0');
   signal kern_i : std_logic_vector(35 downto 0) := (others => '0');
   signal thresh1_i : std_logic_vector(8 downto 0) := (others => '0');
   signal thresh2_i : std_logic_vector(8 downto 0) := (others => '0');

 	--Outputs
   signal spat_o : std_logic_vector(7 downto 0);
   signal temp_o : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
 
 
	file retina_test_in: text;
	file retina_test_out: text;
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: retina_proc PORT MAP (
          clk_i => clk_i,
          rst_i => rst_i,
          store_i => store_i,
			 smp_i => smp_i,
          mode_i => mode_i,
          patch_i => patch_i,
          kern_i => kern_i,
          thresh1_i => thresh1_i,
          thresh2_i => thresh2_i,
          spat_o => spat_o,
          temp_o => temp_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 
   -- Stimulus process
--   stim_proc: process
--   begin		
--		rst_i <= '1';
--      store_i <= '0';
--      mode_i <= "00";
--      patch_i <= (others=>'1');
--		kern_i <= "0000"&"0000"&"0000"&"0000"&"0001"&"0000"&"0000"&"0000"&"0000";
--      thresh1_i <= std_logic_vector(to_signed(14,9));
--      thresh2_i <= std_logic_vector(to_signed(-14,9));
--      wait for clk_i_period;
--		rst_i <= '0';	
--		store_i <= '1';
--		patch_i <= (others=>'0');
--		wait for clk_i_period;
--		patch_i <= (others=>'1');
--		wait for clk_i_period;
--		store_i <= '0';
--		wait for 4*clk_i_period;
--		smp_i <= '1';
--		wait for clk_i_period;
--		smp_i <= '0';
--		rst_i <= '1';
--		wait for clk_i_period;
--		rst_i <= '0';	
--		store_i <= '1';
--		patch_i <= (others=>'1');
--		wait for clk_i_period;
--		patch_i <= (others=>'0');
--		wait for clk_i_period;
--		store_i <= '0';
--		wait for 4*clk_i_period;
--		smp_i <= '1';
--		wait for clk_i_period;
--		smp_i <= '0';
--		rst_i <= '1';
--		wait for clk_i_period;
--		rst_i <= '0';
--      wait;
--   end process;
	
	read_in:
	process
	  variable v_ILINE : line;
	  variable d_in : std_logic_vector(130 downto 0);
	  begin
		 file_open(retina_test_in, "../../../matlab/retina_test_in.txt",read_mode);
		 wait for clk_i_period;
		 while not endfile(retina_test_in) loop
			readline(retina_test_in, v_ILINE);
			read(v_ILINE, d_in);
			rst_i <= d_in(130);
			store_i <= d_in(129);
			smp_i <= d_in(128);
			mode_i <= d_in(127 downto 126);
			thresh1_i <= d_in(125 downto 117);
			thresh2_i <= d_in(116 downto 108);
			kern_i <= d_in(107 downto 72);
			patch_i <= d_in(71 downto 0);
			wait for clk_i_period;
--			num <= std_logic_vector(unsigned(num) + 1);
		 end loop;
		 file_close(retina_test_in);
		 wait;
	end process;
	--
	--write_out:
	process
	  variable v_OLINE : line;
	  variable d_out : std_logic_vector(15 downto 0);
	  begin
		 file_open(retina_test_out, "../../../matlab/retina_test_out.txt",write_mode);
		 wait for clk_i_period;
		 while not endfile(retina_test_in) loop
			wait for 8*clk_i_period;
			  d_out := spat_o & temp_o;
			  write(v_OLINE, d_out);
			  writeline(retina_test_out, v_OLINE);
		 end loop;
		 file_close(retina_test_out);
	wait;
	end process;

END;
