----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Likith Shivakumar Gowda
-- 
-- Create Date:     
-- Design Name: 
-- Module Name:    mulop - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Design for 2**16 + 1 modulo multiplier
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
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mulop is
    Port ( I_1 : in  STD_LOGIC_VECTOR (15 downto 0);
           I_2 : in  STD_LOGIC_VECTOR (15 downto 0);
           O_1 : out  STD_LOGIC_VECTOR (15 downto 0));
end mulop;

architecture Behavioral of mulop is

signal mulVal : STD_LOGIC_VECTOR (33 downto 0);
signal modulo: STD_LOGIC_VECTOR (15 downto 0);
signal qoutient: STD_LOGIC_VECTOR (16 downto 0);
signal tempOutput: STD_LOGIC_VECTOR (16 downto 0);
signal temp_I1: STD_LOGIC_VECTOR (16 downto 0);
signal temp_I2: STD_LOGIC_VECTOR (16 downto 0);

begin
inputValChangeProcess: process (I_1, I_2) begin
	-- Concatenate to get 17 bit default
	temp_I1 <= '0' & I_1;
	temp_I2 <= '0' & I_2;
	-- If any guy is x"0000" assign it to 2^16
	if(I_1 = x"0000") then
		temp_I1 <= "10000000000000000";
	end if;
	
	if(I_2 = x"0000") then
		temp_I2 <= "10000000000000000";
	end if;
end process;

mulVal <= temp_I1 * temp_I2;
-- Modulo of 2^16 is last 16 bits from MSB
modulo <= mulVal(15 downto 0); -- 16 bits
-- Division is like right shift, ex - 8:2^3 / 2 = 4:2^2, so here divided by 2^16 means right shift 16 bits, so remaining 17 out of 33 bits
-- will be the qoutient part
qoutient <= mulVal(32 downto 16); --17 bits

modQuotientChangeProcess: process(modulo, qoutient) begin
	if(modulo >= qoutient) then
		tempOutput <= ('0' & modulo) - qoutient; --concatenating extra '0' to make even subtraction
	else
		tempOutput <= ('0' & modulo) - qoutient + "10000000000000001";
	end if;
end process;
	O_1 <= tempOutput(15 downto 0);

end Behavioral;
