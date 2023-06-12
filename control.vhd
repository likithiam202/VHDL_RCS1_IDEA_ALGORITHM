----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:     
-- Design Name: 
-- Module Name:    control - Behavioral 
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

entity control is
    Port ( CLK : in  STD_LOGIC;
           START : in  STD_LOGIC;
           ROUND : out  STD_LOGIC_VECTOR (3 downto 0);
           READY : out  STD_LOGIC;
           EN : out  STD_LOGIC;
           S : out  STD_LOGIC);
end control;

architecture Behavioral of control is

type CONTROL_STATE is (START_STATE, R0, R1, R2, R3, R4, R5, R6, R7, R8);
signal CURRENT_STATE, NEXT_STATE : CONTROL_STATE;

begin

	State_Transition_Process: process(CLK, START)
		begin
			if(rising_edge(CLK)) then
				CURRENT_STATE <= NEXT_STATE;
			end if;
	end process;
	
	Round_Initiation_Process: process(CURRENT_STATE, START) -- START is needed in sensitivity list here to get the state transistions
		begin
		
		case CURRENT_STATE is
		
			when START_STATE =>
				ROUND <= "1000";
				EN <= '0';
				S <= '1';
				READY <= '1';
					if START = '1' then
						NEXT_STATE <= R0;
					elsif START = '0' then
						NEXT_STATE <= START_STATE;
					end if;
				
			when R0 => -- Round 1
				ROUND <= "0000";
				EN <= '1';
				S <= '0';
				READY <= '0';
				NEXT_STATE <= R1;
			
			when R1 => -- Round 2
				ROUND <= "0001";
				EN <= '1';
				S <= '1';
				READY <= '0';
				NEXT_STATE <= R2;
				
			when R2 => -- Round 3
				ROUND <= "0010";
				EN <= '1';
				S <= '1';
				READY <= '0';
				NEXT_STATE <= R3;
				
			when R3 => -- ROund 4
				ROUND <= "0011";
				EN <= '1';
				S <= '1';
				READY <= '0';
				NEXT_STATE <= R4;
				
			when R4 => -- Round 5
				ROUND <= "0100";
				EN <= '1';
				S <= '1';
				READY <= '0';
				NEXT_STATE <= R5;

			when R5 => -- Round 6
				ROUND <= "0101";
				EN <= '1';
				S <= '1';
				READY <= '0';
				NEXT_STATE <= R6;

			when R6 => -- Round 7
				ROUND <= "0110";
				EN <= '1';
				S <= '1';
				READY <= '0';
				NEXT_STATE <= R7;

			when R7 => -- Round 8
				ROUND <= "0111";
				EN <= '1';
				S <= '1';
				READY <= '0';
				NEXT_STATE <= R8;
				
			when R8 => -- Output transformation
				ROUND <= "1000";
				EN <= '0';
				S <= '1';
				READY <= '1';
				NEXT_STATE <= START_STATE;
				
			when others => 
		end case;
	end process;
end Behavioral;

