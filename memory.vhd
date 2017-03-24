----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:22:57 02/24/2017 
-- Design Name: 
-- Module Name:    memory - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory is
	Port ( clk : in  STD_LOGIC;
			 rst : in  STD_LOGIC;
			 rw : in  STD_LOGIC;
          t : in  STD_LOGIC;
          addr : in  STD_LOGIC_VECTOR (7 downto 0);
          din : in  STD_LOGIC_VECTOR (7 downto 0);
          dout : out  STD_LOGIC_VECTOR (7 downto 0) := x"00");
end memory;

architecture Behavioral of memory is

type array_8bit is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0); 
signal regs : array_8bit := ((others=> (others=>'0')));
	
begin

	process (clk, rst, t)
		variable addr_int : INTEGER := 0;
		variable i : INTEGER;
	begin
		if (rst = '1') then
			for i in 0 to 255 loop
				regs(i) <= "00000000";
			end loop;
--			regs(100) <= "00100000";
--			regs(101) <= "00000110";
--			regs(102) <= "11110011";
--			regs(103) <= "00100101";
--			regs(104) <= "00000101";
--			regs(105) <= "00000110";
--			regs(106) <= "00111101";
--			regs(107) <= "00000110";
--			regs(108) <= "00000000";
--			regs(109) <= "00011100";
--			regs(110) <= "00000000";
--			regs(111) <= "00000000";
--			regs(106) <= "00100110";
--			regs(107) <= "00000001";
--			regs(108) <= "01100100";
--			regs(109) <= "01000000";
--			regs(110) <= "00000110";
--			regs(111) <= "00000001";
--			regs(112) <= "01100000";
--			regs(113) <= "00000010";
--			regs(114) <= "00000000";
--			regs(112) <= "01010001";
--			regs(113) <= "00000101";
--			regs(114) <= "00000110";
--			regs(115) <= "01011100";
--			regs(116) <= "00000101";
--			regs(117) <= "11111100";
--			regs(115) <= "00000000"; -- RST
--			regs(116) <= "00000000";
--			regs(117) <= "00000000";
--			regs(115) <= "00011100"; -- HLT
--			regs(116) <= "00000000";
--			regs(117) <= "00000000";
		elsif (t = '1') then
--		-------------- MULTIPLICACION CON SUMAS -----------
--			regs(100) <= "00100000";
--			regs(101) <= "00000001";
--			regs(102) <= "00000010";
--			
--			regs(103) <= "00100000";
--			regs(104) <= "00000010";
--			regs(105) <= "00000011";
--			
--			regs(106) <= "00100000";
--			regs(107) <= "00001000";
--			regs(108) <= "00000000";
--			
--			regs(109) <= "00100000";
--			regs(110) <= "00001001";
--			regs(111) <= "00000000";
--			
--			regs(112) <= "01000001";
--			regs(113) <= "00001001";
--			regs(114) <= "00000001";
--			
--			regs(115) <= "01000000";
--			regs(116) <= "00001000";
--			regs(117) <= "00000001";
--			
--			regs(118) <= "01011001";
--			regs(119) <= "00001000";
--			regs(120) <= "00000010";
--			
--			regs(121) <= "01110000";
--			regs(122) <= "00000100";
--			regs(123) <= "00000000";
--			
--			regs(124) <= "00111101";
--			regs(125) <= "00001001";
--			regs(126) <= "00000000";
--			
--			regs(127) <= "00011100";
--			regs(128) <= "00000000";
--			regs(129) <= "00000000";

			-------------- (A * B) + C -----------
			regs(100) <= "00100000";
			regs(101) <= "00000001";
			regs(102) <= "00000010";
			
			regs(103) <= "00100000";
			regs(104) <= "00000010";
			regs(105) <= "00001011";
			
			regs(106) <= "00100000";
			regs(107) <= "00000011";
			regs(108) <= "00000111";
			
			regs(109) <= "00100000";
			regs(110) <= "00001000";
			regs(111) <= "00000000";
			
			regs(112) <= "00100000";
			regs(113) <= "00001001";
			regs(114) <= "00000000";
			
			regs(115) <= "01000001";
			regs(116) <= "00001001";
			regs(117) <= "00000001";
			
			regs(118) <= "01000000";
			regs(119) <= "00001000";
			regs(120) <= "00000001";
			
			regs(121) <= "01011001";
			regs(122) <= "00001000";
			regs(123) <= "00000010";
			
			regs(124) <= "01110000";
			regs(125) <= "00000101";
			regs(126) <= "00000000";
			
			regs(127) <= "01000001";
			regs(128) <= "00001001";
			regs(129) <= "00000011";
			
			regs(130) <= "00111101";
			regs(131) <= "00001001";
			regs(132) <= "00000000";
			
			regs(133) <= "00011100";
			regs(134) <= "00000000";
			regs(135) <= "00000000";
		elsif (clk'event and clk='1') then
			
				addr_int := to_integer(unsigned(addr));
				if (rw = '1') then -- write
					regs(addr_int) <= din;
				else -- read
					--dout <= regs(addr_int);
				end if;
				dout <= regs(addr_int);
		end if;
	end process;
	
end Behavioral;

