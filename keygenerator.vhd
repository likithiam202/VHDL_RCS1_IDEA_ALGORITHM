----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:55:07 06/11/2023 
-- Design Name: 
-- Module Name:    keygenerator - Behavioral 
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

entity keygenerator is
    Port ( KEY : in  STD_LOGIC_VECTOR (127 downto 0);
           ROUND : in  STD_LOGIC_VECTOR (3 downto 0);
           KEY1 : out  STD_LOGIC_VECTOR (15 downto 0);
           KEY2 : out  STD_LOGIC_VECTOR (15 downto 0);
           KEY3 : out  STD_LOGIC_VECTOR (15 downto 0);
           KEY4 : out  STD_LOGIC_VECTOR (15 downto 0);
           KEY5 : out  STD_LOGIC_VECTOR (15 downto 0);
           KEY6 : out  STD_LOGIC_VECTOR (15 downto 0));
end keygenerator;

architecture Behavioral of keygenerator is

type all_partial_key_array is array(51 downto 0) of STD_LOGIC_VECTOR(15 downto 0);
SIGNAL all_key : all_partial_key_array;

begin

keyChangeProcess: process (KEY)
	variable count: integer range 0 to 51;
	variable circularShiftedKey: STD_LOGIC_VECTOR(127 downto 0);
	begin
		count := 0;
		circularShiftedKey := KEY;
		
		-- 6 * 8 = 48 keys of rounds
		for rounds_shift in 0 to 5 loop
			for partial_keys in 0 to 7 loop
				all_key(count) <= circularShiftedKey(127-(16 * partial_keys) downto (128 - ((partial_keys+1)*16)));
				count := count + 1;
			end loop;
			circularShiftedKey := circularShiftedKey(102 downto 0) & circularShiftedKey(127 downto 103);
		end loop;
		
		-- 4 keys of output transformation after 8 rounds
		for output_transform in 0 to 3 loop
			all_key(count) <= circularShiftedKey(127-(16 * output_transform) downto (128 - ((output_transform+1)*16)));
			count := count + 1;
		end loop;
end process;

	roundKeyAssignmentProcess: process(ROUND) begin
		case(ROUND) is
			when "0000" => 
				KEY1 <= all_key(0);
				KEY2 <= all_key(1);
				KEY3 <= all_key(2);
				KEY4 <= all_key(3);
				KEY5 <= all_key(4);
				KEY6 <= all_key(5);
			when "0001" => 
				KEY1 <= all_key(6);
				KEY2 <= all_key(7);
				KEY3 <= all_key(8);
				KEY4 <= all_key(9);
				KEY5 <= all_key(10);
				KEY6 <= all_key(11);
			when "0010" => 
				KEY1 <= all_key(12);
				KEY2 <= all_key(13);
				KEY3 <= all_key(14);
				KEY4 <= all_key(15);
				KEY5 <= all_key(16);
				KEY6 <= all_key(17);
			when "0011" => 
				KEY1 <= all_key(18);
				KEY2 <= all_key(19);
				KEY3 <= all_key(20);
				KEY4 <= all_key(21);
				KEY5 <= all_key(22);
				KEY6 <= all_key(23);
			when "0100" => 
				KEY1 <= all_key(24);
				KEY2 <= all_key(25);
				KEY3 <= all_key(26);
				KEY4 <= all_key(27);
				KEY5 <= all_key(28);
				KEY6 <= all_key(29);
			when "0101" => 
				KEY1 <= all_key(30);
				KEY2 <= all_key(31);
				KEY3 <= all_key(32);
				KEY4 <= all_key(33);
				KEY5 <= all_key(34);
				KEY6 <= all_key(35);
			when "0110" => 
				KEY1 <= all_key(36);
				KEY2 <= all_key(37);
				KEY3 <= all_key(38);
				KEY4 <= all_key(39);
				KEY5 <= all_key(40);
				KEY6 <= all_key(41);
			when "0111" => 
				KEY1 <= all_key(42);
				KEY2 <= all_key(43);
				KEY3 <= all_key(44);
				KEY4 <= all_key(45);
				KEY5 <= all_key(46);
				KEY6 <= all_key(47);
			when "1000" => 
				KEY1 <= all_key(48);
				KEY2 <= all_key(49);
				KEY3 <= all_key(50);
				KEY4 <= all_key(51);
				KEY5 <= "0000000000000000";
				KEY6 <= "0000000000000000";
			when others => 
				KEY1 <= "0000000000000000";
				KEY2 <= "0000000000000000";
				KEY3 <= "0000000000000000";
				KEY4 <= "0000000000000000";
				KEY5 <= "0000000000000000";
				KEY6 <= "0000000000000000";
		end case;
	end process;
end Behavioral;

