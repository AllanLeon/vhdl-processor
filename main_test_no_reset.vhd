--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:42:56 03/22/2017
-- Design Name:   
-- Module Name:   D:/UPB/9no Semestre/Arquitectura y tecnologia de procesadores/VHDL/Processor/main_test_no_reset.vhd
-- Project Name:  Processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: main_controller
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY main_test_no_reset IS
END main_test_no_reset;
 
ARCHITECTURE behavior OF main_test_no_reset IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main_controller
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         din : IN  std_logic_vector(7 downto 0);
         dout : OUT  std_logic_vector(7 downto 0);
         E : INOUT  std_logic;
         RS : OUT  std_logic;
         RW : OUT  std_logic;
         SF_CE0 : OUT  std_logic;
         DB : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal din : std_logic_vector(7 downto 0) := (others => '0');

	--BiDirs
   signal E : std_logic;

 	--Outputs
   signal dout : std_logic_vector(7 downto 0);
   signal RS : std_logic;
   signal RW : std_logic;
   signal SF_CE0 : std_logic;
   signal DB : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main_controller PORT MAP (
          clk => clk,
          rst => rst,
          din => din,
          dout => dout,
          E => E,
          RS => RS,
          RW => RW,
          SF_CE0 => SF_CE0,
          DB => DB
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
	input_process :process
	begin
		din <= "00100010";
		wait for clk_period / 2*10;
		din <= "00000000";
		wait for clk_period / 2*10;
		din <= "00000010";
		wait for clk_period / 2*10;
		din <= "00000000";
		wait for clk_period / 2*10;
		din <= "00101110";
		wait for clk_period / 2*10;
		din <= "00000000";
		wait for clk_period / 2*10;
		din <= "11111010";
		wait for clk_period / 2*10;
		din <= "00000000";
		wait for clk_period / 2 * 10;
		din <= "00000001";
		wait for clk_period / 2 * 10;
		din <= "00000000";
		wait for clk_period * 1000;
	end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
