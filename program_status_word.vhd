----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:59:42 03/20/2017 
-- Design Name: 
-- Module Name:    program_status_word - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity program_status_word is
    Port ( clk : in STD_LOGIC;
			  rst : in STD_LOGIC;
           z : in  STD_LOGIC;
			  c : in  STD_LOGIC;
           o : in  STD_LOGIC;
           r : in  STD_LOGIC;
           h : in  STD_LOGIC;
           psw : out  STD_LOGIC_VECTOR (0 to 4) := "00000");
end program_status_word;

architecture Behavioral of program_status_word is

begin
	--process (clk, rst, c, z, o, r, h)
	process (rst, z, c, o, r, h)
	begin
		if (rst = '1') then
			psw <= "00000";
		else
		--elsif (clk = '1') then
			psw(0) <= z;
			psw(1) <= c;
			psw(2) <= o;
			psw(3) <= r;
			psw(4) <= h;
		end if;
	end process;

end Behavioral;

