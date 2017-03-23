----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:21:48 02/24/2017 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
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

entity control_unit is
    Port ( clk : in STD_LOGIC;
			  rst : in STD_LOGIC;
			  inst : in  STD_LOGIC_VECTOR (23 downto 0);
			  psw : in STD_LOGIC_VECTOR (0 to 4);
			  io : in STD_LOGIC_VECTOR (0 to 1) := "00";
			  pc : out STD_LOGIC_VECTOR (0 to 4) := "00000";
			  ir : out STD_LOGIC_VECTOR (0 to 4) := "00000";
			  mar : out STD_LOGIC_VECTOR (0 to 2) := "000";
			  mbr : out STD_LOGIC_VECTOR (0 to 2) := "000";
			  acc : out STD_LOGIC_VECTOR (0 to	2) := "000";
			  ram : out STD_LOGIC_VECTOR (0 to	2) := "000";
			  regs : out STD_LOGIC_VECTOR (0 to	2) := "000";
			  alua : out STD_LOGIC_VECTOR (0 to	2) := "000";
			  alub : out STD_LOGIC_VECTOR (0 to	2) := "000";
			  alu : out STD_LOGIC_VECTOR (0 to	3) := "0000";
			  output : out STD_LOGIC_VECTOR (0 to	2) := "000";
			  cb_psw : out STD_LOGIC_VECTOR(0 to 2) := "000");
end control_unit;

architecture Behavioral of control_unit is

