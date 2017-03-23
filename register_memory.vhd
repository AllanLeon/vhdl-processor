----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:08:07 03/17/2017 
-- Design Name: 
-- Module Name:    register_memory - Behavioral 
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

entity register_memory is
	Port ( clk : in  STD_LOGIC;
			 rst : in  STD_LOGIC;
			 e : in STD_LOGIC;
          rw : in  STD_LOGIC;
          t : in  STD_LOGIC;
          addr : in  STD_LOGIC_VECTOR (7 downto 0);
          din : in  STD_LOGIC_VECTOR (7 downto 0);
          dout : out  STD_LOGIC_VECTOR (7 downto 0));
end register_memory;

architecture Behavioral of register_memory is

type array_8bit is array (0 to 7) of STD_LOGIC_VECTOR(7 downto 0); 
signal regs : array_8bit := ((others=> (others=>'0')));
	
begin

	process (clk, rst)
		variable addr_int : INTEGER := 0;
		variable i : INTEGER;
	begin
		if (rst = '1') then
			--for i in 0 to 65536 loop
--				regs(i) <= "00000000";
			--end loop;
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

