----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:21:25 03/20/2017 
-- Design Name: 
-- Module Name:    arithmetic_logic_unit - Behavioral 
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

entity arithmetic_logic_unit is
	Port ( clk : in  STD_LOGIC;
			 rst : in  STD_LOGIC;
			 opcode: in STD_LOGIC_VECTOR (2 downto 0):= "000";
          op1 : in  STD_LOGIC_VECTOR (7 downto 0) := x"00";
          op2 : in  STD_LOGIC_VECTOR (7 downto 0) := x"00";
          res : out  STD_LOGIC_VECTOR (7 downto 0) := x"00";
			 control : out STD_LOGIC_VECTOR(0 to 2) := "000"); -- Zero-Carry-Overflow
end arithmetic_logic_unit;

architecture Behavioral of arithmetic_logic_unit is

begin
	process (clk, rst)
	begin
		if (rst = '1') then
			res <= x"00";
		elsif (clk'event and clk='1') then
			case opcode is
				when "000" =>
					res <= std_logic_vector(unsigned(op1) + unsigned(op2));
				when "010" =>
					res <= op1 and op2;
				when "011" =>
					res <= not op1;
					
				when "111" =>
					if (op1 = op2) then
						control(0) <= '1';
					else
						control(0) <= '0';
					end if;
					if (op1 > op2) then
						control(1) <= '0';
					else
						control(1) <= '1';
					end if;
				when others =>
			end case;
		end if;
	end process;

end Behavioral;

