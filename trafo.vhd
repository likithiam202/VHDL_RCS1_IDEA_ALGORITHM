----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Likith Shivakumar Gowda
-- 
-- Create Date:    14:24:01 05/12/2023 
-- Design Name: 
-- Module Name:    trafo - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Design for output transformation step
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

entity trafo is
    Port ( X1 : in  STD_LOGIC_VECTOR (15 downto 0);
           X2 : in  STD_LOGIC_VECTOR (15 downto 0);
           X3 : in  STD_LOGIC_VECTOR (15 downto 0);
           X4 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z1 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z2 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z3 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z4 : in  STD_LOGIC_VECTOR (15 downto 0);
           Y1 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y2 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y3 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y4 : out  STD_LOGIC_VECTOR (15 downto 0));
end trafo;

architecture Behavioral of trafo is

-- Componenet declaration outside the begin of architecture block
component mulop is
    Port ( I_1 : in  STD_LOGIC_VECTOR (15 downto 0);
           I_2 : in  STD_LOGIC_VECTOR (15 downto 0);
           O_1 : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component addop is
    Port ( I1 : in  STD_LOGIC_VECTOR (15 downto 0);
           I2 : in  STD_LOGIC_VECTOR (15 downto 0);
           O : out  STD_LOGIC_VECTOR (15 downto 0));
end component;
begin

mulop_inst1: mulop
	port map (
		I_1 => X1,
		I_2 => Z1,
		O_1 => Y1
	);

addop_inst1: addop
	port map (
		I1 => X3,
		I2 => Z2,
		O => Y2
	);
	
addop_inst2: addop
	port map (
		I1 => X2,
		I2 => Z3,
		O => Y3
	);

mulop_inst2: mulop
	port map(
		I_1 => X4,
		I_2 => Z4,
		O_1 => Y4
	);
end Behavioral;
