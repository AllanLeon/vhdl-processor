----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:31:40 02/24/2017 
-- Design Name: 
-- Module Name:    memory_buffer_register - Behavioral 
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

entity memory_buffer_register is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  din : in  STD_LOGIC_VECTOR (7 downto 0);
           dout : out  STD_LOGIC_VECTOR (7 downto 0));
end memory_buffer_register;

architecture Behavioral of memory_buffer_register is

begin
	process (clk, rst, din)
	begin
		if (rst = '1') then
			dout <= x"00";
		--if (clk'event and clk = '1') then
		elsif (clk = '1') then
			dout <= din;
		end if;
	end process;

end Behavioral;

