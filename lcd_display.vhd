----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:10:51 12/09/2016 
-- Design Name: 
-- Module Name:    lcd_display - Behavioral 
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

entity lcd_display is
	 Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (7 downto 0);
			  E : inout  STD_LOGIC;
           RS : out  STD_LOGIC;
           RW : out  STD_LOGIC;
           SF_CE0 : out  STD_LOGIC;
           DB : out  STD_LOGIC_VECTOR (3 downto 0));
end lcd_display;

architecture Behavioral of lcd_display is

type state is (FI1A,FI1B,FI2A,FI2B,FI3A,FI3B,BOR1,BOR2,CONT1,CONT2,
	                 MOD1,MOD2,zero1,zero2,x1,x2,hex1,hex2,hex3,hex4,
						  rl1,rl2,rl3,rl4,done1,done2);	
	signal pr_state,nx_state:state;
	--signal data1, data2: STD_LOGIC_VECTOR (3 downto 0);
	signal data1_tmp1, data1_tmp2, data2_tmp1, data2_tmp2: STD_LOGIC_VECTOR (3 downto 0);
	begin
		SF_CE0 <='1';
		reloj: process (clk)   -- DIVISOR DE FRECUENCIA DE 50 MHz a 500 Hz
		       variable cuenta:integer range 0 to 100000:=0;
               begin
             		if(clk'event and clk='1') then
						  if (cuenta < 100000) then
                      cuenta:=cuenta + 1;
						  else
							 cuenta := 0;
						  end if;	 
							if (cuenta < 50000) then
							 E <= '0';
							else
							 E <= '1';
							end if;	
						end if;
				 end process reloj;
		SEC_maquina: process(E, reset)  --- PARTE SECUENCIAL DE LA MAQUINA DE ESTADOS
				begin
					if(E'event and E='1') then
					 if(reset='1') then
					   pr_state <= FI1A;
					 else	
						pr_state <= nx_state;
					 end if;
					end if; 
				end process SEC_maquina;
		COMB_maquina: process (pr_state) --- PARTE COMBINATORIA DE LA MAQUINA DE ESTADOS
           begin
            case pr_state is
				  when FI1A =>      ----- INICIO código $28 SELECCIÓM DEL BUS DE 4 BITS 
					RS <='0'; RW<='0';
					DB <="0010";
					nx_state <= FI1B;
				  when FI1B =>
					RS <='0'; RW<='0';
					DB <="1000";
					nx_state <= FI2A;
				  when FI2A =>
					RS <='0'; RW<='0';
					DB <="0010";
					nx_state <= FI2B;
				  when FI2B =>
					RS <='0'; RW<='0';
					DB <="1000";
					nx_state <= FI3A;
				  when FI3A =>
					RS <='0'; RW<='0';
					DB <="0010";
					nx_state <= FI3B;
				  when FI3B =>
					RS <='0'; RW<='0';
					DB <="1000";       ----- FIN código $28 SELECCIÓM DEL BUS DE 4 BITS
					nx_state <= BOR1;
					when BOR1 =>       ----- INICIO código $01 BORRA LA PANTALLA Y CURSOR A CASA
					RS <='0'; RW<='0';
					DB <="0000";
					nx_state <= BOR2;
					when BOR2 =>
					RS <='0'; RW<='0';
					DB <="0001";       ----- FIN código $01 BORRA LA PANTALLA Y CURSOR A CASA 
					nx_state <= CONT1;
					when CONT1 =>      ----- INICIO código $0C ACTIVA LA PANTALLA
					RS <='0'; RW<='0';
					DB <="0000";
					nx_state <= CONT2;
					when CONT2 =>
					RS <='0'; RW<='0';
					DB <="1100";       ----- FIN código $0C ACTIVA LA PANTALLA
					nx_state <= MOD1;
					when MOD1 =>       ----- INICIO código $06 INCREMENTA CURSOR EN LA PANTALLA 
					RS <='0'; RW<='0';
					DB <="0000";
					nx_state <= MOD2;
					when MOD2 =>
					RS <='0'; RW<='0';
					DB <="0110";       ----- FIN código $06 INCREMENTA CURSOR EN LA PANTALLA 
					nx_state <=zero1;
					when zero1 =>         ----- INICIO "0x"
					RS <='1'; RW<='0';
					DB <="0011";
					nx_state <= zero2;
					when zero2 =>
					RS <='1'; RW<='0';
					DB <="0000";
					nx_state <= x1;
					when x1 =>
					RS <='1'; RW<='0';
					DB <="0111";
					nx_state <= x2;
					when x2 =>
					RS <='1'; RW<='0';
					DB <="1000";
					nx_state <= hex1;
					when hex1 =>
					RS <='1'; RW<='0';
					DB <=data1_tmp1;
					nx_state <= hex2;
					when hex2 =>
					RS <='1'; RW<='0';
					DB <=data1_tmp2;
					nx_state <= hex3;
					when hex3 =>
					RS <='1'; RW<='0';
					DB <=data2_tmp1;
					nx_state <= hex4;
					when hex4 =>
					RS <='1'; RW<='0';
					DB <=data2_tmp2;
					nx_state <= rl1;
					when rl1 =>
					RS <='0'; RW<='0';
					DB <= "0001";
					nx_state <= rl2;
					when rl2 =>
					RS <='0'; RW<='0';
					DB <= "0000";
					nx_state <= rl3;
					when rl3 =>
					RS <='0'; RW<='0';
					DB <= "0001";
					nx_state <= rl4;
					when rl4 =>
					RS <='0'; RW<='0';
					DB <= "0000";
					nx_state <= hex1;
					when done1 =>
					RS <='0'; RW<='0';
					DB <="1000";
					nx_state <= done2;
					when done2 =>
					RS <='0'; RW<='0';
					DB <="0000";
					nx_state <= done1;
	         end case;
end process COMB_maquina;

to_hex_data1: process(data)
	variable data1 : STD_LOGIC_VECTOR (3 downto 0);
begin
	data1 := data(7 downto 4);
	case data1 is
		when "0000" =>
			data1_tmp1 <= "0011";
			data1_tmp2 <= "0000";
		when "0001" =>
			data1_tmp1 <= "0011";
			data1_tmp2 <= "0001";
		when "0010" =>
			data1_tmp1 <= "0011";
			data1_tmp2 <= "0010";
		when "0011" =>
			data1_tmp1 <= "0011";
			data1_tmp2 <= "0011";
		when "0100" =>
			data1_tmp1 <= "0011";
			data1_tmp2 <= "0100";
		when "0101" =>
			data1_tmp1 <= "0011";
			data1_tmp2 <= "0101";
		when "0110" =>
			data1_tmp1 <= "0011";
			data1_tmp2 <= "0110";
		when "0111" =>
			data1_tmp1 <= "0011";
			data1_tmp2 <= "0111";
		when "1000" =>
			data1_tmp1 <= "0011";
			data1_tmp2 <= "1000";
		when "1001" =>
			data1_tmp1 <= "0011";
			data1_tmp2 <= "1001";
		when "1010" =>
			data1_tmp1 <= "0100";
			data1_tmp2 <= "0001";
		when "1011" =>
			data1_tmp1 <= "0100";
			data1_tmp2 <= "0010";
		when "1100" =>
			data1_tmp1 <= "0100";
			data1_tmp2 <= "0011";
		when "1101" =>
			data1_tmp1 <= "0011";
			data1_tmp2 <= "0100";
		when "1110" =>
			data1_tmp1 <= "0011";
			data1_tmp2 <= "0101";
		when "1111" =>
			data1_tmp1 <= "0011";
			data1_tmp2 <= "0110";
		when others =>
			data1_tmp1 <= "0000";
			data1_tmp2 <= "0000";
	end case;
end process;

to_hex_data2: process(data)
	variable data2 : STD_LOGIC_VECTOR (3 downto 0);
begin
	data2 := data(3 downto 0);
	case data2 is
		when "0000" =>
			data2_tmp1 <= "0011";
			data2_tmp2 <= "0000";
		when "0001" =>
			data2_tmp1 <= "0011";
			data2_tmp2 <= "0001";
		when "0010" =>
			data2_tmp1 <= "0011";
			data2_tmp2 <= "0010";
		when "0011" =>
			data2_tmp1 <= "0011";
			data2_tmp2 <= "0011";
		when "0100" =>
			data2_tmp1 <= "0011";
			data2_tmp2 <= "0100";
		when "0101" =>
			data2_tmp1 <= "0011";
			data2_tmp2 <= "0101";
		when "0110" =>
			data2_tmp1 <= "0011";
			data2_tmp2 <= "0110";
		when "0111" =>
			data2_tmp1 <= "0011";
			data2_tmp2 <= "0111";
		when "1000" =>
			data2_tmp1 <= "0011";
			data2_tmp2 <= "1000";
		when "1001" =>
			data2_tmp1 <= "0011";
			data2_tmp2 <= "1001";
		when "1010" =>
			data2_tmp1 <= "0100";
			data2_tmp2 <= "0001";
		when "1011" =>
			data2_tmp1 <= "0100";
			data2_tmp2 <= "0010";
		when "1100" =>
			data2_tmp1 <= "0100";
			data2_tmp2 <= "0011";
		when "1101" =>
			data2_tmp1 <= "0011";
			data2_tmp2 <= "0100";
		when "1110" =>
			data2_tmp1 <= "0011";
			data2_tmp2 <= "0101";
		when "1111" =>
			data2_tmp1 <= "0011";
			data2_tmp2 <= "0110";
		when others =>
			data2_tmp1 <= "0000";
			data2_tmp2 <= "0000";
	end case;
end process;

end Behavioral;

