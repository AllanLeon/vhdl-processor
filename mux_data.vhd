----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:34:20 03/19/2017 
-- Design Name: 
-- Module Name:    mux_data - Behavioral 
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

entity mux_data is
	Port (  ram : in  STD_LOGIC_VECTOR (7 downto 0);
           reg_mem : in  STD_LOGIC_VECTOR (7 downto 0);
			  mbr : in  STD_LOGIC_VECTOR (7 downto 0);
			  ir : in  STD_LOGIC_VECTOR (23 downto 0);
			  alua : in  STD_LOGIC_VECTOR (7 downto 0);
			  alu : in  STD_LOGIC_VECTOR (7 downto 0);
			  io : in STD_LOGIC_VECTOR (7 downto 0);
           s_ram : in  STD_LOGIC_VECTOR (0 to 1);
			  s_reg : in STD_LOGIC_VECTOR (0 to 1);
			  s_mbr : in STD_LOGIC_VECTOR (0 to 1);
			  s_ir : in STD_LOGIC_VECTOR (0 to 4);
			  s_alua : in STD_LOGIC_VECTOR (0 to 1);
			  s_alu : in STD_LOGIC;
			  s_io : in STD_LOGIC;
           data_bus : out  STD_LOGIC_VECTOR (7 downto 0) := x"00");
end mux_data;

architecture Behavioral of mux_data is

begin
	process (s_ram, s_reg, s_mbr, s_ir, s_alua, s_alu, s_io, ram, reg_mem, mbr, ir, alua, alu, io)
	begin
		if (s_ram = "10") then
			data_bus <= ram;
			
		elsif (s_reg = "10") then
			data_bus <= reg_mem;
			
		elsif (s_mbr = "10") then
			data_bus <= mbr;
			
		elsif (s_alua = "10") then
			data_bus <= alua;
		
		elsif (s_alu = '1') then
			data_bus <= alu;
		
		elsif (s_io = '1') then
			data_bus <= io;
			
		elsif (s_ir(0 to 1) = "10" and s_ir(4) = '0') then
			if (s_ir(2 to 3) = "01") then
				data_bus <= ir(15 downto 8);
			elsif (s_ir(2 to 3) = "10") then
				data_bus <= ir(7 downto 0);
			end if;
		end if;
	end process;

end Behavioral;

