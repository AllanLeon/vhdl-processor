----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:55:47 02/25/2017 
-- Design Name: 
-- Module Name:    accumulator - Behavioral 
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

entity accumulator is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           add : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (7 downto 0);
           dout : inout  STD_LOGIC_VECTOR (7 downto 0));
end accumulator;

architecture Behavioral of accumulator is

begin
	process (clk, rst, add)
	begin
		if (rst = '1') then
			dout <= x"00";
		elsif (add = '1') then
			dout <= std_logic_vector(unsigned(din) + unsigned(dout));
		elsif (clk = '1') then
			dout <= din;
		end if;
	end process;

end Behavioral;

