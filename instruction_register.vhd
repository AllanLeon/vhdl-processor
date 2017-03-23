----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:32:43 02/24/2017 
-- Design Name: 
-- Module Name:    instruction_register - Behavioral 
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

entity instruction_register is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  rw : in STD_LOGIC;
			  opn : in STD_LOGIC_VECTOR(0 to 1);
           din : in  STD_LOGIC_VECTOR (7 downto 0);
           dout : out  STD_LOGIC_VECTOR (23 downto 0) := x"000000");
end instruction_register;

architecture Behavioral of instruction_register is

begin
	process (clk, rst, din)
	begin
		if (rst = '1') then
			dout <= x"000000";
		elsif (clk'event and clk = '1') then
		--elsif (clk = '1') then
			if (rw = '1') then
				case opn is
					when "00" =>
						dout(23 downto 16) <= din;
					when "01" =>
						dout(15 downto 8) <= din;
					when "10" =>
						dout(7 downto 0) <= din;
					when others =>
				end case;
			end if;
		end if;
	end process;

end Behavioral;

