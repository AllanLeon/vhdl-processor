----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:19:02 03/19/2017 
-- Design Name: 
-- Module Name:    mux_addr - Behavioral 
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

entity mux_addr is
	Port (  mar : in  STD_LOGIC_VECTOR (7 downto 0);
           pc : in  STD_LOGIC_VECTOR (7 downto 0);
			  ir : in  STD_LOGIC_VECTOR (23 downto 0);
           s_mar : in  STD_LOGIC_VECTOR (0 to 1);
			  s_pc : in STD_LOGIC_VECTOR (0 to 1);
			  s_ir : in STD_LOGIC_VECTOR (0 to 4);
           addr_bus : out  STD_LOGIC_VECTOR (7 downto 0) := x"00");
end mux_addr;

architecture Behavioral of mux_addr is

begin
	process (s_mar, s_pc, s_ir, mar, pc, ir)
	begin
		if (s_mar = "10") then
			addr_bus <= mar;
			
		elsif (s_pc = "10") then
			addr_bus <= pc;
		
		elsif (s_ir(0 to 1) = "10" and s_ir(4) = '1') then
			if (s_ir(2 to 3) = "01") then
				addr_bus <= ir(15 downto 8);
			elsif (s_ir(2 to 3) = "10") then
				addr_bus <= ir(7 downto 0);
			end if;
		end if;
	end process;

end Behavioral;

