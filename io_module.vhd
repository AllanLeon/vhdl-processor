----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:32:56 03/22/2017 
-- Design Name: 
-- Module Name:    io_module - Behavioral 
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

entity io_module is
	 Port ( clk : in STD_LOGIC;
			  rst : in STD_LOGIC;
			  start : in STD_LOGIC;
			  ins : in STD_LOGIC;
			  din : in STD_LOGIC_VECTOR (5 downto 0);
			  dout : out STD_LOGIC_VECTOR(7 downto 0);
			  ram : out STD_LOGIC := '0';
			  exe : out STD_LOGIC := '0');
end io_module;

architecture Behavioral of io_module is
	 
			  
type state is (read_ins_1, read_ins_2, read_ins_3, read_ins_4,
					save_ins_1, save_ins_1_idle, save_ins_2, save_ins_2_idle, save_ins_3,
					execute);
signal current_state, next_state: state;
signal instruction : STD_LOGIC_VECTOR (23 downto 0) := x"000000";

begin

	process (clk, rst, start, ins) begin
		if (rst = '1') then
			current_state <= read_ins_1;
		elsif (clk'event and clk = '1') then
			if (start = '1') then
				current_state <= execute;
			else
				if (ins = '0') then
					current_state <= next_state;
				end if;
			end if;
		end if;
	end process;
	
	process (current_state, ins)
	begin
		ram <= '0';
		exe <= '0';
		case current_state is
			when read_ins_1 =>
				if (ins = '1') then
					instruction(23 downto 18) <= din;
					next_state <= read_ins_2;
				end if;
			
			when read_ins_2 =>
				if (ins = '1') then
					instruction(17 downto 12) <= din;
					next_state <= read_ins_3;
				end if;
			
			when read_ins_3 =>
				if (ins = '1') then
					instruction(11 downto 6) <= din;
					next_state <= read_ins_4;
				end if;
			
			when read_ins_4 =>
				if (ins = '1') then
					instruction(5 downto 0) <= din;
					next_state <= save_ins_1;
				end if;
			
			when save_ins_1 =>
				dout <= instruction(23 downto 16);
				ram <= '1';
				next_state <= save_ins_1_idle;
			
			when save_ins_1_idle =>
				ram <= '0';
				next_state <= save_ins_2;
			
			when save_ins_2 =>
				dout <= instruction(15 downto 8);
				ram <= '1';
				next_state <= save_ins_2_idle;
			
			when save_ins_2_idle =>
				ram <= '0';
				next_state <= save_ins_3;
			
			when save_ins_3 =>
				dout <= instruction(7 downto 0);
				ram <= '1';
				next_state <= read_ins_1;
			
			when execute =>
				exe <= '1';
				next_state <= execute;
		end case;
	end process;
	

end Behavioral;

