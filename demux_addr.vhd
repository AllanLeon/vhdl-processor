----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:19:11 03/19/2017 
-- Design Name: 
-- Module Name:    demux_addr - Behavioral 
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

entity demux_addr is
	Port (  addr_bus : in  STD_LOGIC_VECTOR (7 downto 0);
			  
           s_mar : in  STD_LOGIC;
			  s_pc : in STD_LOGIC;
			  s_mar : in STD_LOGIC;
           pc : out  STD_LOGIC_VECTOR (7 downto 0));
end demux_addr;

architecture Behavioral of demux_addr is

begin


end Behavioral;