--type state is (load_ins,
type state is (load_ins_1, load_ins_2,
					fetch_ins_1, fetch_ins_2, fetch_ins_3, fetch_ins_4, fetch_ins_5, fetch_ins_6, fetch_ins_7, fetch_ins_8, fetch_ins_9,
					decode_ins,
					mov_mem_1, mov_mem_2, mov_mem_3, mov_mem_4,
					mov_reg_1, mov_reg_2, mov_reg_3, mov_reg_4,
					show_1, show_2, show_3,
					add_reg_1, add_reg_2, add_reg_3, add_reg_4, add_reg_5, add_reg_6, add_reg_7, add_reg_8,
					add_mem_1, add_mem_2, add_mem_3, add_mem_4, add_mem_5, add_mem_6, add_mem_7, add_mem_8,
					and_reg_1, and_reg_2, and_reg_3, and_reg_4, and_reg_5, and_reg_6, and_reg_7, and_reg_8,
					and_mem_1, and_mem_2, and_mem_3, and_mem_4, and_mem_5, and_mem_6, and_mem_7, and_mem_8,
					cmp_reg_1, cmp_reg_2, cmp_reg_3, cmp_reg_4, cmp_reg_5, cmp_reg_6,
					cmp_mem_1, cmp_mem_2, cmp_mem_3, cmp_mem_4, cmp_mem_5, cmp_mem_6,
					not_1, not_2, not_3, not_4, not_5,
					jmp, ja, jae, jb, jbe, je, jne,
					stop, reset);
signal current_state, next_state: state;

signal opcode, op1, op2, op_reg: STD_LOGIC_VECTOR(7 downto 0) := x"00";

begin
	process (clk, rst) begin
		if (rst = '1') then
			--current_state <= fetch_ins_1;
		elsif (clk'event and clk = '1') then
			current_state <= next_state;
		end if;
	end process;
	
	process (current_state, io)-- io???
	begin
		pc <= "00000";
		ir <= "00000";
		mar <= "000";
		mbr <= "000";
		acc <= "000";
		ram <= "000";
		regs <= "000";
		alua <= "000";
		alub <= "000";
		alu <= "0000";
		output <= "000";
		cb_psw <= "000";
		
		case current_state is
--			when load_ins =>
--				ram(2) <= '1';
--				next_state <= fetch_ins_1;

			when load_ins_1 =>
				if (io(0) = '1') then
					mar(0) <= '1';
					mar(1) <= '1';
					
					pc(0) <= '1';
					pc(1) <= '0';
					
					mbr(0) <= '1';
					mbr(1) <= '1';
					
					next_state <= load_ins_2;
				elsif (io(1) = '1') then
					pc(4) <= '1';
				
					next_state <= fetch_ins_1;
				end if;
			
			when load_ins_2 =>
				if (io(0) = '0') then
					ram(0) <= '1';
					ram(1) <= '1';
					
					pc(0) <= '1';
					pc(1) <= '1';
					pc(2) <= '1';
					next_state <= load_ins_1;
				end if;
		
			when fetch_ins_1 =>
				pc(0) <= '1';
				pc(1) <= '0';
				
				mar(0) <= '1';
				mar(1) <= '1';
				
				next_state <= fetch_ins_2;
			when fetch_ins_2 =>
				mbr(0) <= '1';
				mbr(1) <= '1';
				
				ram(0) <= '1';
				ram(1) <= '0';
				
				pc(0) <= '1';
				pc(1) <= '1';
				pc(2) <= '1';
				
				next_state <= fetch_ins_3;
			when fetch_ins_3 =>
				ir(0) <= '1';
				ir(1) <= '1';
				ir(2 to 3) <= "00";
				
				mbr(0) <= '1';
				mbr(1) <= '0';
				
				next_state <= fetch_ins_4;
			when fetch_ins_4 =>
				--opcode <= inst;
				
				pc(0) <= '1';
				pc(1) <= '0';
				
				mar(0) <= '1';
				mar(1) <= '1';
				
				next_state <= fetch_ins_5;
			when fetch_ins_5 =>
				mbr(0) <= '1';
				mbr(1) <= '1';
				
				ram(0) <= '1';
				ram(1) <= '0';
				
				pc(0) <= '1';
				pc(1) <= '1';
				pc(2) <= '1';
				
				next_state <= fetch_ins_6;
			when fetch_ins_6 =>
				ir(0) <= '1';
				ir(1) <= '1';
				ir(2 to 3) <= "01";
				
				mbr(0) <= '1';
				mbr(1) <= '0';
				
				next_state <= fetch_ins_7;
			when fetch_ins_7 =>
				--op1 <= inst;
				
				pc(0) <= '1';
				pc(1) <= '0';
				
				mar(0) <= '1';
				mar(1) <= '1';
				
				next_state <= fetch_ins_8;
			when fetch_ins_8 =>
				mbr(0) <= '1';
				mbr(1) <= '1';
				
				ram(0) <= '1';
				ram(1) <= '0';
				
				pc(0) <= '1';
				pc(1) <= '1';
				pc(2) <= '1';
				
				next_state <= fetch_ins_9;
			when fetch_ins_9 =>
				ir(0) <= '1';
				ir(1) <= '1';
				ir(2 to 3) <= "10";
				
				mbr(0) <= '1';
				mbr(1) <= '0';
				
				next_state <= decode_ins;
			when decode_ins =>
				--op2 <= inst;
				
				case inst(23 downto 18) is
					when "000000" => -- RESET
						next_state <= reset;
					when "000111" => -- HALT
						next_state <= stop;
					when "001000" => -- MOV to register
						next_state <= mov_reg_1;
					when "001001" => -- MOV to memory
						next_state <= mov_mem_1;
					when "001111" => -- SHOW
						next_state <= show_1;
					when "010000" => -- ADD to register
						next_state <= add_reg_1;
					when "010001" => -- ADD to memory
						next_state <= add_mem_1;
					when "010010" => -- NOT
						next_state <= not_1;
					when "010011" => -- AND to register
						next_state <= and_reg_1;
					when "010100" => -- AND to memory
						next_state <= and_mem_1;
					when "010110" => -- COMPARE from register
						next_state <= cmp_reg_1;
					when "010111" => -- COMPARE from memory
						next_state <= cmp_mem_1;
					when "011000" => -- inconditional JUMP
						next_state <= jmp;
					when "011010" => -- JUMP >
						next_state <= ja;
					when "011011" => -- JUMP >=
						next_state <= jae;
					when "011100" => -- JUMP <
						next_state <= jb;
					when "011101" => -- JUMP <=
						next_state <= jbe;
					when "011110" => -- JUMP =
						next_state <= je;
					when "011111" => -- JUMP !=
						next_state <= jne;
					
					when others =>
						next_state <= fetch_ins_1;
				end case;
			

-------------------------------------- MOV TO MEM -----------------------------------------
			when mov_mem_1 =>
				case inst(17 downto 16) is
					when "00" =>
						--opr(0) <= '1';
						--opr(1) <= '1';
						mbr(0) <= '1';
						mbr(1) <= '1';
						
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '0';
						
						next_state <= mov_mem_3;
					when "01" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= mov_mem_2;
					when "10" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= mov_mem_2;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when mov_mem_2 =>
				case inst(17 downto 16) is
					when "01" =>
						mbr(0) <= '1';
						mbr(1) <= '1';
						
						regs(0) <= '1';
						regs(1) <= '0';
						
						next_state <= mov_mem_3;
					when "10" =>
						mbr(0) <= '1';
						mbr(1) <= '1';
						
						ram(0) <= '1';
						ram(1) <= '0';
						
						next_state <= mov_mem_3;
					when others =>
						next_state <= fetch_ins_1;
				end case;
--			when mov_mem_3 =>
--				opr(0) <= '1';
--				opr(1) <= '1';
--				
--				mbr(0) <= '1';
--				mbr(1) <= '0';
--				
--				next_state <= mov_mem_4;
			when mov_mem_3 =>
				ir(0) <= '1';
				ir(1) <= '0';
				ir(2 to 3) <= "01";
				ir(4) <= '1';
		
				mar(0) <= '1';
				mar(1) <= '1';
				next_state <= mov_mem_4;
			when mov_mem_4 =>
				ram(0) <= '1';
				ram(1) <= '1';
				
				next_state <= fetch_ins_1;
				
				
-------------------------------------- MOV TO REG -----------------------------------------
			when mov_reg_1 =>
				case inst(17 downto 16) is
					when "00" =>
						--opr(0) <= '1';
						--opr(1) <= '1';
						mbr(0) <= '1';
						mbr(1) <= '1';
						
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '0';
						
						next_state <= mov_reg_3;
					when "01" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= mov_reg_2;
					when "10" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= mov_reg_2;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when mov_reg_2 =>
				case inst(17 downto 16) is
					when "01" =>
						mbr(0) <= '1';
						mbr(1) <= '1';
						
						regs(0) <= '1';
						regs(1) <= '0';
						
						next_state <= mov_reg_3;
					when "10" =>
						mbr(0) <= '1';
						mbr(1) <= '1';
						
						ram(0) <= '1';
						ram(1) <= '0';
						
						next_state <= mov_reg_3;
					when others =>
						next_state <= fetch_ins_1;
				end case;
--			when mov_reg_3 =>
--				opr(0) <= '1';
--				opr(1) <= '1';
--				
--				mbr(0) <= '1';
--				mbr(1) <= '0';
--				
--				next_state <= mov_reg_4;
			when mov_reg_3 =>
				ir(0) <= '1';
				ir(1) <= '0';
				ir(2 to 3) <= "01";
				ir(4) <= '1';
		
				mar(0) <= '1';
				mar(1) <= '1';
				next_state <= mov_reg_4;
			when mov_reg_4 =>
				regs(0) <= '1';
				regs(1) <= '1';
				
				next_state <= fetch_ins_1;
				



-------------------------------------- SHOW -----------------------------------------
			when show_1 =>
				case inst(17 downto 16) is
					when "00" =>
						output(0) <= '1';
						output(1) <= '1';
						
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "01";
						ir(4) <= '0';
						
						next_state <= fetch_ins_1;
					when "01" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "01";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= show_2;
					when "10" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "01";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= show_2;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when show_2 =>
				case inst(17 downto 16) is
					when "01" =>
						mbr(0) <= '1';
						mbr(1) <= '1';
						
						regs(0) <= '1';
						regs(1) <= '0';
						
						next_state <= show_3;
					when "10" =>
						mbr(0) <= '1';
						mbr(1) <= '1';
						
						ram(0) <= '1';
						ram(1) <= '0';
						
						next_state <= show_3;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when show_3 =>
				output(0) <= '1';
				output(1) <= '1';
		
				mbr(0) <= '1';
				mbr(1) <= '0';
				next_state <= fetch_ins_1;
				
				
				
				
-------------------------------------- ADD TO REG -----------------------------------------
			when add_reg_1 =>
				case inst(17 downto 16) is
					when "00" =>
						--opr(0) <= '1';
						--opr(1) <= '1';
						alub(0) <= '1';
						alub(1) <= '1';
						
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '0';
						
						next_state <= add_reg_3;
					when "01" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= add_reg_2;
					when "10" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= add_reg_2;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when add_reg_2 =>
				case inst(17 downto 16) is
					when "01" =>
						alub(0) <= '1';
						alub(1) <= '1';
						
						regs(0) <= '1';
						regs(1) <= '0';
						
						next_state <= add_reg_3;
					when "10" =>
						alub(0) <= '1';
						alub(1) <= '1';
						
						ram(0) <= '1';
						ram(1) <= '0';
						
						next_state <= add_reg_3;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when add_reg_3 =>
				ir(0) <= '1';
				ir(1) <= '0';
				ir(2 to 3) <= "01";
				ir(4) <= '1';
		
				mar(0) <= '1';
				mar(1) <= '1';
				next_state <= add_reg_4;
			when add_reg_4 =>
				mbr(0) <= '1';
				mbr(1) <= '1';
				
				regs(0) <= '1';
				regs(1) <= '0';
				
				next_state <= add_reg_5;
			when add_reg_5 =>
				alua(0) <= '1';
				alua(1) <= '1';
				
				mbr(0) <= '1';
				mbr(1) <= '0';
				
				next_state <= add_reg_6;
			when add_reg_6 =>
				alu <= "1000";
				
				alua(0) <= '1';
				alua(1) <= '1';
				next_state <= add_reg_7;
			when add_reg_7 =>
				alua <= "100";
				mbr <= "110";
			
				ir(0) <= '1';
				ir(1) <= '0';
				ir(2 to 3) <= "01";
				ir(4) <= '1';
		
				mar(0) <= '1';
				mar(1) <= '1';
				next_state <= add_reg_8;
			when add_reg_8 =>
				regs(0) <= '1';
				regs(1) <= '1';
				next_state <= fetch_ins_1;



-------------------------------------- ADD TO MEM -----------------------------------------
			when add_mem_1 =>
				case inst(17 downto 16) is
					when "00" =>
						--opr(0) <= '1';
						--opr(1) <= '1';
						alub(0) <= '1';
						alub(1) <= '1';
						
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '0';
						
						next_state <= add_mem_3;
					when "01" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= add_mem_2;
					when "10" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= add_mem_2;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when add_mem_2 =>
				case inst(17 downto 16) is
					when "01" =>
						alub(0) <= '1';
						alub(1) <= '1';
						
						regs(0) <= '1';
						regs(1) <= '0';
						
						next_state <= add_mem_3;
					when "10" =>
						alub(0) <= '1';
						alub(1) <= '1';
						
						ram(0) <= '1';
						ram(1) <= '0';
						
						next_state <= add_mem_3;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when add_mem_3 =>
				ir(0) <= '1';
				ir(1) <= '0';
				ir(2 to 3) <= "01";
				ir(4) <= '1';
		
				mar(0) <= '1';
				mar(1) <= '1';
				next_state <= add_mem_4;
			when add_mem_4 =>
				mbr(0) <= '1';
				mbr(1) <= '1';
				
				ram(0) <= '1';
				ram(1) <= '0';
				
				next_state <= add_mem_5;
			when add_mem_5 =>
				alua(0) <= '1';
				alua(1) <= '1';
				
				mbr(0) <= '1';
				mbr(1) <= '0';
				
				next_state <= add_mem_6;
			when add_mem_6 =>
				alu <= "1000";
				
				alua(0) <= '1';
				alua(1) <= '1';
				next_state <= add_mem_7;
			when add_mem_7 =>
				alua <= "100";
				mbr <= "110";
			
				ir(0) <= '1';
				ir(1) <= '0';
				ir(2 to 3) <= "01";
				ir(4) <= '1';
		
				mar(0) <= '1';
				mar(1) <= '1';
				next_state <= add_mem_8;
			when add_mem_8 =>
				ram(0) <= '1';
				ram(1) <= '1';
				next_state <= fetch_ins_1;
		


-------------------------------------- AND TO REG -----------------------------------------
			when and_reg_1 =>
				case inst(17 downto 16) is
					when "00" =>
						--opr(0) <= '1';
						--opr(1) <= '1';
						alub(0) <= '1';
						alub(1) <= '1';
						
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '0';
						
						next_state <= and_reg_3;
					when "01" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= and_reg_2;
					when "10" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= and_reg_2;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when and_reg_2 =>
				case inst(17 downto 16) is
					when "01" =>
						alub(0) <= '1';
						alub(1) <= '1';
						
						regs(0) <= '1';
						regs(1) <= '0';
						
						next_state <= and_reg_3;
					when "10" =>
						alub(0) <= '1';
						alub(1) <= '1';
						
						ram(0) <= '1';
						ram(1) <= '0';
						
						next_state <= and_reg_3;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when and_reg_3 =>
				ir(0) <= '1';
				ir(1) <= '0';
				ir(2 to 3) <= "01";
				ir(4) <= '1';
		
				mar(0) <= '1';
				mar(1) <= '1';
				next_state <= and_reg_4;
			when and_reg_4 =>
				mbr(0) <= '1';
				mbr(1) <= '1';
				
				regs(0) <= '1';
				regs(1) <= '0';
				
				next_state <= and_reg_5;
			when and_reg_5 =>
				alua(0) <= '1';
				alua(1) <= '1';
				
				mbr(0) <= '1';
				mbr(1) <= '0';
				
				next_state <= and_reg_6;
			when and_reg_6 =>
				alu <= "1010";
				
				alua(0) <= '1';
				alua(1) <= '1';
				next_state <= and_reg_7;
			when and_reg_7 =>
				alua <= "100";
				mbr <= "110";
			
				ir(0) <= '1';
				ir(1) <= '0';
				ir(2 to 3) <= "01";
				ir(4) <= '1';
		
				mar(0) <= '1';
				mar(1) <= '1';
				next_state <= and_reg_8;
			when and_reg_8 =>
				regs(0) <= '1';
				regs(1) <= '1';
				next_state <= fetch_ins_1;



-------------------------------------- AND TO MEM -----------------------------------------
			when and_mem_1 =>
				case inst(17 downto 16) is
					when "00" =>
						--opr(0) <= '1';
						--opr(1) <= '1';
						alub(0) <= '1';
						alub(1) <= '1';
						
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '0';
						
						next_state <= and_mem_3;
					when "01" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= and_mem_2;
					when "10" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= and_mem_2;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when and_mem_2 =>
				case inst(17 downto 16) is
					when "01" =>
						alub(0) <= '1';
						alub(1) <= '1';
						
						regs(0) <= '1';
						regs(1) <= '0';
						
						next_state <= and_mem_3;
					when "10" =>
						alub(0) <= '1';
						alub(1) <= '1';
						
						ram(0) <= '1';
						ram(1) <= '0';
						
						next_state <= and_mem_3;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when and_mem_3 =>
				ir(0) <= '1';
				ir(1) <= '0';
				ir(2 to 3) <= "01";
				ir(4) <= '1';
		
				mar(0) <= '1';
				mar(1) <= '1';
				next_state <= and_mem_4;
			when and_mem_4 =>
				mbr(0) <= '1';
				mbr(1) <= '1';
				
				ram(0) <= '1';
				ram(1) <= '0';
				
				next_state <= and_mem_5;
			when and_mem_5 =>
				alua(0) <= '1';
				alua(1) <= '1';
				
				mbr(0) <= '1';
				mbr(1) <= '0';
				
				next_state <= and_mem_6;
			when and_mem_6 =>
				alu <= "1010";
				
				alua(0) <= '1';
				alua(1) <= '1';
				next_state <= and_mem_7;
			when and_mem_7 =>
				alua <= "100";
				mbr <= "110";
			
				ir(0) <= '1';
				ir(1) <= '0';
				ir(2 to 3) <= "01";
				ir(4) <= '1';
		
				mar(0) <= '1';
				mar(1) <= '1';
				next_state <= and_mem_8;
			when and_mem_8 =>
				ram(0) <= '1';
				ram(1) <= '1';
				next_state <= fetch_ins_1;




-------------------------------------- NOT -----------------------------------------
			when not_1 =>
				ir(0) <= '1';
				ir(1) <= '0';
				ir(2 to 3) <= "01";
				ir(4) <= '1';
		
				mar(0) <= '1';
				mar(1) <= '1';
				
				next_state <= not_2;
			when not_2 =>
				case inst(17 downto 16) is
					when "01" =>
						alua(0) <= '1';
						alua(1) <= '1';
						
						regs(0) <= '1';
						regs(1) <= '0';
						
						next_state <= not_3;
					when "10" =>
						alua(0) <= '1';
						alua(1) <= '1';
						
						ram(0) <= '1';
						ram(1) <= '0';
						
						next_state <= not_3;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when not_3 =>
				alu <= "1011";
				
				alua(0) <= '1';
				alua(1) <= '1';
				next_state <= not_4;
			when not_4 =>
				alua <= "100";
				mbr <= "110";
			
				ir(0) <= '1';
				ir(1) <= '0';
				ir(2 to 3) <= "01";
				ir(4) <= '1';
		
				mar(0) <= '1';
				mar(1) <= '1';
				next_state <= not_5;
			when not_5 =>
				case inst(17 downto 16) is
					when "01" =>
						regs(0) <= '1';
						regs(1) <= '1';
					when "10" =>
						ram(0) <= '1';
						ram(1) <= '1';
					when others =>
				end case;
				next_state <= fetch_ins_1;





-------------------------------------- CMP FROM REG -----------------------------------------
			when cmp_reg_1 =>
				case inst(17 downto 16) is
					when "00" =>
						--opr(0) <= '1';
						--opr(1) <= '1';
						alub(0) <= '1';
						alub(1) <= '1';
						
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '0';
						
						next_state <= cmp_reg_3;
					when "01" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= cmp_reg_2;
					when "10" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= cmp_reg_2;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when cmp_reg_2 =>
				case inst(17 downto 16) is
					when "01" =>
						alub(0) <= '1';
						alub(1) <= '1';
						
						regs(0) <= '1';
						regs(1) <= '0';
						
						next_state <= cmp_reg_3;
					when "10" =>
						alub(0) <= '1';
						alub(1) <= '1';
						
						ram(0) <= '1';
						ram(1) <= '0';
						
						next_state <= cmp_reg_3;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when cmp_reg_3 =>
				ir(0) <= '1';
				ir(1) <= '0';
				ir(2 to 3) <= "01";
				ir(4) <= '1';
		
				mar(0) <= '1';
				mar(1) <= '1';
				next_state <= cmp_reg_4;
			when cmp_reg_4 =>
				mbr(0) <= '1';
				mbr(1) <= '1';
				
				regs(0) <= '1';
				regs(1) <= '0';
				
				next_state <= cmp_reg_5;
			when cmp_reg_5 =>
				alua(0) <= '1';
				alua(1) <= '1';
				
				mbr(0) <= '1';
				mbr(1) <= '0';
				
				next_state <= cmp_reg_6;
			when cmp_reg_6 =>
				alu <= "1111";
				
				next_state <= fetch_ins_1;
				
				
				
				
				
				
-------------------------------------- CMP FROM MEM -----------------------------------------
			when cmp_mem_1 =>
				case inst(17 downto 16) is
					when "00" =>
						--opr(0) <= '1';
						--opr(1) <= '1';
						alub(0) <= '1';
						alub(1) <= '1';
						
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '0';
						
						next_state <= cmp_mem_3;
					when "01" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= cmp_mem_2;
					when "10" =>
						ir(0) <= '1';
						ir(1) <= '0';
						ir(2 to 3) <= "10";
						ir(4) <= '1';
				
						mar(0) <= '1';
						mar(1) <= '1';
						
						next_state <= cmp_mem_2;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when cmp_mem_2 =>
				case inst(17 downto 16) is
					when "01" =>
						alub(0) <= '1';
						alub(1) <= '1';
						
						regs(0) <= '1';
						regs(1) <= '0';
						
						next_state <= cmp_mem_3;
					when "10" =>
						alub(0) <= '1';
						alub(1) <= '1';
						
						ram(0) <= '1';
						ram(1) <= '0';
						
						next_state <= cmp_mem_3;
					when others =>
						next_state <= fetch_ins_1;
				end case;
			when cmp_mem_3 =>
				ir(0) <= '1';
				ir(1) <= '0';
				ir(2 to 3) <= "01";
				ir(4) <= '1';
		
				mar(0) <= '1';
				mar(1) <= '1';
				next_state <= cmp_mem_4;
			when cmp_mem_4 =>
				mbr(0) <= '1';
				mbr(1) <= '1';
				
				ram(0) <= '1';
				ram(1) <= '0';
				
				next_state <= cmp_mem_5;
			when cmp_mem_5 =>
				alua(0) <= '1';
				alua(1) <= '1';
				
				mbr(0) <= '1';
				mbr(1) <= '0';
				
				next_state <= cmp_mem_6;
			when cmp_mem_6 =>
				alu <= "1111";
				
				next_state <= fetch_ins_1;
				
				
				



-------------------------------------- JMP -----------------------------------------
			when jmp =>
				ir(0) <= '1';
				ir(1) <= '0';
				ir(2 to 3) <= "01";
				ir(4) <= '1';
				
				pc <= "11010";
				
				next_state <= fetch_ins_1;
				
			when ja =>
				if (psw(0) = '0' and psw(1) = '0') then
					ir(0) <= '1';
					ir(1) <= '0';
					ir(2 to 3) <= "01";
					ir(4) <= '1';
					
					pc <= "11010";
				end if;
				
				next_state <= fetch_ins_1;
			
			when jae =>
				if (psw(1) = '0') then
					ir(0) <= '1';
					ir(1) <= '0';
					ir(2 to 3) <= "01";
					ir(4) <= '1';
					
					pc <= "11010";
				end if;
				
				next_state <= fetch_ins_1;	
			
			when jb =>
				if (psw(1) = '1') then
					ir(0) <= '1';
					ir(1) <= '0';
					ir(2 to 3) <= "01";
					ir(4) <= '1';
					
					pc <= "11010";
				end if;
				
				next_state <= fetch_ins_1;	
			
			when jbe =>
				if (psw(0) = '1' and psw(1) = '1') then
					ir(0) <= '1';
					ir(1) <= '0';
					ir(2 to 3) <= "01";
					ir(4) <= '1';
					
					pc <= "11010";
				end if;
				
				next_state <= fetch_ins_1;
			
			when je =>
				if (psw(0) = '1') then
					ir(0) <= '1';
					ir(1) <= '0';
					ir(2 to 3) <= "01";
					ir(4) <= '1';
					
					pc <= "11010";
				end if;
				
				next_state <= fetch_ins_1;
			
			when jne =>
				if (psw(0) = '0') then
					ir(0) <= '1';
					ir(1) <= '0';
					ir(2 to 3) <= "01";
					ir(4) <= '1';
					
					pc <= "11010";
				end if;
				
				next_state <= fetch_ins_1;
			
			
			
				
				
			when reset =>
				cb_psw <= "110";
				next_state <= load_ins_1;

			when stop =>
				--next_state <= stop;

		end case;
	end process;
	

end Behavioral;

